########################################################################
# Image Information
########################################################################
vm_communicator = "ssh"
boot_wait="2s"
boot_command = [
    "c",
    "<wait>linuxefi /images/pxeboot/vmlinuz inst.stage2=hd:LABEL=CentOS-Stream-8-x86_64-dvd inst.ks=http://{{ .HTTPIP }}:{{ .HTTPPort }}/ks.cfg<enter>",
    "initrdefi /images/pxeboot/initrd.img<enter>",
    "boot<enter>"
]
