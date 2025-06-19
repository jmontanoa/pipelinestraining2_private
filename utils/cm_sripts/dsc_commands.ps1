#### Local Configuration Manager (LCM) Configuration commands ####
# Generate LCMPushConfig MOF file
.\dsc-confManager.ps1
# Configure local configuration manager by running LCMPushConfig MOF file
Set-DscLocalConfigurationManager -Path ./LCMPushConfig -Verbose
# Check the current configuration of the local configuration manager
Get-DscLocalConfigurationManager
###################################################################

#### DSC Commands for CreateFileConfig ####
# Generate CreateFileConfig MOF file
.\file-dscConfiguration.ps1
# Configure node by running CreateFileConfig MOF file
Start-DscConfiguration -Path .\CreateFileConfig -Wait -Verbose -Force
# Verify the configuration by checking the status of the node
Test-DscConfiguration
# Get the current configuration of the node
Get-DscConfiguration
###################################################################

#### DSC Commands for FirewallConfig ####
# Install Networking Dsc module
Install-Module -Name NetworkingDsc -Force
# Generate FirewallConfig MOF file
.\dsc-FirewallConf.ps1
# Configure node by running FirewallConfig MOF file
Start-DscConfiguration -Path .\FirewallConfig -Wait -Force -Verbose
# Verify the configuration by checking the status of the node
Test-DscConfiguration
# Get the current configuration of the node
Get-DscConfiguration
###################################################################
