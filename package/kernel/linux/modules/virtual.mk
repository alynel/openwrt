#
# Copyright (C) 2010 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

VIRTUAL_MENU:=Virtualization Support

#
# Hyper-V Drives depends on x86 or x86_64.
#
define KernelPackage/hyperv-balloon
  SUBMENU:=$(VIRTUAL_MENU)
  DEPENDS:=@(TARGET_x86||TARGET_x86_64)
  TITLE:=Microsoft Hyper-V Balloon Driver
  KCONFIG:= \
    CONFIG_HYPERV_BALLOON \
    CONFIG_HYPERVISOR_GUEST=y \
    CONFIG_PARAVIRT=n \
    CONFIG_HYPERV=y
  FILES:=$(LINUX_DIR)/drivers/hv/hv_balloon.ko
  AUTOLOAD:=$(call AutoLoad,06,hv_balloon)
endef

define KernelPackage/hyperv-balloon/description
  Microsofot Hyper-V balloon driver.
endef

$(eval $(call KernelPackage,hyperv-balloon))

define KernelPackage/hyperv-net-vsc
  SUBMENU:=$(VIRTUAL_MENU)
  DEPENDS:=@(TARGET_x86||TARGET_x86_64)
  TITLE:=Microsoft Hyper-V Network Driver
  KCONFIG:= \
    CONFIG_HYPERV_NET \
    CONFIG_HYPERVISOR_GUEST=y \
    CONFIG_PARAVIRT=n \
    CONFIG_HYPERV=y
  FILES:=$(LINUX_DIR)/drivers/net/hyperv/hv_netvsc.ko
  AUTOLOAD:=$(call AutoLoad,35,hv_netvsc)
endef

define KernelPackage/hyperv-net-vsc/description
  Microsoft Hyper-V Network Driver
endef

$(eval $(call KernelPackage,hyperv-net-vsc))

define KernelPackage/hyperv-util
  SUBMENU:=$(VIRTUAL_MENU)
  DEPENDS:=@(TARGET_x86||TARGET_x86_64)
  TITLE:=Microsoft Hyper-V Utility Driver
  KCONFIG:= \
    CONFIG_HYPERV_UTILS \
    CONFIG_HYPERVISOR_GUEST=y \
    CONFIG_PARAVIRT=n \
    CONFIG_HYPERV=y
  FILES:=$(LINUX_DIR)/drivers/hv/hv_util.ko
  AUTOLOAD:=$(call AutoLoad,10,hv_util)
endef

define KernelPackage/hyperv-util/description
  Microsoft Hyper-V Utility Driver
endef

$(eval $(call KernelPackage,hyperv-util))

#
# Hyper-V Storage Drive needs to be in kernel rather than module to load the root fs.
#
define KernelPackage/hyperv-storage
  SUBMENU:=$(VIRTUAL_MENU)
  DEPENDS:=@(TARGET_x86||TARGET_x86_64) +kmod-scsi-core
  TITLE:=Microsoft Hyper-V Storage Driver
  KCONFIG:= \
    CONFIG_HYPERV_STORAGE=y \
    CONFIG_HYPERVISOR_GUEST=y \
    CONFIG_PARAVIRT=n \
    CONFIG_HYPERV=y
  FILES:=$(LINUX_DIR)/drivers/scsi/hv_storvsc.ko
  AUTOLOAD:=$(call AutoLoad,40,hv_storvsc)
endef

define KernelPackage/hyperv-storage/description
  Microsoft Hyper-V Storage Driver
endef

$(eval $(call KernelPackage,hyperv-storage))
