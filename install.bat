@echo off
cls

:: Initialize
echo Initiating Installer
SET provDir="C:\ProgramData\Bit0\Provision"
if not exist %provDir% ( mkdir %provDir% )

set URL=http://Install/Install/install.ps1
set TargetFile=%provDir%\install.ps1


echo Checking which powershell version is installed
reg query "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\PowerShell\3" /v Install > nul
if errorlevel 1 (
    echo Powershell 1 or 2 installed
    echo Downloading installer script
    BITSADMIN /transfer /download %URL% %TargetFile% > nul
) else (
    echo Powershell geq 3 installed
    echo Downloading installer script
    powershell -Command Invoke-WebRequest -OutFile %TargetFile% -Uri %URL%
)
REM xcopy /Y \\198.18.8.56\Install\install.ps1 %provDir%

:: Run Installer
echo( 
echo( 
echo( 
echo Starting Installer
C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe -ExecutionPolicy bypass -Command "cd %provDir%;&'.\install.ps1';Exit;"
REM C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe -ExecutionPolicy bypass -NoExit -Command "cd %provDir%;&'.\install.ps1';Exit;"

echo Installer closed
REM timeout 30

:: Restart Computer
echo( 
echo Restarting Computer
shutdown -r -t 10
echo Press Any key to abort
timeout 30
shutdown -a
