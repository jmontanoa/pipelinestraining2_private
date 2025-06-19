[DSCLocalConfigurationManager()] 
Configuration LCMPushConfig { 
    Node "localhost" { 
        Settings { 
            RefreshMode = "Push" 
            AllowModuleOverwrite = $true 
            ConfigurationMode = "ApplyAndAutoCorrect" 
        } 
    } 
}
LCMPushConfig

