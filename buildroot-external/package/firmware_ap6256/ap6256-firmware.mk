AP6256_FIRMWARE_VERSION = 1.0
AP6256_FIRMWARE_SITE = $(BR2_EXTERNAL_HASSOS_PATH)/package/ap6256-firmware
AP6256_FIRMWARE_SITE_METHOD = local

define AP6256_FIRMWARE_INSTALL_TARGET_CMDS
	$(INSTALL) -D -m 0644 $(@D)/brcmfmac43456-sdio.bin $(TARGET_DIR)/lib/firmware/brcm/brcmfmac43456-sdio.bin
	$(INSTALL) -D -m 0644 $(@D)/brcmfmac43456-sdio.txt $(TARGET_DIR)/lib/firmware/brcm/brcmfmac43456-sdio.txt
	$(INSTALL) -D -m 0644 $(@D)/brcmfmac43456-sdio.clm_blob $(TARGET_DIR)/lib/firmware/brcm/brcmfmac43456-sdio.clm_blob

	ln -sf brcmfmac43456-sdio.bin $(TARGET_DIR)/lib/firmware/brcm/brcmfmac43456-sdio.rockchip,rk3566-orangepi-cm4.bin
	ln -sf brcmfmac43456-sdio.txt $(TARGET_DIR)/lib/firmware/brcm/brcmfmac43456-sdio.rockchip,rk3566-orangepi-cm4.txt

	$(INSTALL) -D -m 0644 $(@D)/BCM4345C5.hcd $(TARGET_DIR)/lib/firmware/brcm/BCM4345C5.hcd
endef

$(eval $(generic-package))
