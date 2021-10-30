######################################
#
# cabsim-IR-loader
#
######################################

MOD_CABSIM_IR_LOADER_VERSION = ad2625d0ad52abe01f0de9d4c4c46450d157e7df
MOD_CABSIM_IR_LOADER_SITE = $(call github,moddevices,mod-cabsim-IR-loader,$(MOD_CABSIM_IR_LOADER_VERSION))
MOD_CABSIM_IR_LOADER_DEPENDENCIES = fftw-single
MOD_CABSIM_IR_LOADER_BUNDLES = cabsim-IR-loader.lv2

MOD_CABSIM_IR_LOADER_TARGET_MAKE = $(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) -C $(@D)/source DEBUG=true

ifdef BR2_cortex_a35
MOD_CABSIM_IR_LOADER_WISDOM_FILE = cabsim.wisdom.dwarf
else ifdef BR2_cortex_a53
MOD_CABSIM_IR_LOADER_WISDOM_FILE = cabsim.wisdom.duox
else ifdef BR2_arm
MOD_CABSIM_IR_LOADER_WISDOM_FILE = cabsim.wisdom.duo
else ifdef BR2_x86_64
MOD_CABSIM_IR_LOADER_WISDOM_FILE = cabsim.wisdom.x86_64
endif

define MOD_CABSIM_IR_LOADER_BUILD_CMDS
	$(MOD_CABSIM_IR_LOADER_TARGET_MAKE)
endef

define MOD_CABSIM_IR_LOADER_INSTALL_TARGET_CMDS
	$(MOD_CABSIM_IR_LOADER_TARGET_MAKE) install DESTDIR=$(TARGET_DIR) PREFIX=/usr
	cp $($(PKG)_PKGDIR)/$(MOD_CABSIM_IR_LOADER_WISDOM_FILE) $(TARGET_DIR)/usr/lib/lv2/$(MOD_CABSIM_IR_LOADER_BUNDLES)/cabsim.wisdom
endef

$(eval $(generic-package))
