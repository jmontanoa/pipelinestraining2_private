#### Included rules
# Keeps Remote Desktop enabled.
# Allows Windows Remote Management (WinRM) for PowerShell remoting.
# Allows ICMPv4 Echo Request (ping) for basic network diagnostics.
# Allows DNS (UDP 53) if the server is acting as a resolver.
# Leaves default outbound as "Allow" to ensure internet and domain services still work.
Configuration FirewallConfig {
    Import-DscResource -ModuleName NetworkingDsc

    Node "localhost" {

        # 1. Allow RDP
        Firewall Allow_RDP {
            Name        = "Allow RDP"
            Ensure      = "Present"
            Enabled     = "True"
            Direction   = "Inbound"
            Action      = "Allow"
            LocalPort   = "3389"
            Protocol    = "TCP"
            Profile     = "Any"
            Description = "Allow Remote Desktop"
        }

        # 2. Allow WinRM over HTTP (port 5985)
        Firewall Allow_WinRM_HTTP {
            Name        = "Allow WinRM HTTP"
            Ensure      = "Present"
            Enabled     = "True"
            Direction   = "Inbound"
            Action      = "Allow"
            LocalPort   = "5985"
            Protocol    = "TCP"
            Profile     = "Any"
            Description = "Allow PowerShell Remoting (HTTP)"
        }

        # 3. Allow ICMPv4 (Ping)
        Firewall Allow_Ping {
            Name        = "Allow ICMPv4-In"
            Ensure      = "Present"
            Enabled     = "True"
            Direction   = "Inbound"
            Action      = "Allow"
            Protocol    = "ICMPv4"
            Profile     = "Any"
            Description = "Allow Ping Requests"
        }

        # 4. Allow DNS if needed (UDP 53) – only include if server is a DNS target
        Firewall Allow_DNS {
            Name        = "Allow DNS Requests"
            Ensure      = "Present"
            Enabled     = "True"
            Direction   = "Inbound"
            Action      = "Allow"
            LocalPort   = "53"
            Protocol    = "UDP"
            Profile     = "Any"
            Description = "Allow DNS Inbound Queries"
        }

        # 5. Set firewall profiles to block all other inbound traffic
        FirewallProfile DomainProfile {
            Name                  = "Domain"
            DefaultInboundAction  = "Block"
            DefaultOutboundAction = "Allow"
        }

        FirewallProfile PrivateProfile {
            Name                  = "Private"
            DefaultInboundAction  = "Block"
            DefaultOutboundAction = "Allow"
        }

        FirewallProfile PublicProfile {
            Name                  = "Public"
            DefaultInboundAction  = "Block"
            DefaultOutboundAction = "Allow"
        }
    }
}
FirewallConfig
