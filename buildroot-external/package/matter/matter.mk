MATTER_VERSION = 1.0.0
MATTER_SITE = $(BR2_EXTERNAL_IHOST_PATH)/package/matter
MATTER_SITE_METHOD = local

define MATTER_INSTALL_TARGET_CMDS
	$(INSTALL) -m 0755 $(@D)/bin/matter_storage $(TARGET_DIR)/usr/bin/matter_storage
	$(INSTALL) -m 0755 $(@D)/bin/tee-supplicant $(TARGET_DIR)/usr/bin/tee-supplicant
	$(INSTALL) -m 0644 $(@D)/service/tee-supplicant.service $(TARGET_DIR)/usr/lib/systemd/system/tee-supplicant.service
	$(INSTALL) -D -m 0755 -d $(TARGET_DIR)/usr/lib/optee_armtz/
	cp -r $(@D)/lib/optee_armtz/* $(TARGET_DIR)/usr/lib/optee_armtz/
	$(INSTALL) -m 0644 $(@D)/lib/libteec.so.1 $(TARGET_DIR)/usr/lib/
endef

define MATTER_USERS
	tee-supplicant -1 tee-supplicant -1 * /mnt/data/tee /bin/false - TEE supplicant user
endef


$(eval $(generic-package))
