

# SOURCES
########################################################################
########################################################################
#######################    Linux   ####################################
########################################################################
########################################################################
source "vsphere-iso" "linux" {
########################################################################
# Server Connection Details
########################################################################
  vcenter_server      = var.vsphere_server
  username            = var.vsphere_username
  password            = var.vsphere_password
  insecure_connection = var.vsphere_insecure_connection
########################################################################
# SSH Connection Details
########################################################################
  communicator          = var.vm_communicator
  ssh_username          = var.ssh_username
  ssh_password          = var.ssh_password
  ssh_timeout           = var.ssh_timeout
  ssh_handshake_attempts = var.ssh_handshake_attempts

########################################################################
# Image Build Location Details
########################################################################
  #host                = var.vsphere_host
  cluster             = var.vsphere_cluster
  datastore           = var.vsphere_datastore
  folder              = var.vsphere_folder
  convert_to_template = var.vsphere_convert_to_template
  content_library_destination {
    library       = var.vsphere_library
    ovf           = var.is_ovf
    destroy       = var.destroy
  }

########################################################################
# Image Information
########################################################################
  vm_name                 ="pkr_${var.os_family}_${var.os_flavor}_${var.os_version}"
  # Disk Information
  disk_controller_type  = [var.disk_type]
  storage {
    disk_size = var.disk_size
    disk_thin_provisioned = var.disk_thin_provisioned
  }
  # Network Information
  network_adapters {
    network = var.vm_network
    network_card = var.nic_type
  }

  # Hardware Information
  CPUs                  = var.num_cpu
  cpu_cores             = var.num_cores
  CPU_hot_plug          = var.cpu_hot_add
  RAM                   = var.vm_ram
  RAM_hot_plug          = var.ram_hot_add

  # OS Information
  guest_os_type         = var.guest_os_type

  # Files
  iso_paths             = [var.os_iso_path]
  remove_cdrom          = var.remove_cdrom
  iso_checksum          = var.iso_checksum
  # floppy_dirs           = [
  #                           "./scripts/${var.os_family}/${var.os_flavor}/${var.os_version}/"
  #                         ]

  # Other
  firmware              = var.boot_type
  boot_command          = var.boot_command
  ip_wait_timeout       = var.ip_wait_timeout
  boot_wait             = var.boot_wait
  http_directory        = "boot/${var.os_family}/${var.os_flavor}/${var.os_version}/${var.boot_type}"
  
}

source "vsphere-iso" "windows" {
########################################################################
# Server Connection Details
########################################################################
  vcenter_server      = var.vsphere_server
  username            = var.vsphere_username
  password            = var.vsphere_password
  insecure_connection = var.vsphere_insecure_connection
########################################################################
# WiNRM Connection Details
########################################################################
  communicator            = var.vm_communicator
  winrm_username          = var.winrm_connection_username
  winrm_password          = var.winrm_connection_password
  winrm_timeout           = var.winrm_connection_timeout
  winrm_use_ntlm          = var.winrm_use_ntlm
  winrm_no_proxy          = var.winrm_no_proxy
########################################################################
# Image Build Location Details
########################################################################
  #host                = var.vsphere_host
  cluster             = var.vsphere_cluster
  datastore           = var.vsphere_datastore
  folder              = var.vsphere_folder
  convert_to_template = var.vsphere_convert_to_template
  content_library_destination {
    library       = var.vsphere_library
    ovf           = var.is_ovf
    destroy       = var.destroy
  }

########################################################################
# Image Information
########################################################################
  vm_name                 ="pkr_${var.os_family}_${var.os_flavor}_${var.os_version}"
  # Disk Information
  disk_controller_type  = [var.disk_type]
  storage {
    disk_size = var.disk_size
    disk_thin_provisioned = var.disk_thin_provisioned
  }
  # Network Information
  network_adapters {
    network = var.vm_network
    network_card = var.nic_type
  }

  # Hardware Information
  CPUs                  = var.num_cpu
  cpu_cores             = var.num_cores
  CPU_hot_plug          = var.cpu_hot_add
  RAM                   = var.vm_ram
  RAM_hot_plug          = var.ram_hot_add

  # OS Information
  guest_os_type         = var.guest_os_type

  # Files
  iso_paths             = [var.os_iso_path, "[] /usr/lib/vmware/isoimages/windows.iso"]
  remove_cdrom          = var.remove_cdrom
  iso_checksum          = var.iso_checksum
  floppy_files          = [
                            "./boot/${var.os_family}/${var.os_flavor}/${var.os_version}/${var.boot_type}/autounattend.xml",
                            "./scripts/${var.os_family}/${var.os_flavor}/setup.ps1",
                            "./scripts/${var.os_family}/vmtools.cmd"
                          ]
  # floppy_dirs           = [
  #                           "./scripts/${var.os_family}/${var.os_flavor}/${var.os_version}/"
  #                         ]

  # Other
  firmware              = var.boot_type
  boot_command          = var.boot_command
  ip_wait_timeout       = var.ip_wait_timeout
  boot_wait             = var.boot_wait

}

