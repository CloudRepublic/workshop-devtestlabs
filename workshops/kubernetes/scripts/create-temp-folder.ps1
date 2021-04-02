New-Item -Path "C:\" -Name "temp" -ItemType Directory -Force

icacls "C:\temp" /grant Everyone:(OI)(CI)F /T