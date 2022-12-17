########################################################################
# Image Information
########################################################################
vm_communicator = "ssh"
boot_wait="5s"
boot_command = [
  "<esc>",
  "<wait>linux inst.ks=http://{{ .HTTPIP }}:{{ .HTTPPort }}/ks.cfg<enter>"
]
