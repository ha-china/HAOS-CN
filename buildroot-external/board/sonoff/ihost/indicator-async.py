#!/usr/bin/python3

import asyncio
import crcmod
#import logging
import serial
import struct
debug = True

crc16 = crcmod.mkCrcFun(0x11021, initCrc=0)

BUTTON: dict[str, str] = {
    'POWER': b'\x00',
    'PAIRING': b'\x01',
    'SECURITY': b'\x02',
    'MUSIC': b'\x03',
    'RESET': b'\x04',
}
CMD_TYPE: dict[str, str] = {
    'REQUEST': b'\x00',
    'RESPONSE': b'\x40',
    'NOTIFY': b'\x80',
}

COMMAND: dict[str, str] = {
	'VERSION_YC': b'\x01',
	'VERSION_RK': b'\x02',
	'REPORT_EVENT': b'\x03',
	'CONTROL_LED': b'\x04',
	'REPORT_LED': b'\x05',
	'BROADCAST_ID': b'\x06',
	'QUERY_LED': b'\x07',
}
SOF = b'\xFE'
VERSION = b'\x00\x00\x01'

class SerialInterface:
    def __init__(self):
        self.port = '/dev/ttyS3'
        self.baudrate = 115200

    def open(self):
        try:
            self.serial = serial.Serial(port=self.port,
                baudrate=self.baudrate,
                parity=serial.PARITY_NONE,
                stopbits=serial.STOPBITS_ONE,
                timeout=3)
        except Exception as e:
            raise Exception("PORT ERROR: %s" % str(e))
        print("Serial Connected %s" % self.port)

    def close(self):
        self.serial.close()

class Frame:
    mtype = b'\x00'
    cmd = b'\x00'
    seq = b'\x00'
    data = bytearray()
    
    def __init__(self, seq:bytes(1)=b'\x00', msg:bytearray=None):
        if msg:
            self.unpack(msg)
        else:
            self.seq = seq
 
    def build(self, mtype:bytes(1), cmd:bytes(1), data:bytearray=b'\x00'):
        self.mtype = mtype
        self.cmd = cmd
        self.data = data

    #can call multiple times, but no checking for duplicate idx's
    def led(self, idx:int, effect:int, rgb:tuple):
        #need input validation checking on rgb tuple?
        self.cmd = COMMAND["CONTROL_LED"]
        self.data += struct.pack(">cc3s", idx.to_bytes(), effect.to_bytes(), bytearray(rgb))

    def pack(self) -> bytearray:
        N=len(self.data)
        frame = struct.pack(f">cHccc{N}s", SOF, N+8, self.mtype, self.cmd, self.seq, self.data )
        frame += crc16(frame).to_bytes(2)
        return frame

    def unpack(self, packet:bytearray) -> None:
        N = len(packet) - 8
        tuple = struct.unpack(f">cHccc{N}sH", packet)
        sof, dlen, self.mtype, self.cmd, self.seq, self.data, crc = tuple
        #check crc here?

    def unpackButton(self) -> bytes(1):
        # double and long press dont seem supported
        if self.cmd == COMMAND['REPORT_EVENT']:
            idx, event, param = struct.unpack(">ccH", self.data)
            if idx == BUTTON['PAIRING']:
                print('Zigbee Pairing')
            return idx

    #not tested
    def unpackLed(self):
        data = self.data
        result = []
        if self.cmd == COMMAND['REPORT_LED']:
            while len(data) >= 5:
                led = data[:5]
                # tuple = (idx, effect, rgb)
                tuple = struct.unpack(">cc3s", led)
                data = data[5:]
                result.push(tuple)
            return result
        
class yProtocol:
    g_seq = 0
    has_init = False
    def __init__(self):
        self.serial = SerialInterface()
        self.serial.open()
        self.ser = self.serial.serial

    def checkCRC(self, packet:bytearray) -> bool:
        calc_crc = crc16(packet[:-2])
        return calc_crc.to_bytes(2) == packet[-2:]

    def getFrame(self) -> Frame:
        packet = bytearray()
        start = b''

        #include a timeout below
        # while start != SOF:
        #     start = self.ser.read(1)
        start = self.ser.read(1)
        if start != SOF:
            return None
        packet = SOF
        lenbytes = self.ser.read(2)

        packet += lenbytes
        lenint = int.from_bytes(lenbytes) - 3
        packet += self.ser.read(lenint)

        if debug:
            print('[frame] '+' '.join(format(x, '02x') for x in packet))

        if self.checkCRC(packet):
            frame = Frame(msg=packet)
            self.sendAck(frame)
            return frame
        return None

    def nextSeq(self) -> bytes:
        self.g_seq += 1
        return self.g_seq.to_bytes(1)

    def sendAck(self, frame:Frame) -> None:
        ct_r = CMD_TYPE["RESPONSE"]

        if frame.mtype == CMD_TYPE["REQUEST"]:
            response = Frame(frame.seq)
            if frame.cmd == COMMAND["VERSION_RK"]:
                response.build(ct_r, COMMAND["VERSION_RK"], VERSION)
            elif frame.cmd == COMMAND["REPORT_LED"]:
                response.build(ct_r, COMMAND["REPORT_LED"])
                self.has_init = True
            elif frame.cmd == COMMAND["REPORT_EVENT"]:
                idx = frame.unpackButton()
                response.build(ct_r, COMMAND["REPORT_EVENT"])
            self.sendFrame(response)

    def sendFrame(self, frame:Frame) -> None:
        packet = frame.pack()
        if debug:
            title = "res" if frame.mtype == CMD_TYPE["RESPONSE"] else "req"
            print(f"[{title}] "+' '.join(format(x, '02x') for x in packet))
        self.ser.write(packet)
    
    async def listener(self) -> None:
        while True:
            try:
                ret = self.getFrame()
            except KeyboardInterrupt:
                print("Disconnecting")
                self.serial.close()
                exit()
            await asyncio.sleep(0)

if __name__ == "__main__":
    comm = yProtocol()
    indicator = Frame(comm.nextSeq())
    rgb =  (255,0,0)
    indicator.led(4, 1, rgb)
    comm.sendFrame(indicator)

    asyncio.run(comm.listener())
    print("set green")
    indicator = Frame(comm.nextSeq())
    rgb =  (0,255,0)
    indicator.led(4, 1, rgb)
    comm.sendFrame(indicator)
    #ret = comm.getFrame()
