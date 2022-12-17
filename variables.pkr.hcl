########################################################################
# Server Connection Details
########################################################################
variable "vsphere_server" {
    default = ""
}
variable "vsphere_username" {
}
variable "vsphere_password" {
}
variable "vsphere_insecure_connection" {
    default = true
}
variable "vm_communicator"{
}
########################################################################
# WinRM Connection Details
########################################################################
variable "winrm_connection_username" {
}
variable "winrm_connection_password" {
}
variable "winrm_connection_timeout" {
    default = "1h"
}
variable "winrm_no_proxy" {
    default = true
}
variable "winrm_use_ntlm" {
    default = true
}
########################################################################
# SSH Connection Details
########################################################################
variable "ssh_username" {
}
variable "ssh_password" {
}
variable "ssh_timeout" {
    default = "20m"
}
variable "ssh_handshake_attempts" {
    default = 100
}
########################################################################
# Image Build Location Details
########################################################################
variable "vsphere_datacenter" {
}
variable "vsphere_cluster" {
}
variable "vsphere_datastore" {
}
variable "vsphere_folder" {
}
variable "vsphere_convert_to_template" {
    default = false
}
variable "vsphere_library" {
}
variable "is_ovf" {
    default = true
}
variable "destroy" {
    default = true
}
########################################################################
# Image Information
########################################################################
# Disk Information
variable "disk_size" {
}
variable "disk_type" {
}
variable "disk_thin_provisioned" {
    default = true
}
# Network Information
variable "vm_network" { 
}
variable "nic_type" {
    default = "vmxnet3"
}
# Hardware Information
variable "num_cpu" {
}
variable "cpu_hot_add" {
    default = true
}
variable "num_cores" {
}
variable "vm_ram" {
}
variable "ram_hot_add" {
    default = true
}
# OS Information
variable "guest_os_type" {
}
variable "os_family" {
}
variable "os_flavor" {
}
variable "os_version" {
}
# Files
variable "cd_files" {
    default =[]
}
variable "remove_cdrom" {
    default = true
}
variable "os_iso_path" {
}
variable "iso_checksum" {
    default = ""
}
# Other
variable "boot_type" {
    default="bios"
}
variable "boot_wait" {
    default = "2m"
}
variable "domain_name" {
    default = "company.com"
}
variable "ip_wait_timeout" {
    default = "1h"
}
variable "boot_command" {
    default = []
}
########################################################################
# Build Information
########################################################################
variable "subscription_manager_username"{
}
variable "subscription_manager_password"{
}




