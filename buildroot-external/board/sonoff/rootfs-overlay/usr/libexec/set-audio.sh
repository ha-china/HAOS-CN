#!/bin/sh
amixer -c 1 cset numid=1,iface=MIXER,name='Master Playback Volume' 255
amixer -c 1 cset numid=4,iface=MIXER,name='Playback Mux' 'SPK'