Function Run-BoxStarter ($packageType) {
    $packageName = "$profileDir/$packageType.txt";
    Write-Host $packageName;
    Import-Module Boxstarter.Chocolatey
    Install-BoxstarterPackage -PackageName $packageName -DisableReboots
}

$profileDir = "http://localhost:61800/profiles";

Write-Output 'Start Dependencies'
Write-Output ' - Start Http Server [caddy]'
Start-Process -FilePath .\mongoose.exe

Write-Output 'Install Chocolatey';
if (-Not (Get-Command choco -ErrorAction SilentlyContinue)) {
    Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'));
}
else {
    Write-Output '  Chocolatey already installed';
}

Write-Output 'Install BoxStarter';
if ((choco list -lo | where { $_.ToLower().StartsWith("Boxstarter".ToLower()) } | measure).Count -eq 0) {
    &choco install Boxstarter -y;
    &'C:\ProgramData\Boxstarter\BoxstarterShell.ps1';
}
else {
    Write-Output '  Boxstarter already installed';
}

$endloop = $False;

while (-Not ($endloop)) {

	$sysType = "";

	while ($sysType -eq "") {
			Write-Output "";
			Write-Output "";
		Write-Output "System Type";
		Write-Output "  Profiles:";
		Write-Output "  1 - Standard";
		Write-Output "  2 - Dev: Common";
		Write-Output "  3 - Dev: Mobile";
		Write-Output "  4 - Dev: Doc";
		Write-Output "  5 - Dev: Multimedia";
		Write-Output "";
		Write-Output "  Special:";
			Write-Output "  A - Arnav";
			Write-Output "  I - Ishan";
		Write-Output "";
			Write-Output "  X - Exit";
		Write-Output "";

		$sysType = read-host "Select profiles(s)";
	}

    $nums = $sysType.split(",");
	Write-Host $nums;

    ForEach ($answer in $nums) {

        # Required for Powershell 2.0
        $answer = $answer.Trim();

        $installtype = "";

        switch ($answer) {
            1 {$installtype = 'common'};
            2 {$installtype = 'dev-common'};
            3 {$installtype = 'dev-mobile'};
            4 {$installtype = 'dev-doc'};
            5 {$installtype = 'dev-media'};
       
            A {$installtype = 'sp-arnav'};
            I {$installtype = 'sp-Ishan'};
       
            X {
                Write-Host -ForegroundColor Yellow "Exiting";
                $endloop = $True;
                Exit;
            }
            default {
                Write-Host -ForegroundColor red "Invalid Selection";
                timeout 2;
            }
        }

        if (-Not($installtype -eq "")) {
            $endloop = $True;
            Run-BoxStarter($installtype);
        }

    }
}

Write-Output Restarting Computer
shutdown -r -t 10
Write-Output Press Any key to abort
timeout 30
shutdown -a