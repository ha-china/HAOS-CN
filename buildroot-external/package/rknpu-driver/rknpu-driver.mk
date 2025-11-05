################################################################################
#
# rknpu-driver
#
################################################################################

RKNPU_DRIVER_VERSION = 0.9.8_20241009
RKNPU_DRIVER_SOURCE = rknpu_driver_$(RKNPU_DRIVER_VERSION).tar.bz2
RKNPU_DRIVER_SITE = https://github.com/airockchip/rknn-llm/raw/main/rknpu-driver
RKNPU_DRIVER_LICENSE = GPL-2.0
RKNPU_DRIVER_LICENSE_FILES = LICENSE

# Define kernel module build
define RKNPU_DRIVER_BUILD_CMDS
	$(TARGET_CONFIGURE_OPTS) $(MAKE) -C $(@D) \
		KERNEL_SRC=$(LINUX_DIR) \
		CROSS_COMPILE=$(TARGET_CROSS) \
		ARCH=$(KERNEL_ARCH) \
		modules
endef

define RKNPU_DRIVER_INSTALL_TARGET_CMDS
	$(TARGET_CONFIGURE_OPTS) $(MAKE) -C $(@D) \
		KERNEL_SRC=$(LINUX_DIR) \
		CROSS_COMPILE=$(TARGET_CROSS) \
		ARCH=$(KERNEL_ARCH) \
		INSTALL_MOD_PATH=$(TARGET_DIR) \
		modules_install
endef

# Install udev rules for RKNPU device
define RKNPU_DRIVER_INSTALL_UDEV_RULES
	$(INSTALL) -D -m 0644 $(RKNPU_DRIVER_PKGDIR)/99-rknpu.rules \
		$(TARGET_DIR)/etc/udev/rules.d/99-rknpu.rules
endef

RKNPU_DRIVER_POST_INSTALL_TARGET_HOOKS += RKNPU_DRIVER_INSTALL_UDEV_RULES

$(eval $(kernel-module))
$(eval $(generic-package))