@echo off
:: Initialize
SET provDir="C:\ProgramData\Bit0\Provision"
mkdir %provDir%
xcopy /Y \\198.18.8.56\Install\install.ps1 %provDir%

:: Install Chocolatey
:: @"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoProfile -InputFormat None -ExecutionPolicy Bypass -Command "iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))"
:: SET "PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin"

:: Run Installer
C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe -ExecutionPolicy bypass -NoExit -Command "cd %provDir%;&'.\install.ps1'"
timeout 30

:: Restart Computer
echo Restarting Computer
shutdown -r -t 10