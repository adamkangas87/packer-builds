########################################################################
# Image Information
########################################################################
vm_communicator = "ssh"
boot_wait="5s"
boot_command = [
  "<up> c",
    "<wait>linuxefi /images/pxeboot/vmlinuz inst.ks=http://{{ .HTTPIP }}:{{ .HTTPPort }}/ks.cfg<enter>",
    "initrdefi /images/pxeboot/initrd.img<enter>",
    "boot<enter>"
]
