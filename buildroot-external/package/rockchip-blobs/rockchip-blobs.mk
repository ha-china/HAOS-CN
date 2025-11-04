################################################################################
#
# rockchip-blobs
#
################################################################################

ROCKCHIP_BLOBS_VERSION = $(call qstrip,$(BR2_PACKAGE_ROCKCHIP_BLOBS_VERSION))
ROCKCHIP_BLOBS_SITE = https://github.com/rockchip-linux/rkbin.git
ROCKCHIP_BLOBS_SITE_METHOD = git
ROCKCHIP_BLOBS_LICENSE = Proprietary
ROCKCHIP_BLOBS_INSTALL_IMAGES = YES

# ATF/BL31 and TPL firmware paths from defconfig
ROCKCHIP_BLOBS_ATF = $(call qstrip,$(BR2_PACKAGE_ROCKCHIP_BLOBS_ATF))
ROCKCHIP_BLOBS_TPL = $(call qstrip,$(BR2_PACKAGE_ROCKCHIP_BLOBS_TPL))

# Extract and install firmware binaries
define ROCKCHIP_BLOBS_INSTALL_IMAGES_CMDS
	# Create firmware directory in BINARIES_DIR
	$(INSTALL) -d $(BINARIES_DIR)/rockchip
	
	# Install ATF/BL31 binary if specified
	$(if $(ROCKCHIP_BLOBS_ATF), \
		$(INSTALL) -D -m 0644 $(@D)/$(ROCKCHIP_BLOBS_ATF) \
		$(BINARIES_DIR)/bl31.elf)
	
	# Install TPL/DDR firmware if specified  
	$(if $(ROCKCHIP_BLOBS_TPL), \
		$(INSTALL) -D -m 0644 $(@D)/$(ROCKCHIP_BLOBS_TPL) \
		$(BINARIES_DIR)/ddr.bin)
	
	# Copy all blobs to rockchip directory for reference
	cp -r $(@D)/bin $(BINARIES_DIR)/rockchip/
	
	echo "Rockchip blobs installed successfully"
	echo "ATF: $(ROCKCHIP_BLOBS_ATF)"
	echo "TPL: $(ROCKCHIP_BLOBS_TPL)"
endef

$(eval $(generic-package))