provider "aws" {
  region = "ap-south-1"
  profile = "arn:aws:iam::072513753921:role/custom-ec2-terraform-role"
  # access_key = "AKIARBYRICNAVW2HF5WK"
  # secret_key = "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"
}

resource "aws_instance" "lmco-tc13-awspoc" {
  ami                    = "ami-07d280422a9f5ee93"
  instance_type          = "t3.large"
  key_name               = "shailendra-mumbai-hclawsplm"
  monitoring             = true
  vpc_security_group_ids = ["sg-0df4b19389e5a3734"]
  subnet_id              = "subnet-030516bd5eb774591"
#vpc_id = "vpc-0023f24693d508a16"
  user_data = <<-EOF
                <powershell>
                # $file = $env:SystemRoot + "\Temp\" + (Get-Date).ToString("MM-dd-yy-hh-mm")
                # New-Item $file -ItemType file
                New-PSDrive –Name “D” –PSProvider FileSystem –Root “\\172.18.80.74\Setup” –Persist
                msiexec /package "D:\amazon-corretto-11.0.10.9.1-windows-x64.msi" /quiet  INSTALLDIR=C:\Apps\Java\
                [Environment]::SetEnvironmentVariable("JRE_HOME","C:\Apps\Java\jdk11.0.11_9","Machine")
                [Environment]::SetEnvironmentVariable("JAVA_HOME","C:\Apps\Java\jdk11.0.11_9","Machine")
                Copy-Item -Path "D:\apache-tomcat-9.0.45-windows-x64" -Destination "C:\Apps\" -Recurse
                Copy-Item -Path "D:\Jenkins" -Destination "C:\Apps\Jenkins" -Recurse
                cd C:\Apps\apache-tomcat-9.0.45-windows-x64\apache-tomcat-9.0.45\bin\
                .\service.bat install
                sc.exe config Tomcat9 start=auto
                $action = New-ScheduledTaskAction -Execute 'Powershell.exe' -Argument '-ExecutionPolicy Bypass -File C:\Apps\Jenkins\jenkins.ps1'
                $trigger =  New-ScheduledTaskTrigger -AtStartup 
                $STSet = New-ScheduledTaskSettingsSet -Hidden 
                Register-ScheduledTask -Action $action -User "Administrator" -Password "Plmcloud123#" -Trigger $trigger -TaskName "JenkinsAgentRegister" -Description "This task is used to register slave agents" -Settings $STSet
                Start-ScheduledTask -TaskName "JenkinsAgentRegister"
                </powershell>
              EOF
  
  tags = {
    Name = "lmco-tc13-awspoc"
    Terraform   = "true"
    Environment = "dev"
  }
}
