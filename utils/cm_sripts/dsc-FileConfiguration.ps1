Configuration CreateFileConfig { 
    Import-DscResource -ModuleName 'PSDesiredStateConfiguration'
    Node "localhost" { 
        File ExampleFile { 
            DestinationPath = "C:\Temp\example.txt" 
            Contents        = "Managed by DSC" 
            Ensure          = "Present" 
            Type            = "File" 
        } 
    } 
}
CreateFileConfig
