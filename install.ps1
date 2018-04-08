param([String]$profileHost='198.18.8.56')

$profileDir = "http://$profileHost/Install";

Write-Output 'Install Chocolatey';
if (-Not (Get-Command choco -ErrorAction SilentlyContinue)) {
    Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'));
} else {
    Write-Output '  Chocolatey already installed';
}

Write-Output 'Install BoxStarter';
if ((choco list -lo | where { $_.ToLower().StartsWith("Boxstarter".ToLower()) } | measure).Count -eq 0) {
    &choco install Boxstarter -y;
    &'C:\ProgramData\Boxstarter\BoxstarterShell.ps1';
} else {
    Write-Output '  Boxstarter already installed';
}

$sysType = "";
while($sysType -eq "") {
    Write-Output "System Type";
    Write-Output "  Profiles:";
    Write-Output "  1 - Standard";
    Write-Output "  2 - Dev: Common";
    Write-Output "  3 - Dev: Mobile";
    Write-Output "  4 - Dev: Doc";
    Write-Output "  5 - Dev: Multimedia";
    Write-Output "";
    Write-Output "  Special:";
    Write-Output "  A - Arnav"
    Write-Output "  I - Ishan"
    Write-Output "";
    Write-Output "  X - Exit"
    Write-Output "";

    $sysType = read-host "Select profiles(s)";
}

$nums = $sysType.split(",").Trim();

$sysType = "";
while($sysType -eq "") {
    Write-Output "System Type";
    Write-Output "  Profiles:";
    Write-Output "  1 - Standard";
    Write-Output "  2 - Dev: Common";
    Write-Output "  3 - Dev: Mobile";
    Write-Output "  4 - Dev: Doc";
    Write-Output "  5 - Dev: Multimedia";
    Write-Output "";
    Write-Output "  Special:";
    Write-Output "  A - Arnav"
    Write-Output "  I - Ishan"
    Write-Output "";
    Write-Output "  X - Exit"
    Write-Output "";

    $sysType = read-host "Select profiles(s)";
}

$nums = $sysType.split(",").Trim();

Write-Host $nums;

#ForEach($answer in $nums){
#
#    switch ($answer) {
#        1 {uninstall}
#        2 {flashjava}
#        3 {reader}
#        4 {firefox}
#        5 {chrome}
#        6 {office}
#        7 {reader}
#        8 {updates}
#        9 {exit}
#        default {
#            write-host -ForegroundColor red "Invalid Selection"
#            sleep 2
#            mainmenu
#        }
#    }
#}

Write-Output "$profileDir/common.txt";

#$sysType = $Host.UI.PromptForChoice("System type", "What type of system is this?", [System.Management.Automation.Host.ChoiceDescription[]]@("&Standard", "&Developerment"), 0);

#Install-BoxstarterPackage -PackageName "common.txt" -DisableReboots
#if ($sysType -eq 0) {
#    &choco install firefox -y
#}

#if ($sysType -eq 1) {
#    Install-BoxstarterPackage -PackageName http://jain56/Install/dev.txt -DisableReboots
#}