# BUILDS
########################################################################
########################################################################
#######################    Linux   ####################################
########################################################################
########################################################################
build {
    sources = [
        "source.vsphere-iso.linux",
    ]

    provisioner "file" {
      source      = "scripts/${var.os_family}/${var.os_flavor}/${var.os_version}"
      destination = "/tmp"
    }

    provisioner "shell" {
      execute_command = "echo '${var.ssh_password}' | {{.Vars}} sudo -S -E sh '{{.Path}}'" # This runs the scripts with sudo
      inline = [
                  "mkdir /scripts",
                  "mv /tmp/${var.os_version}/* /scripts/"
                ]
    }

    provisioner "shell" {
      environment_vars = ["SUBSCRIPTION_MANAGER_USERNAME=${var.subscription_manager_username}","SUBSCRIPTION_MANAGER_PASSWORD=${var.subscription_manager_password}"]
      execute_command = "echo '${var.ssh_password}' | {{.Vars}} sudo -S -E sh '{{.Path}}'" # This runs the scripts with sudo
      scripts = [
                  "scripts/${var.os_family}/${var.os_flavor}/proxy.sh",
                  "scripts/${var.os_family}/${var.os_flavor}/upgrade.sh",
                  "scripts/${var.os_family}/${var.os_flavor}/install.sh",
                  "scripts/${var.os_family}/${var.os_flavor}/accounts.sh",
                  "scripts/${var.os_family}/${var.os_flavor}/run-version-specific.sh",
                  "scripts/${var.os_family}/${var.os_flavor}/tidy.sh"
                ]
    }

}

########################################################################
########################################################################
#######################    Windows   ####################################
########################################################################
########################################################################
build {
    sources = [
      "source.vsphere-iso.windows",
    ]

    provisioner "windows-update" {
      search_criteria = "IsInstalled=0"
      filters = [
        "exclude:$_.Title -like '*Preview*'",
        "include:$true",
      ]
    }

    provisioner "file" {
      source      = "scripts/${var.os_family}/${var.os_flavor}/${var.os_version}/"
      destination = "c:\\scripts"
    }

    provisioner "powershell" {
      elevated_user = var.winrm_connection_username
      elevated_password = var.winrm_connection_password
      scripts = [
                  "scripts/${var.os_family}/remove-update-cache.ps1",
                  "scripts/${var.os_family}/reset-empty-space.ps1",
                  "scripts/${var.os_family}/boothole-fix.ps1",
                  "scripts/${var.os_family}/sweet32-fix.ps1",
                  "scripts/${var.os_family}/disable-tls1.ps1",
                  "scripts/${var.os_family}/run-version-specific.ps1",
                  "scripts/${var.os_family}/tidy.ps1"
                ]
    }

}