New-NetFirewallRule `
    -Name "TCP Query User {$([guid]::NewGuid().ToString()).}C:\Program Files\Docker\Docker\resources\com.docker.backend.exe" `
    -DisplayName "Docker Desktop Backend" `
    -Description "Docker Desktop Backend" `
    -Action Allow `
    -Enabled True `
    -Profile Public `
    -Direction Inbound `
    -LooseSourceMapping $false `
    -LocalOnlyMapping $false `
    -EdgeTraversalPolicy DeferToUser `
    -Protocol TCP `
    -Program "C:\Program Files\Docker\Docker\resources\com.docker.backend.exe"

New-NetFirewallRule `
    -Name "TCP Query User {$([guid]::NewGuid().ToString()).}C:\Program Files\Docker\Docker\resources\com.docker.backend.exe" `
    -DisplayName "Docker Desktop Backend" `
    -Description "Docker Desktop Backend" `
    -Action Allow `
    -Enabled True `
    -Profile Public `
    -Direction Inbound `
    -LooseSourceMapping $false `
    -LocalOnlyMapping $false `
    -EdgeTraversalPolicy DeferToUser `
    -Protocol UDP `
    -Program "C:\Program Files\Docker\Docker\resources\com.docker.backend.exe"