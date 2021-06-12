$Host.UI.RawUI.WindowTitle = "AAF DCH Optimus Sound Mod Uninstaller v1.3.2"
Write-Host "Welcome to AAF DCH Optimus Sound Mod Uninstaller v1.3.2! (Created by TheDoctor for users AAF in forum TechPowerUP)"
Write-Host ""
$yes = New-Object System.Management.Automation.Host.ChoiceDescription '&Yes', 'Prepare to removing AAF DCH Optimus Sound'
$no = New-Object System.Management.Automation.Host.ChoiceDescription '&No', 'Cancel the removing AAF DCH Optimus Sound'
$options = [System.Management.Automation.Host.ChoiceDescription[]]($yes, $no)
$result = $host.ui.PromptForChoice('', 'Are you shure want to removing AAF DCH Optimus Sound completly?', $options, 1)
if ((gwmi Win32_OperatingSystem | Select OsArchitecture).OsArchitecture -eq "64-bit")
{
	New-Variable -Name "devcon" -Value "devcon_x64.exe"
}
else
{
    New-Variable -Name "devcon" -Value "devcon_x86.exe"
}
$ScriptPath = Split-Path -parent $MyInvocation.MyCommand.Definition
New-Variable -Name "syscache" -Value "$Env:SystemRoot\System32\DriverStore\FileRepository"
Write-Host ""
switch ($result)
    {
    0   {
		Write-Host "Creating checkpoint for rollback..."
		Checkpoint-Computer -Description 'Started AAF DCH Optimus Sound Mod Uninstaller' -RestorePointType 'MODIFY_SETTINGS'
		Write-Host "Complete!"
		Write-Host ""
		Set-ExecutionPolicy Bypass -Scope LocalMachine -Confirm:$False -Force -wa SilentlyContinue
		if (!(Test-Path $Env:ProgramFiles\AAF\Uninstall\unins000.exe)) {
		Write-Host "The AAF DCH Optimus Sound Mod was removal previously completed..."
		Write-Host "There is nothing to delete!"
		} else {
		Write-Host "Uninstalling AAF DCH Optimus Sound..."
		Get-CimInstance -Classname WIn32_Product | Where-Object Name -Match 'AAF DCH Optimus Sound' | Invoke-CimMethod -MethodName UnInstall
		## $Env:SystemRoot\System32\msiexec.exe /quiet /norestart /uninstall {F132AF7F-7BCA-4EDE-8A7C-958108FE7DBD}_is1
		Write-Host "Complete!"
		}
		Write-Host ""
		Write-Host "Uninstalling AAF ALC Audio Policy Tweak Tool..."
		Get-CimInstance -Classname WIn32_Product | Where-Object Name -Match 'Realtek Audio Device Tweak' | Invoke-CimMethod -MethodName UnInstall
		## $Env:SystemRoot\System32\msiexec.exe /quiet /norestart /uninstall {A8C7895E-8FA1-4290-9035-B2D170D7BD31}
		Get-CimInstance -Classname WIn32_Product | Where-Object Name -Match 'AAF ALC Audio Policy Tweak Tool' | Invoke-CimMethod -MethodName UnInstall
		## $Env:SystemRoot\System32\msiexec.exe /quiet /norestart /uninstall {7BECF9EA-ADD7-4ABD-9332-BC63AD0D4CE3}
		## 2>&1>$null
		Write-Host "Complete!"
		Write-Host ""
		Write-Host "Stopping Windows audio services..."
		Stop-Process -Name "audiodg" -Force -ea SilentlyContinue
		Stop-Service -Name "Audiosrv" -Force -ea SilentlyContinue
		Stop-Service -Name "AudioEndpointBuilder" -Force -ea SilentlyContinue
		Write-Host "Complete!"
		Write-Host ""
		Write-Host "Deleting AAF DCH Optimus Sound services..."
		Stop-Process -Name "Creative.UWPRPCService.exe" -Force -ea SilentlyContinue
		Stop-Process -Name "DAX3API.exe" -Force -ea SilentlyContinue
		Stop-Process -Name "NahimicSvc32" -Force -ea SilentlyContinue
		Stop-Process -Name "NahimicSvc64" -Force -ea SilentlyContinue
		Stop-Process -Name "RAVCpl64" -Force -ea SilentlyContinue
		Stop-Process -Name "RtkAudioService64" -Force -ea SilentlyContinue
		Stop-Process -Name "RtkAudUService64" -Force -ea SilentlyContinue
		Stop-Service -Name "DolbyDAXAPI" -Force -ea SilentlyContinue
		Stop-Service -Name "DtsApo4Service" -Force -ea SilentlyContinue
		Stop-Service -Name "IntcAzAudAddService" -Force -ea SilentlyContinue
		Stop-Service -Name "mbfilt" -Force -ea SilentlyContinue
		Stop-Service -Name "NahimicService" -Force -ea SilentlyContinue
		Stop-Service -Name "RtkAudioUniversalService" -Force -ea SilentlyContinue
		Stop-Service -Name "UWPService" -Force -ea SilentlyContinue
		sc.exe delete "DolbyDAXAPI" 2>&1>$null
		sc.exe delete "DtsApo4Service" 2>&1>$null
		sc.exe delete "IntcAzAudAddService" 2>&1>$null
		sc.exe delete "mbfilt" 2>&1>$null
		sc.exe delete "NahimicService" 2>&1>$null
		sc.exe delete "RtkAudioUniversalService" 2>&1>$null
		sc.exe delete "UWPService" 2>&1>$null
		Remove-Item -Path "HKLM:\SYSTEM\CurrentControlSet\Services\DolbyDAXAPI" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\SYSTEM\CurrentControlSet\Services\DtsApo4Service" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\SYSTEM\CurrentControlSet\Services\IntcAzAudAddService" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\SYSTEM\CurrentControlSet\Services\mbfilt" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\SYSTEM\CurrentControlSet\Services\NahimicService" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\SYSTEM\CurrentControlSet\Services\Realtek" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\SYSTEM\CurrentControlSet\Services\RtkAudioService" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\SYSTEM\CurrentControlSet\Services\RtkAudioUniversalService" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\SYSTEM\CurrentControlSet\Services\UWPService" -Recurse -Force -ea SilentlyContinue
		Write-Host "Complete!"
		Write-Host ""
		Write-Host "Disabling and removing AAF DCH Optimus Sound Software components and extensions in Device Manager..."
		Start-Process -FilePath "$ScriptPath\$devcon" -Wait -NoNewWindow -ArgumentList "/r disable =SoftwareComponent 'SWC\VEN_AAF&HWID_000&HDAAPO'" -RedirectStandardOutput ".\NUL"
		Start-Process -FilePath "$ScriptPath\$devcon" -Wait -NoNewWindow -ArgumentList "/r remove =SoftwareComponent 'SWC\VEN_AAF&HWID_000&HDAAPO'" -RedirectStandardOutput ".\NUL"
		Start-Process -FilePath "$ScriptPath\$devcon" -Wait -NoNewWindow -ArgumentList "/r disable =SoftwareComponent 'SWC\VEN_AAF&HWID_000&HDAHSA'" -RedirectStandardOutput ".\NUL"
		Start-Process -FilePath "$ScriptPath\$devcon" -Wait -NoNewWindow -ArgumentList "/r remove =SoftwareComponent 'SWC\VEN_AAF&HWID_000&HDAHSA'" -RedirectStandardOutput ".\NUL"
		Start-Process -FilePath "$ScriptPath\$devcon" -Wait -NoNewWindow -ArgumentList "/r disable =SoftwareComponent 'SWC\VEN_AAF&HWID_000&HDACFG'" -RedirectStandardOutput ".\NUL"
		Start-Process -FilePath "$ScriptPath\$devcon" -Wait -NoNewWindow -ArgumentList "/r remove =SoftwareComponent 'SWC\VEN_AAF&HWID_000&HDACFG'" -RedirectStandardOutput ".\NUL"
		Start-Process -FilePath "$ScriptPath\$devcon" -Wait -NoNewWindow -ArgumentList "/r disable =SoftwareComponent 'SWC\VEN_AAF&HWID_000&UADHSA'" -RedirectStandardOutput ".\NUL"
		Start-Process -FilePath "$ScriptPath\$devcon" -Wait -NoNewWindow -ArgumentList "/r remove =SoftwareComponent 'SWC\VEN_AAF&HWID_000&UADHSA'" -RedirectStandardOutput ".\NUL"
		Start-Process -FilePath "$ScriptPath\$devcon" -Wait -NoNewWindow -ArgumentList "/r disable =SoftwareComponent 'SWC\VEN_AAF&HWID_000&UADAPO'" -RedirectStandardOutput ".\NUL"
		Start-Process -FilePath "$ScriptPath\$devcon" -Wait -NoNewWindow -ArgumentList "/r remove =SoftwareComponent 'SWC\VEN_AAF&HWID_000&UADAPO'" -RedirectStandardOutput ".\NUL"
		Start-Process -FilePath "$ScriptPath\$devcon" -Wait -NoNewWindow -ArgumentList "/r disable =SoftwareComponent 'SWC\VEN_AAF&HWID_000&UADCFG'" -RedirectStandardOutput ".\NUL"
		Start-Process -FilePath "$ScriptPath\$devcon" -Wait -NoNewWindow -ArgumentList "/r remove =SoftwareComponent 'SWC\VEN_AAF&HWID_000&UADCFG'" -RedirectStandardOutput ".\NUL"
		Start-Process -FilePath "$ScriptPath\$devcon" -Wait -NoNewWindow -ArgumentList "/r disable =SoftwareComponent 'SWC\VEN_AAF&HWID_001&APO'" -RedirectStandardOutput ".\NUL"
		Start-Process -FilePath "$ScriptPath\$devcon" -Wait -NoNewWindow -ArgumentList "/r remove =SoftwareComponent 'SWC\VEN_AAF&HWID_001&APO'" -RedirectStandardOutput ".\NUL"
		Start-Process -FilePath "$ScriptPath\$devcon" -Wait -NoNewWindow -ArgumentList "/r disable =SoftwareComponent 'SWC\VEN_AAF&HWID_001&HSA'" -RedirectStandardOutput ".\NUL"
		Start-Process -FilePath "$ScriptPath\$devcon" -Wait -NoNewWindow -ArgumentList "/r remove =SoftwareComponent 'SWC\VEN_AAF&HWID_001&HSA'" -RedirectStandardOutput ".\NUL"
		Start-Process -FilePath "$ScriptPath\$devcon" -Wait -NoNewWindow -ArgumentList "/r disable =SoftwareComponent 'SWC\VEN_AAF&HWID_003A&APO'" -RedirectStandardOutput ".\NUL"
		Start-Process -FilePath "$ScriptPath\$devcon" -Wait -NoNewWindow -ArgumentList "/r remove =SoftwareComponent 'SWC\VEN_AAF&HWID_003A&APO'" -RedirectStandardOutput ".\NUL"
		Start-Process -FilePath "$ScriptPath\$devcon" -Wait -NoNewWindow -ArgumentList "/r disable =SoftwareComponent 'SWC\VEN_AAF&HWID_003B&APO'" -RedirectStandardOutput ".\NUL"
		Start-Process -FilePath "$ScriptPath\$devcon" -Wait -NoNewWindow -ArgumentList "/r remove =SoftwareComponent 'SWC\VEN_AAF&HWID_003B&APO'" -RedirectStandardOutput ".\NUL"
		Start-Process -FilePath "$ScriptPath\$devcon" -Wait -NoNewWindow -ArgumentList "/r disable =SoftwareComponent 'SWC\VEN_AAF&HWID_004&APO'" -RedirectStandardOutput ".\NUL"
		Start-Process -FilePath "$ScriptPath\$devcon" -Wait -NoNewWindow -ArgumentList "/r remove =SoftwareComponent 'SWC\VEN_AAF&HWID_004&APO'" -RedirectStandardOutput ".\NUL"
		Start-Process -FilePath "$ScriptPath\$devcon" -Wait -NoNewWindow -ArgumentList "/r disable =SoftwareComponent 'SWC\VEN_AAF&HWID_004&HSA'" -RedirectStandardOutput ".\NUL"
		Start-Process -FilePath "$ScriptPath\$devcon" -Wait -NoNewWindow -ArgumentList "/r remove =SoftwareComponent 'SWC\VEN_AAF&HWID_004&HSA'" -RedirectStandardOutput ".\NUL"
		Start-Process -FilePath "$ScriptPath\$devcon" -Wait -NoNewWindow -ArgumentList "/r disable =Extension 'HDAUDIO\FUNC_01&VEN_10EC*'" -RedirectStandardOutput ".\NUL"
		Start-Process -FilePath "$ScriptPath\$devcon" -Wait -NoNewWindow -ArgumentList "/r remove =Extension 'HDAUDIO\FUNC_01&VEN_10EC*'" -RedirectStandardOutput ".\NUL"
		Start-Process -FilePath "$ScriptPath\$devcon" -Wait -NoNewWindow -ArgumentList "/r disable =Extension 'INTELAUDIO\FUNC_01&VEN_10EC*'" -RedirectStandardOutput ".\NUL"
		Start-Process -FilePath "$ScriptPath\$devcon" -Wait -NoNewWindow -ArgumentList "/r remove =Extension 'INTELAUDIO\FUNC_01&VEN_10EC*'" -RedirectStandardOutput ".\NUL"
		Start-Process -FilePath "$ScriptPath\$devcon" -Wait -NoNewWindow -ArgumentList "/r disable =MEDIA 'HDAUDIO\FUNC_01&VEN_10EC*'" -RedirectStandardOutput ".\NUL"
		Start-Process -FilePath "$ScriptPath\$devcon" -Wait -NoNewWindow -ArgumentList "/r remove =MEDIA 'HDAUDIO\FUNC_01&VEN_10EC*'" -RedirectStandardOutput ".\NUL"
		Start-Process -FilePath "$ScriptPath\$devcon" -Wait -NoNewWindow -ArgumentList "/r disable =MEDIA 'INTELAUDIO\FUNC_01&VEN_10EC*'" -RedirectStandardOutput ".\NUL"
		Start-Process -FilePath "$ScriptPath\$devcon" -Wait -NoNewWindow -ArgumentList "/r remove =MEDIA 'INTELAUDIO\FUNC_01&VEN_10EC*'" -RedirectStandardOutput ".\NUL"
		Write-Host "Complete!"
		Write-Host ""
		Write-Host "Removing AAF DCH Optimus Sound UWP apps..."
		Get-AppxPackage A-Volute.Nahimic* -AllUsers | Remove-AppxPackage -AllUsers -ea SilentlyContinue
		Get-AppxPackage A-Volute.SonicStudio* -AllUsers | Remove-AppxPackage -AllUsers -ea SilentlyContinue
		Get-AppxPackage CreativeTechnologyLtd.SoundBlasterConnect* -AllUsers | Remove-AppxPackage -AllUsers -ea SilentlyContinue
		Get-AppxPackage DolbyLaboratories.DolbyAtmos* -AllUsers | Remove-AppxPackage -AllUsers -ea SilentlyContinue
		Get-AppxPackage DTSInc.DTSHeadphoneX* -AllUsers | Remove-AppxPackage -AllUsers -ea SilentlyContinue
		Get-AppxPackage DTSInc.DTSSoundUnbound* -AllUsers | Remove-AppxPackage -AllUsers -ea SilentlyContinue
		Get-AppxPackage DTSInc.DTSXUltra* -AllUsers | Remove-AppxPackage -AllUsers -ea SilentlyContinue
		Get-AppxPackage RealtekSemiconductorCorp.RealtekAudioControl* -AllUsers | Remove-AppxPackage -AllUsers -ea SilentlyContinue
		Remove-Item -Path "$Env:ProgramFiles\WindowsApps\A-Volute.Nahimic*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "$Env:ProgramFiles\WindowsApps\A-Volute.SonicStudio*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "$Env:ProgramFiles\WindowsApps\CreativeTechnologyLtd.SoundBlasterConnect*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "$Env:ProgramFiles\WindowsApps\DolbyLaboratories.DolbyAtmos*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "$Env:ProgramFiles\WindowsApps\DTSInc.DTSHeadphoneX*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "$Env:ProgramFiles\WindowsApps\DTSInc.DTSSoundUnbound*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "$Env:ProgramFiles\WindowsApps\DTSInc.DTSXUltra*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "$Env:ProgramFiles\WindowsApps\RealtekSemiconductorCorp.RealtekAudioControl*" -Recurse -Force -ea SilentlyContinue
		Write-Host "Complete!"
		Write-Host ""
		Write-Host "Removing AAF DCH Optimus Sound drivers..."
		$oemfiles = gci $Env:SystemRoot\INF\oem*.inf
		foreach($file in $oemfiles){if(Get-Content $file | Select-String -pattern 'AAF Publisher EV' -SimpleMatch){pnputil /delete-driver $file.name /force}}
		Remove-Item -Path "HKLM:\SYSTEM\DriverDatabase\DeviceIds\APO" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\SYSTEM\DriverDatabase\DeviceIds\HDAUDIO\FUNC_01&VEN_10EC" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\SYSTEM\DriverDatabase\DeviceIds\INTELAUDIO\FUNC_01&VEN_10EC" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\SYSTEM\DriverDatabase\DeviceIds\SWC\*VEN_AAF*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\SYSTEM\DriverDatabase\DeviceIds\{e2f84ce7-8efa-411c-aa69-97454ca4cb57}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\SYSTEM\DriverDatabase\DeviceIds\{5989fce8-9cd0-467d-8a6a-5419e31529d4}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\SYSTEM\DriverDatabase\DeviceIds\{5c4c3332-344d-483c-8739-259e934c9cc8}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\SYSTEM\DriverDatabase\DeviceIds\{4d36e96c-e325-11ce-bfc1-08002be10318}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\SYSTEM\DriverDatabase\DriverPackages\avolute3cfg*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\SYSTEM\DriverDatabase\DriverPackages\avolute4cfg*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\SYSTEM\DriverDatabase\DriverPackages\creativeapo*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\SYSTEM\DriverDatabase\DriverPackages\creativesbconnect*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\SYSTEM\DriverDatabase\DriverPackages\dax3_swc_hsa*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\SYSTEM\DriverDatabase\DriverPackages\ddlswc*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\SYSTEM\DriverDatabase\DriverPackages\dolbyapo*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\SYSTEM\DriverDatabase\DriverPackages\dtsapo4*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\SYSTEM\DriverDatabase\DriverPackages\dtsintswc*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\SYSTEM\DriverDatabase\DriverPackages\hdx*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\SYSTEM\DriverDatabase\DriverPackages\hdxhpbpc*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\SYSTEM\DriverDatabase\DriverPackages\realtekhsa*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\SYSTEM\DriverDatabase\DriverPackages\realtekhdaapo*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\SYSTEM\DriverDatabase\DriverPackages\realtekhdacfg*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\SYSTEM\DriverDatabase\DriverPackages\realtekhdahsa*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\SYSTEM\DriverDatabase\DriverPackages\realtekuadapo*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\SYSTEM\DriverDatabase\DriverPackages\realtekuadhsa*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\SYSTEM\DriverDatabase\DriverPackages\realtekuadsrv*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\SYSTEM\DriverDatabase\DriverInfFiles\oem0.inf" -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\SYSTEM\DriverDatabase\DriverInfFiles\oem2.inf" -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\SYSTEM\DriverDatabase\DriverInfFiles\oem6.inf" -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\SYSTEM\DriverDatabase\DriverInfFiles\oem15.inf" -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\SYSTEM\DriverDatabase\DriverInfFiles\oem19.inf" -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\SYSTEM\DriverDatabase\DriverInfFiles\oem20.inf" -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\SYSTEM\DriverDatabase\DriverInfFiles\oem21.inf" -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\SYSTEM\DriverDatabase\DriverInfFiles\oem22.inf" -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\SYSTEM\DriverDatabase\DriverInfFiles\oem23.inf" -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\SYSTEM\DriverDatabase\DriverInfFiles\oem24.inf" -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\SYSTEM\DriverDatabase\DriverInfFiles\oem25.inf" -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\SYSTEM\DriverDatabase\DriverInfFiles\oem26.inf" -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\SYSTEM\DriverDatabase\DriverInfFiles\oem27.inf" -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\SYSTEM\DriverDatabase\DriverInfFiles\oem28.inf" -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\SYSTEM\DriverDatabase\DriverInfFiles\oem29.inf" -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\SYSTEM\DriverDatabase\DriverInfFiles\oem30.inf" -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\SYSTEM\DriverDatabase\DriverInfFiles\oem31.inf" -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\SYSTEM\DriverDatabase\DriverInfFiles\oem32.inf" -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\SYSTEM\DriverDatabase\DriverInfFiles\oem33.inf" -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\SYSTEM\DriverDatabase\DriverInfFiles\oem34.inf" -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\SYSTEM\DriverDatabase\DriverInfFiles\oem35.inf" -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\SYSTEM\DriverDatabase\DriverInfFiles\oem36.inf" -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\SYSTEM\DriverDatabase\DriverInfFiles\oem37.inf" -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\SYSTEM\DriverDatabase\DriverInfFiles\oem38.inf" -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\SYSTEM\DriverDatabase\DriverInfFiles\oem39.inf" -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\SYSTEM\DriverDatabase\DriverInfFiles\oem40.inf" -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\SYSTEM\DriverDatabase\DriverInfFiles\oem41.inf" -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\SYSTEM\DriverDatabase\DriverInfFiles\oem42.inf" -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\SYSTEM\DriverDatabase\DriverInfFiles\oem43.inf" -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\SYSTEM\DriverDatabase\DriverInfFiles\oem44.inf" -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\SYSTEM\DriverDatabase\DriverInfFiles\oem45.inf" -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\SYSTEM\DriverDatabase\DriverInfFiles\oem46.inf" -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\SYSTEM\DriverDatabase\DriverInfFiles\oem47.inf" -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\SYSTEM\DriverDatabase\DriverInfFiles\oem48.inf" -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\SYSTEM\DriverDatabase\DriverPackages\000.hdx_allbrandext_rtk_hda_dtsapo4*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\SYSTEM\DriverDatabase\DriverPackages\000.hdx_allbrandext_rtk_uad_dtsapo4*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\SYSTEM\DriverDatabase\DriverPackages\001.hdx_allbrandext_avolutess3fx*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\SYSTEM\DriverDatabase\DriverPackages\002.hdx_allbrandext_creativefx*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\SYSTEM\DriverDatabase\DriverPackages\003.hdx_allbrandext_avolutenh3fx*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\SYSTEM\DriverDatabase\DriverPackages\004.hdx_allbrandext_dolbyfx*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\SYSTEM\DriverDatabase\DriverPackages\005.hdx_allbrandext_dolbydigitalfx*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\SYSTEM\DriverDatabase\DriverPackages\005.hdx_allbrandext_dtsinteractivefx*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\SYSTEM\DriverDatabase\DriverPackages\dolbyapo.inf*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "$Env:SystemRoot\INF\oem0.inf" -Force -ea SilentlyContinue
		Remove-Item -Path "$Env:SystemRoot\INF\oem0.PNF" -Force -ea SilentlyContinue
		Remove-Item -Path "$Env:SystemRoot\INF\oem2.inf" -Force -ea SilentlyContinue
		Remove-Item -Path "$Env:SystemRoot\INF\oem2.PNF" -Force -ea SilentlyContinue
		Remove-Item -Path "$Env:SystemRoot\INF\oem6.inf" -Force -ea SilentlyContinue
		Remove-Item -Path "$Env:SystemRoot\INF\oem6.PNF" -Force -ea SilentlyContinue
		Remove-Item -Path "$Env:SystemRoot\INF\oem15.inf" -Force -ea SilentlyContinue
		Remove-Item -Path "$Env:SystemRoot\INF\oem15.PNF" -Force -ea SilentlyContinue
		Remove-Item -Path "$Env:SystemRoot\INF\oem19.inf" -Force -ea SilentlyContinue
		Remove-Item -Path "$Env:SystemRoot\INF\oem19.PNF" -Force -ea SilentlyContinue
		Remove-Item -Path "$Env:SystemRoot\INF\oem20.inf" -Force -ea SilentlyContinue
		Remove-Item -Path "$Env:SystemRoot\INF\oem20.PNF" -Force -ea SilentlyContinue
		Remove-Item -Path "$Env:SystemRoot\INF\oem21.inf" -Force -ea SilentlyContinue
		Remove-Item -Path "$Env:SystemRoot\INF\oem21.PNF" -Force -ea SilentlyContinue
		Remove-Item -Path "$Env:SystemRoot\INF\oem22.inf" -Force -ea SilentlyContinue
		Remove-Item -Path "$Env:SystemRoot\INF\oem22.PNF" -Force -ea SilentlyContinue
		Remove-Item -Path "$Env:SystemRoot\INF\oem23.inf" -Force -ea SilentlyContinue
		Remove-Item -Path "$Env:SystemRoot\INF\oem23.PNF" -Force -ea SilentlyContinue
		Remove-Item -Path "$Env:SystemRoot\INF\oem24.inf" -Force -ea SilentlyContinue
		Remove-Item -Path "$Env:SystemRoot\INF\oem24.PNF" -Force -ea SilentlyContinue
		Remove-Item -Path "$Env:SystemRoot\INF\oem25.inf" -Force -ea SilentlyContinue
		Remove-Item -Path "$Env:SystemRoot\INF\oem25.PNF" -Force -ea SilentlyContinue
		Remove-Item -Path "$Env:SystemRoot\INF\oem26.inf" -Force -ea SilentlyContinue
		Remove-Item -Path "$Env:SystemRoot\INF\oem26.PNF" -Force -ea SilentlyContinue
		Remove-Item -Path "$Env:SystemRoot\INF\oem27.inf" -Force -ea SilentlyContinue
		Remove-Item -Path "$Env:SystemRoot\INF\oem27.PNF" -Force -ea SilentlyContinue
		Remove-Item -Path "$Env:SystemRoot\INF\oem28.inf" -Force -ea SilentlyContinue
		Remove-Item -Path "$Env:SystemRoot\INF\oem28.PNF" -Force -ea SilentlyContinue
		Remove-Item -Path "$Env:SystemRoot\INF\oem29.inf" -Force -ea SilentlyContinue
		Remove-Item -Path "$Env:SystemRoot\INF\oem29.PNF" -Force -ea SilentlyContinue
		Remove-Item -Path "$Env:SystemRoot\INF\oem30.inf" -Force -ea SilentlyContinue
		Remove-Item -Path "$Env:SystemRoot\INF\oem30.PNF" -Force -ea SilentlyContinue
		Remove-Item -Path "$Env:SystemRoot\INF\oem31.inf" -Force -ea SilentlyContinue
		Remove-Item -Path "$Env:SystemRoot\INF\oem31.PNF" -Force -ea SilentlyContinue
		Remove-Item -Path "$Env:SystemRoot\INF\oem32.inf" -Force -ea SilentlyContinue
		Remove-Item -Path "$Env:SystemRoot\INF\oem32.PNF" -Force -ea SilentlyContinue
		Remove-Item -Path "$Env:SystemRoot\INF\oem33.inf" -Force -ea SilentlyContinue
		Remove-Item -Path "$Env:SystemRoot\INF\oem33.PNF" -Force -ea SilentlyContinue
		Remove-Item -Path "$Env:SystemRoot\INF\oem34.inf" -Force -ea SilentlyContinue
		Remove-Item -Path "$Env:SystemRoot\INF\oem34.PNF" -Force -ea SilentlyContinue
		Remove-Item -Path "$Env:SystemRoot\INF\oem35.inf" -Force -ea SilentlyContinue
		Remove-Item -Path "$Env:SystemRoot\INF\oem35.PNF" -Force -ea SilentlyContinue
		Remove-Item -Path "$Env:SystemRoot\INF\oem36.inf" -Force -ea SilentlyContinue
		Remove-Item -Path "$Env:SystemRoot\INF\oem36.PNF" -Force -ea SilentlyContinue
		Remove-Item -Path "$Env:SystemRoot\INF\oem37.inf" -Force -ea SilentlyContinue
		Remove-Item -Path "$Env:SystemRoot\INF\oem37.PNF" -Force -ea SilentlyContinue
		Remove-Item -Path "$Env:SystemRoot\INF\oem38.inf" -Force -ea SilentlyContinue
		Remove-Item -Path "$Env:SystemRoot\INF\oem39.inf" -Force -ea SilentlyContinue
		Remove-Item -Path "$Env:SystemRoot\INF\oem40.inf" -Force -ea SilentlyContinue
		Remove-Item -Path "$Env:SystemRoot\INF\oem41.inf" -Force -ea SilentlyContinue
		Remove-Item -Path "$Env:SystemRoot\INF\oem42.inf" -Force -ea SilentlyContinue
		Remove-Item -Path "$Env:SystemRoot\INF\oem43.inf" -Force -ea SilentlyContinue
		Remove-Item -Path "$Env:SystemRoot\INF\oem44.inf" -Force -ea SilentlyContinue
		Remove-Item -Path "$Env:SystemRoot\INF\oem45.inf" -Force -ea SilentlyContinue
		Remove-Item -Path "$Env:SystemRoot\INF\oem46.inf" -Force -ea SilentlyContinue
		Remove-Item -Path "$Env:SystemRoot\INF\oem47.inf" -Force -ea SilentlyContinue
		Remove-Item -Path "$Env:SystemRoot\INF\oem48.inf" -Force -ea SilentlyContinue
		Remove-Item -Path "$Env:SystemRoot\System32\AAFUpdAPITool64.exe" -Force -ea SilentlyContinue
		Remove-Item -Path "$Env:SystemRoot\System32\A-Volute" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "$Env:SystemRoot\System32\catroot\{F750E6C3-38EE-11D1-85E5-00C04FC295EE}\oem0.cat" -Force -ea SilentlyContinue
		Remove-Item -Path "$Env:SystemRoot\System32\catroot\{F750E6C3-38EE-11D1-85E5-00C04FC295EE}\oem2.cat" -Force -ea SilentlyContinue
		Remove-Item -Path "$Env:SystemRoot\System32\catroot\{F750E6C3-38EE-11D1-85E5-00C04FC295EE}\oem6.cat" -Force -ea SilentlyContinue
		Remove-Item -Path "$Env:SystemRoot\System32\catroot\{F750E6C3-38EE-11D1-85E5-00C04FC295EE}\oem15.cat" -Force -ea SilentlyContinue
		Remove-Item -Path "$Env:SystemRoot\System32\catroot\{F750E6C3-38EE-11D1-85E5-00C04FC295EE}\oem19.cat" -Force -ea SilentlyContinue
		Remove-Item -Path "$Env:SystemRoot\System32\catroot\{F750E6C3-38EE-11D1-85E5-00C04FC295EE}\oem20.cat" -Force -ea SilentlyContinue
		Remove-Item -Path "$Env:SystemRoot\System32\catroot\{F750E6C3-38EE-11D1-85E5-00C04FC295EE}\oem21.cat" -Force -ea SilentlyContinue
		Remove-Item -Path "$Env:SystemRoot\System32\catroot\{F750E6C3-38EE-11D1-85E5-00C04FC295EE}\oem22.cat" -Force -ea SilentlyContinue
		Remove-Item -Path "$Env:SystemRoot\System32\catroot\{F750E6C3-38EE-11D1-85E5-00C04FC295EE}\oem23.cat" -Force -ea SilentlyContinue
		Remove-Item -Path "$Env:SystemRoot\System32\catroot\{F750E6C3-38EE-11D1-85E5-00C04FC295EE}\oem24.cat" -Force -ea SilentlyContinue
		Remove-Item -Path "$Env:SystemRoot\System32\catroot\{F750E6C3-38EE-11D1-85E5-00C04FC295EE}\oem25.cat" -Force -ea SilentlyContinue
		Remove-Item -Path "$Env:SystemRoot\System32\catroot\{F750E6C3-38EE-11D1-85E5-00C04FC295EE}\oem26.cat" -Force -ea SilentlyContinue
		Remove-Item -Path "$Env:SystemRoot\System32\catroot\{F750E6C3-38EE-11D1-85E5-00C04FC295EE}\oem27.cat" -Force -ea SilentlyContinue
		Remove-Item -Path "$Env:SystemRoot\System32\catroot\{F750E6C3-38EE-11D1-85E5-00C04FC295EE}\oem28.cat" -Force -ea SilentlyContinue
		Remove-Item -Path "$Env:SystemRoot\System32\catroot\{F750E6C3-38EE-11D1-85E5-00C04FC295EE}\oem29.cat" -Force -ea SilentlyContinue
		Remove-Item -Path "$Env:SystemRoot\System32\catroot\{F750E6C3-38EE-11D1-85E5-00C04FC295EE}\oem30.cat" -Force -ea SilentlyContinue
		Remove-Item -Path "$Env:SystemRoot\System32\catroot\{F750E6C3-38EE-11D1-85E5-00C04FC295EE}\oem31.cat" -Force -ea SilentlyContinue
		Remove-Item -Path "$Env:SystemRoot\System32\catroot\{F750E6C3-38EE-11D1-85E5-00C04FC295EE}\oem32.cat" -Force -ea SilentlyContinue
		Remove-Item -Path "$Env:SystemRoot\System32\catroot\{F750E6C3-38EE-11D1-85E5-00C04FC295EE}\oem33.cat" -Force -ea SilentlyContinue
		Remove-Item -Path "$Env:SystemRoot\System32\catroot\{F750E6C3-38EE-11D1-85E5-00C04FC295EE}\oem34.cat" -Force -ea SilentlyContinue
		Remove-Item -Path "$Env:SystemRoot\System32\catroot\{F750E6C3-38EE-11D1-85E5-00C04FC295EE}\oem35.cat" -Force -ea SilentlyContinue
		Remove-Item -Path "$Env:SystemRoot\System32\catroot\{F750E6C3-38EE-11D1-85E5-00C04FC295EE}\oem36.cat" -Force -ea SilentlyContinue
		Remove-Item -Path "$Env:SystemRoot\System32\catroot\{F750E6C3-38EE-11D1-85E5-00C04FC295EE}\oem37.cat" -Force -ea SilentlyContinue
		Remove-Item -Path "$Env:SystemRoot\System32\catroot\{F750E6C3-38EE-11D1-85E5-00C04FC295EE}\oem38.cat" -Force -ea SilentlyContinue
		Remove-Item -Path "$Env:SystemRoot\System32\catroot\{F750E6C3-38EE-11D1-85E5-00C04FC295EE}\oem39.cat" -Force -ea SilentlyContinue
		Remove-Item -Path "$Env:SystemRoot\System32\catroot\{F750E6C3-38EE-11D1-85E5-00C04FC295EE}\oem40.cat" -Force -ea SilentlyContinue
		Remove-Item -Path "$Env:SystemRoot\System32\catroot\{F750E6C3-38EE-11D1-85E5-00C04FC295EE}\oem41.cat" -Force -ea SilentlyContinue
		Remove-Item -Path "$Env:SystemRoot\System32\catroot\{F750E6C3-38EE-11D1-85E5-00C04FC295EE}\oem42.cat" -Force -ea SilentlyContinue
		Remove-Item -Path "$Env:SystemRoot\System32\catroot\{F750E6C3-38EE-11D1-85E5-00C04FC295EE}\oem43.cat" -Force -ea SilentlyContinue
		Remove-Item -Path "$Env:SystemRoot\System32\catroot\{F750E6C3-38EE-11D1-85E5-00C04FC295EE}\oem44.cat" -Force -ea SilentlyContinue
		Remove-Item -Path "$Env:SystemRoot\System32\catroot\{F750E6C3-38EE-11D1-85E5-00C04FC295EE}\oem45.cat" -Force -ea SilentlyContinue
		Remove-Item -Path "$Env:SystemRoot\System32\catroot\{F750E6C3-38EE-11D1-85E5-00C04FC295EE}\oem46.cat" -Force -ea SilentlyContinue
		Remove-Item -Path "$Env:SystemRoot\System32\catroot\{F750E6C3-38EE-11D1-85E5-00C04FC295EE}\oem47.cat" -Force -ea SilentlyContinue
		Remove-Item -Path "$Env:SystemRoot\System32\catroot\{F750E6C3-38EE-11D1-85E5-00C04FC295EE}\oem48.cat" -Force -ea SilentlyContinue
		Remove-Item -Path "$Env:SystemRoot\System32\dolbyaposvc" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "$Env:SystemRoot\System32\drivers\amdacpksl.sys" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "$Env:SystemRoot\System32\drivers\en_Rtk552xfw.dat" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "$Env:SystemRoot\System32\drivers\MBFilt64.sys" -Force -ea SilentlyContinue
		Remove-Item -Path "$Env:SystemRoot\System32\drivers\RTAIODAT.DAT" -Force -ea SilentlyContinue
		Remove-Item -Path "$Env:SystemRoot\System32\drivers\rtkhdaud.dat" -Force -ea SilentlyContinue
		Remove-Item -Path "$Env:SystemRoot\System32\drivers\RTKVHD64.sys" -Force -ea SilentlyContinue
		Remove-Item -Path "$Env:SystemRoot\System32\drivers\SET989.tmp" -Force -ea SilentlyContinue
		Remove-Item -Path "$Env:SystemRoot\System32\DTS" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "$Env:SystemRoot\System32\ADIAPO.dll" -Force -ea SilentlyContinue
		Remove-Item -Path "$Env:SystemRoot\System32\MBAPO264.dll" -Force -ea SilentlyContinue
		Remove-Item -Path "$Env:SystemRoot\System32\MyNewIcon.ico" -Force -ea SilentlyContinue
		Remove-Item -Path "$Env:SystemRoot\System32\NahimicAPO3ConfiguratorDaemonModule.dll" -Force -ea SilentlyContinue
		Remove-Item -Path "$Env:SystemRoot\System32\NahimicAPO4.dll" -Force -ea SilentlyContinue
		Remove-Item -Path "$Env:SystemRoot\System32\NahimicAPO4API.dll" -Force -ea SilentlyContinue
		Remove-Item -Path "$Env:SystemRoot\System32\NahimicAPO4ConfiguratorDaemonModule.dll" -Force -ea SilentlyContinue
		Remove-Item -Path "$Env:SystemRoot\System32\NahimicAPO4ExpertAPI.dll" -Force -ea SilentlyContinue
		Remove-Item -Path "$Env:SystemRoot\System32\NahimicPnPAPO4ConfiguratorDaemonModule.dll" -Force -ea SilentlyContinue
		Remove-Item -Path "$Env:SystemRoot\System32\NahimicService.exe" -Force -ea SilentlyContinue
		Remove-Item -Path "$Env:SystemRoot\System32\NahimicSvc64.exe" -Force -ea SilentlyContinue
		Remove-Item -Path "$Env:SystemRoot\System32\NhNotifSys.dll" -Force -ea SilentlyContinue
		Remove-Item -Path "$Env:SystemRoot\System32\NhNotifSys.exe" -Force -ea SilentlyContinue
		Remove-Item -Path "$Env:SystemRoot\System32\OEMIcon.ico" -Force -ea SilentlyContinue
		Remove-Item -Path "$Env:SystemRoot\System32\RCoInstII64.dll" -Force -ea SilentlyContinue
		Remove-Item -Path "$Env:SystemRoot\System32\RCORES64.dat" -Force -ea SilentlyContinue
		Remove-Item -Path "$Env:SystemRoot\System32\RltkAPO64.dll" -Force -ea SilentlyContinue
		Remove-Item -Path "$Env:SystemRoot\System32\RltkAPOU64.dll" -Force -ea SilentlyContinue
		Remove-Item -Path "$Env:SystemRoot\System32\RtCOM64.dll" -Force -ea SilentlyContinue
		Remove-Item -Path "$Env:SystemRoot\System32\RtDataProc64.dll" -Force -ea SilentlyContinue
		Remove-Item -Path "$Env:SystemRoot\System32\RTEED64A.dll" -Force -ea SilentlyContinue
		Remove-Item -Path "$Env:SystemRoot\System32\RTEEG64A.dll" -Force -ea SilentlyContinue
		Remove-Item -Path "$Env:SystemRoot\System32\RTEEL64A.dll" -Force -ea SilentlyContinue
		Remove-Item -Path "$Env:SystemRoot\System32\RTEEP64A.dll" -Force -ea SilentlyContinue
		Remove-Item -Path "$Env:SystemRoot\System32\RTHDASIO64.dll" -Force -ea SilentlyContinue
		Remove-Item -Path "$Env:SystemRoot\System32\RtkApi64.dll" -Force -ea SilentlyContinue
		Remove-Item -Path "$Env:SystemRoot\System32\RtkApi64U.dll" -Force -ea SilentlyContinue
		Remove-Item -Path "$Env:SystemRoot\System32\RtkAudUService64.exe" -Force -ea SilentlyContinue
		Remove-Item -Path "$Env:SystemRoot\System32\RtkAudUServiceConf64.dll" -Force -ea SilentlyContinue
		Remove-Item -Path "$Env:SystemRoot\System32\RtkCfg64.dll" -Force -ea SilentlyContinue
		Remove-Item -Path "$Env:SystemRoot\System32\RtkCoLDR64.dll" -Force -ea SilentlyContinue
		Remove-Item -Path "$Env:SystemRoot\System32\RtkTweakTool.exe" -Force -ea SilentlyContinue
		Remove-Item -Path "$Env:SystemRoot\System32\RtPgEx64.dll" -Force -ea SilentlyContinue
		Remove-Item -Path "$Env:SystemRoot\System32\SET4B36.tmp" -Force -ea SilentlyContinue
		Remove-Item -Path "$Env:SystemRoot\System32\SETB22.tmp" -Force -ea SilentlyContinue
		Remove-Item -Path "$Env:SystemRoot\SysWOW64\Creative.UWPRPCService.exe" -Force -ea SilentlyContinue
		Remove-Item -Path "$Env:SystemRoot\SysWOW64\MBAPO232.dll" -Force -ea SilentlyContinue
		Remove-Item -Path "$Env:SystemRoot\SysWOW64\NahimicSvc32.exe" -Force -ea SilentlyContinue
		Remove-Item -Path "$Env:SystemRoot\SysWOW64\RTHDASIO.dll" -Force -ea SilentlyContinue
		Write-Host "Complete!"
		Write-Host ""
		Write-Host "Deleting AAF DCH Optimus Sound files in System Cache (FileRepository)..."
		Remove-Item -Path "$syscache\000.hdx_allbrandext_rtk_hda_dtsapo4*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "$syscache\000.hdx_allbrandext_rtk_uad_dtsapo4*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "$syscache\001.hdx_allbrandext_avolutess3fx*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "$syscache\002.hdx_allbrandext_creativefx*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "$syscache\003.hdx_allbrandext_avolutenh3fx*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "$syscache\004.hdx_allbrandext_dolbyfx*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "$syscache\005.hdx_allbrandext_dolbydigitalfx*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "$syscache\005.hdx_allbrandext_dtsinteractivefx*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "$syscache\avolute3cfg*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "$syscache\avolute4cfg*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "$syscache\creativeapo*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "$syscache\creativesbconnect*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "$syscache\dax3_swc_hsa*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "$syscache\ddlswc*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "$syscache\dolbyapo*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "$syscache\dolbycfg*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "$syscache\dtsapo4*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "$syscache\dtsintswc*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "$syscache\hdx*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "$syscache\hdxhpbpc*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "$syscache\realtekhsa*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "$syscache\realtekhdaapo*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "$syscache\realtekhdacfg*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "$syscache\realtekhdahsa*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "$syscache\realtekuadapo*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "$syscache\realtekuadhsa*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "$syscache\realtekuadsrv*" -Recurse -Force -ea SilentlyContinue
		Write-Host "Complete!"
		Write-Host ""
		Write-Host "Removing other AAF DCH Optimus Sound files..."
		Start-Process -FilePath "$Env:SystemRoot\System32\certutil.exe" -Wait -NoNewWindow -ArgumentList "-silent -delstore Root AAFRoot" -RedirectStandardOutput ".\NUL"
		Start-Process -FilePath "$Env:SystemRoot\System32\certutil.exe" -Wait -NoNewWindow -ArgumentList "-silent -delstore CA AAFCA" -RedirectStandardOutput ".\NUL"
		Start-Process -FilePath "$Env:SystemRoot\System32\certutil.exe" -Wait -NoNewWindow -ArgumentList "-silent -delstore TrustedPublisher AAFUSR" -RedirectStandardOutput ".\NUL"
		Remove-Item -Path "HKCR:\AppID\CTAPO.DLL" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCR:\AppID\Dax3Ref.dll" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCR:\AppID\DTSDll.DLL" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCR:\AppID\Nahimicsfx.dll" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCR:\AppID\RTCOMDLL.DLL" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCR:\AudioEngine\AudioProcessingObjects\{0212AE2C-F779-4A50-9B10-57A0AEF22870}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCR:\AudioEngine\AudioProcessingObjects\{031392C9-4725-4F53-9A62-E75D902BA553}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCR:\AudioEngine\AudioProcessingObjects\{07531B73-E4CA-4B94-9D0E-D3C9A7825FE5}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCR:\AudioEngine\AudioProcessingObjects\{0EBD8505-17BB-4AE7-AD76-E86F99A425E9}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCR:\AudioEngine\AudioProcessingObjects\{0EBD8505-27BB-4AE7-AD76-E86F99A425E9}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCR:\AudioEngine\AudioProcessingObjects\{0EBD8506-17BB-4AE7-AD76-E86F99A425E9}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCR:\AudioEngine\AudioProcessingObjects\{0EBD8506-27BB-4AE7-AD76-E86F99A425E9}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCR:\AudioEngine\AudioProcessingObjects\{0EBD8507-17BB-4AE7-AD76-E86F99A425E9}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCR:\AudioEngine\AudioProcessingObjects\{0EBD8507-27BB-4AE7-AD76-E86F99A425E9}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCR:\AudioEngine\AudioProcessingObjects\{0EBD8508-17BB-4AE7-AD76-E86F99A425E9}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCR:\AudioEngine\AudioProcessingObjects\{0EBD8508-27BB-4AE7-AD76-E86F99A425E9}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCR:\AudioEngine\AudioProcessingObjects\{0EBD8509-17BB-4AE7-AD76-E86F99A425E9}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCR:\AudioEngine\AudioProcessingObjects\{0EBD8509-27BB-4AE7-AD76-E86F99A425E9}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCR:\AudioEngine\AudioProcessingObjects\{0EBD8510-17BB-4AE7-AD76-E86F99A425E9}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCR:\AudioEngine\AudioProcessingObjects\{0EBD8510-27BB-4AE7-AD76-E86F99A425E9}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCR:\AudioEngine\AudioProcessingObjects\{0EBD8511-17BB-4AE7-AD76-E86F99A425E9}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCR:\AudioEngine\AudioProcessingObjects\{0EBD8511-27BB-4AE7-AD76-E86F99A425E9}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCR:\AudioEngine\AudioProcessingObjects\{0EBD8512-17BB-4AE7-AD76-E86F99A425E9}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCR:\AudioEngine\AudioProcessingObjects\{0EBD8512-27BB-4AE7-AD76-E86F99A425E9}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCR:\AudioEngine\AudioProcessingObjects\{0F62DFB3-DB5B-458D-9371-6B45C4582560}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCR:\AudioEngine\AudioProcessingObjects\{670173E3-78CF-11E5-A837-0800200C9A66}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCR:\AudioEngine\AudioProcessingObjects\{670173E4-78CF-11E5-A837-0800200C9A66}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCR:\AudioEngine\AudioProcessingObjects\{670173E5-78CF-11E5-A837-0800200C9A66}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCR:\AudioEngine\AudioProcessingObjects\{670173F4-78CF-11E5-A837-0800200C9A66}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCR:\ActivatableClasses\Package\A-Volute.Nahimic*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCR:\ActivatableClasses\Package\A-Volute.SonicStudio*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCR:\ActivatableClasses\Package\CreativeTechnologyLtd.SoundBlasterConnect*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCR:\ActivatableClasses\Package\DTSInc.DTSSoundUnbound*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCR:\ActivatableClasses\Package\RealtekSemiconductorCorp.RealtekAudioControl*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCR:\AppXj59z2hqwz9v0mx97rbdz25w9k1kzkb1g" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCR:\AppXr3z76yc7tz4me3df0wxk3pmrah7n9rhz" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCR:\a-volute.SonicStudio*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCR:\CLSID\{1FC71449-ACEC-420D-A3E9-7A0FC630926E}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCR:\CLSID\{EACD2258-FCAC-4FF4-B36D-419E924A6D79}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCR:\CLSID\{EC1CC9CE-FAED-4822-828A-82A81A6F018F}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCR:\Extensions\ContractId\Windows.AppService\PackageId\A-Volute.Nahimic*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCR:\Extensions\ContractId\Windows.AppService\PackageId\A-Volute.SonicStudio*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCR:\Extensions\ContractId\Windows.AppService\PackageId\CreativeTechnologyLtd.SoundBlasterConnect*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCR:\Extensions\ContractId\Windows.AppService\PackageId\DTSInc.DTSSoundUnbound*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCR:\Extensions\ContractId\Windows.AppService\PackageId\RealtekSemiconductorCorp.RealtekAudioControl*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCR:\Extensions\ContractId\Windows.BackgroundTasks\PackageId\A-Volute.Nahimic*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCR:\Extensions\ContractId\Windows.BackgroundTasks\PackageId\A-Volute.SonicStudio*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCR:\Extensions\ContractId\Windows.BackgroundTasks\PackageId\CreativeTechnologyLtd.SoundBlasterConnect*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCR:\Extensions\ContractId\Windows.BackgroundTasks\PackageId\DTSInc.DTSSoundUnbound*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCR:\Extensions\ContractId\Windows.BackgroundTasks\PackageId\RealtekSemiconductorCorp.RealtekAudioControl*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCR:\Extensions\ContractId\Windows.Launch\PackageId\A-Volute.Nahimic*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCR:\Extensions\ContractId\Windows.Launch\PackageId\A-Volute.SonicStudio*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCR:\Extensions\ContractId\Windows.Launch\PackageId\CreativeTechnologyLtd.SoundBlasterConnect*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCR:\Extensions\ContractId\Windows.Launch\PackageId\DTSInc.DTSSoundUnbound*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCR:\Extensions\ContractId\Windows.Launch\PackageId\RealtekSemiconductorCorp.RealtekAudioControl*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCR:\Extensions\ContractId\Windows.Protocol\PackageId\A-Volute.Nahimic*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCR:\Extensions\ContractId\Windows.Protocol\PackageId\A-Volute.SonicStudio*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCR:\Extensions\ContractId\Windows.Protocol\PackageId\CreativeTechnologyLtd.SoundBlasterConnect*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCR:\Extensions\ContractId\Windows.Protocol\PackageId\DTSInc.DTSSoundUnbound*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCR:\Extensions\ContractId\Windows.Protocol\PackageId\RealtekSemiconductorCorp.RealtekAudioControl*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCR:\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppContainer\Storage\a-volute.nahimic*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCR:\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppContainer\Storage\a-volute.sonicstudio*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCR:\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppContainer\Storage\creativetechnologyltd.soundblasterconnect*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCR:\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppContainer\Storage\realteksemiconductorcorp.realtekaudiocontrol*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCR:\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppModel\PackageRepository\Extensions\windows.protocol\a-volute.SonicStudio" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCR:\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppModel\PackageRepository\Extensions\windows.protocol\dts-sound-unbound" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCR:\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppModel\PackageRepository\Packages\A-Volute.SonicStudio*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCR:\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppModel\PackageRepository\Packages\CreativeTechnologyLtd.SoundBlasterConnect*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCR:\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppModel\PackageRepository\Packages\DTSInc.DTSSoundUnbound*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCR:\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppModel\PolicyCache\A-Volute.Nahimic*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCR:\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppModel\PolicyCache\A-Volute.SonicStudio*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCR:\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppModel\PolicyCache\CreativeTechnologyLtd.SoundBlasterConnect*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCR:\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppModel\PolicyCache\DolbyLaboratories.DolbyAtmos*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCR:\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppModel\PolicyCache\DTSInc.DTSSoundUnbound*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCR:\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppModel\PolicyCache\DTSInc.DTSXUltra*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCR:\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppModel\PolicyCache\RealtekSemiconductorCorp.RealtekAudioControl*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCR:\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppModel\Repository\Families\A-Volute.Nahimic*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCR:\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppModel\Repository\Families\A-Volute.SonicStudio*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCR:\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppModel\Repository\Families\CreativeTechnologyLtd.SoundBlasterConnect*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCR:\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppModel\Repository\Families\DTSInc.DTSSoundUnbound*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCR:\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppModel\Repository\Families\RealtekSemiconductorCorp.RealtekAudioControl*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCR:\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppModel\Repository\Packages\A-Volute.Nahimic*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCR:\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppModel\Repository\Packages\A-Volute.SonicStudio*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCR:\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppModel\Repository\Packages\CreativeTechnologyLtd.SoundBlasterConnect*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCR:\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppModel\Repository\Packages\DTSInc.DTSSoundUnbound*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCR:\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppModel\Repository\Packages\RealtekSemiconductorCorp.RealtekAudioControl*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCR:\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppModel\SystemAppData\A-Volute.Nahimic*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCR:\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppModel\SystemAppData\A-Volute.SonicStudio*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCR:\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppModel\SystemAppData\CreativeTechnologyLtd.SoundBlasterConnect*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCR:\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppModel\SystemAppData\DTSInc.DTSSoundUnbound*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCR:\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppModel\SystemAppData\RealtekSemiconductorCorp.RealtekAudioControl*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCR:\Software\Classes\Local Settings\MrtCache\C:%5CProgram Files%5CWindowsApps%5CA-Volute.SonicStudio*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCR:\Software\Classes\Local Settings\MrtCache\C:%5CProgram Files%5CWindowsApps%5CCreativeTechnologyLtd.SoundBlasterConnect*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCR:\Software\Classes\Local Settings\MrtCache\C:%5CProgram Files%5CWindowsApps%5CDTSInc.DTSXUltra*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCR:\TypeLib\{78483DBF-C119-4E98-AFE9-E517AF9ECE4A}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCR:\WOW6432Node\AppID\CTAPO.DLL" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCR:\WOW6432Node\AppID\Dax3Ref.dll" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCR:\WOW6432Node\AppID\DTSDll.DLL" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCR:\WOW6432Node\AppID\Nahimicsfx.dll" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCR:\WOW6432Node\AppID\RTCOMDLL.DLL" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCR:\WOW6432Node\TypeLib\{78483DBF-C119-4E98-AFE9-E517AF9ECE4A}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCU:\Software\A-Volute" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\AppHost\IndexedDB\A-Volute.Nahimic*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\AppHost\IndexedDB\A-Volute.SonicStudio*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\AppHost\IndexedDB\CreativeTechnologyLtd.SoundBlasterConnect*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\AppHost\IndexedDB\DolbyLaboratories.DolbyAtmos*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\AppHost\IndexedDB\DTSInc.DTSSoundUnbound*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\AppHost\IndexedDB\DTSInc.DTSXUltra*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\AppHost\IndexedDB\RealtekSemiconductorCorp.RealtekAudioControl*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications\A-Volute.Nahimic*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications\A-Volute.SonicStudio*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications\CreativeTechnologyLtd.SoundBlasterConnect*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications\DolbyLaboratories.DolbyAtmos*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications\DTSInc.DTSSoundUnbound*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications\DTSInc.DTSXUltra*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications\RealtekSemiconductorCorp.RealtekAudioControl*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\cellularData\A-Volute.Nahimic*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\cellularData\A-Volute.SonicStudio*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\cellularData\CreativeTechnologyLtd.SoundBlasterConnect*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\cellularData\DolbyLaboratories.DolbyAtmos*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\cellularData\DTSInc.DTSSoundUnbound*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\microphone\A-Volute.Nahimic*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\microphone\A-Volute.SonicStudio*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\microphone\CreativeTechnologyLtd.SoundBlasterConnect*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\webcam\A-Volute.SonicStudio*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\PushNotifications\Applications\A-Volute.Nahimic*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\PushNotifications\Applications\A-Volute.SonicStudio*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\PushNotifications\Applications\CreativeTechnologyLtd.SoundBlasterConnect*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\PushNotifications\Applications\DolbyLaboratories.DolbyAtmos*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\PushNotifications\Applications\DTSInc.DTSSoundUnbound*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\PushNotifications\Applications\DTSInc.DTSXUltra*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\PushNotifications\Applications\RealtekSemiconductorCorp.RealtekAudioControl*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\UFH\SHC\*" -Force -ea SilentlyContinue
		Remove-Item -Path "HKCU:\Software\Microsoft\Windows\Shell\Associations\UrlAssociations\a-volute.SonicStudio*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCU:\Software\Microsoft\Windows\Shell\Associations\UrlAssociations\dolby-dax3*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCU:\Software\Microsoft\Windows\Shell\Associations\UrlAssociations\dts-sound-unbound" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCU:\Software\Microsoft\Windows\Shell\Associations\UrlAssociations\dtspostprocessing.dtsxultra" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCU:\Software\Microsoft\Windows\Shell\Associations\UrlAssociations\rtkuwp" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCU:\Software\Microsoft\Windows NT\CurrentVersion\HostActivityManager\CommitHistory\A-Volute.SonicStudio*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCU:\Software\Microsoft\Windows NT\CurrentVersion\HostActivityManager\CommitHistory\CreativeTechnologyLtd.SoundBlasterConnect*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCU:\Software\Microsoft\Windows NT\CurrentVersion\HostActivityManager\CommitHistory\DolbyLaboratories.DolbyAtmosforGaming*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCU:\Software\Microsoft\Windows NT\CurrentVersion\HostActivityManager\CommitHistory\DTSInc.DTSSoundUnbound*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCU:\Software\Microsoft\Windows NT\CurrentVersion\HostActivityManager\CommitHistory\DTSInc.DTSXUltra*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCU:\Software\Microsoft\Windows NT\CurrentVersion\HostActivityManager\CommitHistory\RealtekSemiconductorCorp.RealtekAudioControl*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCU:\Software\Classes\ActivatableClasses\Package\A-Volute.Nahimic*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCU:\Software\Classes\ActivatableClasses\Package\A-Volute.SonicStudio*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCU:\Software\Classes\ActivatableClasses\Package\CreativeTechnologyLtd.SoundBlasterConnect*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCU:\Software\Classes\ActivatableClasses\Package\DTSInc.DTSSoundUnbound*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCU:\Software\Classes\ActivatableClasses\Package\RealtekSemiconductorCorp.RealtekAudioControl*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCU:\Software\Classes\AppXj59z2hqwz9v0mx97rbdz25w9k1kzkb1g" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCU:\Software\Classes\AppX4419cyv9scbka8b5c8n2y7ytz3qhrx5p" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCU:\Software\Classes\AppX5y9g1y8x8cthhd1nd9gyrmyz0xztge18" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCU:\Software\Classes\AppXr3z76yc7tz4me3df0wxk3pmrah7n9rhz" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCU:\Software\Classes\a-volute.SonicStudio*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCU:\Software\Classes\dolby-dax3*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCU:\Software\Classes\dtspostprocessing.dtsxultra" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCU:\Software\Classes\dts-sound-unbound" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCU:\Software\Classes\Extensions\ContractId\Windows.AppService\PackageId\A-Volute.SonicStudio*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCU:\Software\Classes\Extensions\ContractId\Windows.AppService\PackageId\DTSInc.DTSSoundUnbound*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCU:\Software\Classes\Extensions\ContractId\Windows.AppService\PackageId\RealtekSemiconductorCorp.RealtekAudioControl*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCU:\Software\Classes\Extensions\ContractId\Windows.BackgroundTasks\PackageId\A-Volute.Nahimic*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCU:\Software\Classes\Extensions\ContractId\Windows.BackgroundTasks\PackageId\A-Volute.SonicStudio*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCU:\Software\Classes\Extensions\ContractId\Windows.BackgroundTasks\PackageId\CreativeTechnologyLtd.SoundBlasterConnect*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCU:\Software\Classes\Extensions\ContractId\Windows.BackgroundTasks\PackageId\DTSInc.DTSSoundUnbound*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCU:\Software\Classes\Extensions\ContractId\Windows.BackgroundTasks\PackageId\RealtekSemiconductorCorp.RealtekAudioControl*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCU:\Software\Classes\Extensions\ContractId\Windows.Launch\PackageId\A-Volute.Nahimic*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCU:\Software\Classes\Extensions\ContractId\Windows.Launch\PackageId\A-Volute.SonicStudio*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCU:\Software\Classes\Extensions\ContractId\Windows.Launch\PackageId\CreativeTechnologyLtd.SoundBlasterConnect*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCU:\Software\Classes\Extensions\ContractId\Windows.Launch\PackageId\DTSInc.DTSSoundUnbound*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCU:\Software\Classes\Extensions\ContractId\Windows.Launch\PackageId\RealtekSemiconductorCorp.RealtekAudioControl*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCU:\Software\Classes\Extensions\ContractId\Windows.Protocol\PackageId\A-Volute.Nahimic*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCU:\Software\Classes\Extensions\ContractId\Windows.Protocol\PackageId\A-Volute.SonicStudio*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCU:\Software\Classes\Extensions\ContractId\Windows.Protocol\PackageId\DTSInc.DTSSoundUnbound*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCU:\Software\Classes\Extensions\ContractId\Windows.Protocol\PackageId\RealtekSemiconductorCorp.RealtekAudioControl*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCU:\Software\Classes\Local Settings\MrtCache\C:%5CProgram Files%5CWindowsApps%5CA-Volute.SonicStudio*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCU:\Software\Classes\Local Settings\MrtCache\C:%5CProgram Files%5CWindowsApps%5CCreativeTechnologyLtd.SoundBlasterConnect*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCU:\Software\Classes\Local Settings\MrtCache\C:%5CProgram Files%5CWindowsApps%5CDTSInc.DTSXUltra*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCU:\Software\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppContainer\Storage\a-volute.nahimic*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCU:\Software\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppContainer\Storage\a-volute.sonicstudio*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCU:\Software\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppContainer\Storage\creativetechnologyltd.soundblasterconnect*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCU:\Software\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppContainer\Storage\dtsinc.dtssoundunbound*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCU:\Software\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppModel\PolicyCache\A-Volute.Nahimic*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCU:\Software\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppModel\PolicyCache\A-Volute.SonicStudio*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCU:\Software\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppModel\PolicyCache\CreativeTechnologyLtd.SoundBlasterConnect*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCU:\Software\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppModel\PolicyCache\DolbyLaboratories.DolbyAtmos*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCU:\Software\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppModel\PolicyCache\DTSInc.DTSSoundUnbound*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCU:\Software\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppModel\PolicyCache\DTSInc.DTSXUltra*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCU:\Software\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppModel\PolicyCache\RealtekSemiconductorCorp.RealtekAudioControl*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCU:\Software\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppModel\Repository\Families\A-Volute.Nahimic*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCU:\Software\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppModel\Repository\Families\A-Volute.SonicStudio*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCU:\Software\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppModel\Repository\Families\CreativeTechnologyLtd.SoundBlasterConnect*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCU:\Software\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppModel\Repository\Families\DTSInc.DTSSoundUnbound*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCU:\Software\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppModel\Repository\Families\RealtekSemiconductorCorp.RealtekAudioControl*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCU:\Software\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppModel\Repository\Packages\A-Volute.Nahimic*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCU:\Software\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppModel\Repository\Packages\A-Volute.SonicStudio*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCU:\Software\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppModel\Repository\Packages\CreativeTechnologyLtd.SoundBlasterConnect*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCU:\Software\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppModel\Repository\Packages\DTSInc.DTSSoundUnbound*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCU:\Software\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppModel\Repository\Packages\RealtekSemiconductorCorp.RealtekAudioControl*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCU:\Software\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppModel\SystemAppData\A-Volute.Nahimic*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCU:\Software\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppModel\SystemAppData\A-Volute.SonicStudio*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCU:\Software\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppModel\SystemAppData\CreativeTechnologyLtd.SoundBlasterConnect*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCU:\Software\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppModel\SystemAppData\DTSInc.DTSSoundUnbound*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCU:\Software\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppModel\SystemAppData\RealtekSemiconductorCorp.RealtekAudioControl*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCU:\Software\Microsoft\Phone\ShellUI\WindowSizing\A-Volute.SonicStudio*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCU:\Software\Microsoft\Phone\ShellUI\WindowSizing\CreativeTechnologyLtd.SoundBlasterConnect*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCU:\Software\Microsoft\Phone\ShellUI\WindowSizing\DolbyLaboratories.DolbyAtmos*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCU:\Software\Microsoft\Phone\ShellUI\WindowSizing\DTSInc.DTSSoundUnbound*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCU:\Software\Microsoft\Phone\ShellUI\WindowSizing\DTSInc.DTSXUltra*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCU:\Software\Microsoft\Phone\ShellUI\WindowSizing\RealtekSemiconductorCorp.RealtekAudioControl*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCU:\Software\Realtek" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCU:\Software\RegisteredApplications\AppXtwtxw0mce68ke0n7tpx8k64shmgtsw3k" -Force -ea SilentlyContinue
		Remove-Item -Path "HKCU:\Software\RegisteredApplications\AppXyzkzdbf9ba7kv925jzfm0fj9vpfz8q3n" -Force -ea SilentlyContinue
		Remove-Item -Path "HKCU:\Software\RegisteredApplications\AppX4chsjkvns0jjkfdeksek9ay2hajh2ew5" -Force -ea SilentlyContinue
		Remove-Item -Path "HKCU:\Software\RegisteredApplications\AppXw30gw27qtbx97hdc6ry7k944m1x1re9f" -Force -ea SilentlyContinue
		Remove-Item -Path "HKCU:\Software\RegisteredApplications\AppX60x3y46a3nc79ts0qnb6ajwc0zd3za62" -Force -ea SilentlyContinue
		Remove-ItemProperty -Name "*A-Volute.Nahimic*" -Path "HKCU:\Software\RegisteredApplications" -Force -ea SilentlyContinue
		Remove-ItemProperty -Name "*DTSInc.DTSSoundUnbound*" -Path "HKCU:\Software\RegisteredApplications" -Force -ea SilentlyContinue
		Remove-Item -Path "HKCU:\Software\Classes\a-volute.SonicStudio*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCU:\Software\Classes\ActivatableClasses\Package\A-Volute.Nahimic*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCU:\Software\Classes\ActivatableClasses\Package\A-Volute.SonicStudio*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCU:\Software\Classes\ActivatableClasses\Package\CreativeTechnologyLtd.SoundBlasterConnect*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCU:\Software\Classes\ActivatableClasses\Package\DolbyLaboratories.DolbyAtmos*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCU:\Software\Classes\ActivatableClasses\Package\DTSInc.DTSSoundUnbound*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCU:\Software\Classes\ActivatableClasses\Package\DTSInc.DTSXUltra*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCU:\Software\Classes\ActivatableClasses\Package\RealtekSemiconductorCorp.RealtekAudioControl*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCU:\Software\Classes\AppX4419cyv9scbka8b5c8n2y7ytz3qhrx5p" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCU:\Software\Classes\AppX5y9g1y8x8cthhd1nd9gyrmyz0xztge18" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCU:\Software\Classes\AppX6szhwxwfggxjdxt3n8akgb89acpwn92p" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCU:\Software\Classes\AppXr3z76yc7tz4me3df0wxk3pmrah7n9rhz" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCU:\Software\Classes\AppXxgzwrchmq2qzmqphep2m3vfevwky5q0f" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCU:\Software\Classes\dolby-dax3*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCU:\Software\Classes\dts-sound-unbound" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCU:\Software\Classes\dtspostprocessing.dtsxultra" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCU:\Software\Classes\Extensions\ContractId\Windows.AppService\PackageId\A-Volute.Nahimic*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCU:\Software\Classes\Extensions\ContractId\Windows.AppService\PackageId\A-Volute.SonicStudio*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCU:\Software\Classes\Extensions\ContractId\Windows.AppService\PackageId\DTSInc.DTSSoundUnbound*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCU:\Software\Classes\Extensions\ContractId\Windows.AppService\PackageId\RealtekSemiconductorCorp.RealtekAudioControl*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCU:\Software\Classes\Extensions\ContractId\Windows.BackgroundTasks\PackageId\A-Volute.Nahimic*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCU:\Software\Classes\Extensions\ContractId\Windows.BackgroundTasks\PackageId\A-Volute.SonicStudio*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCU:\Software\Classes\Extensions\ContractId\Windows.BackgroundTasks\PackageId\CreativeTechnologyLtd.SoundBlasterConnect*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCU:\Software\Classes\Extensions\ContractId\Windows.BackgroundTasks\PackageId\DolbyLaboratories.DolbyAtmos*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCU:\Software\Classes\Extensions\ContractId\Windows.BackgroundTasks\PackageId\DTSInc.DTSSoundUnbound*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCU:\Software\Classes\Extensions\ContractId\Windows.BackgroundTasks\PackageId\DTSInc.DTSXUltra*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCU:\Software\Classes\Extensions\ContractId\Windows.BackgroundTasks\PackageId\RealtekSemiconductorCorp.RealtekAudioControl*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCU:\Software\Classes\Extensions\ContractId\Windows.Launch\PackageId\A-Volute.Nahimic*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCU:\Software\Classes\Extensions\ContractId\Windows.Launch\PackageId\A-Volute.SonicStudio*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCU:\Software\Classes\Extensions\ContractId\Windows.Launch\PackageId\CreativeTechnologyLtd.SoundBlasterConnect*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCU:\Software\Classes\Extensions\ContractId\Windows.Launch\PackageId\DolbyLaboratories.DolbyAtmos*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCU:\Software\Classes\Extensions\ContractId\Windows.Launch\PackageId\DTSInc.DTSSoundUnbound*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCU:\Software\Classes\Extensions\ContractId\Windows.Launch\PackageId\DTSInc.DTSXUltra*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCU:\Software\Classes\Extensions\ContractId\Windows.Launch\PackageId\RealtekSemiconductorCorp.RealtekAudioControl*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCU:\Software\Classes\Extensions\ContractId\Windows.Protocol\PackageId\A-Volute.Nahimic*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCU:\Software\Classes\Extensions\ContractId\Windows.Protocol\PackageId\A-Volute.SonicStudio*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCU:\Software\Classes\Extensions\ContractId\Windows.Protocol\PackageId\DolbyLaboratories.DolbyAtmos*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCU:\Software\Classes\Extensions\ContractId\Windows.Protocol\PackageId\DTSInc.DTSSoundUnbound*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCU:\Software\Classes\Extensions\ContractId\Windows.Protocol\PackageId\DTSInc.DTSXUltra*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCU:\Software\Classes\Extensions\ContractId\Windows.Protocol\PackageId\RealtekSemiconductorCorp.RealtekAudioControl*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCU:\Software\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppContainer\Storage\a-volute.nahimic*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCU:\Software\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppContainer\Storage\a-volute.SonicStudio*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCU:\Software\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppContainer\Storage\creativetechnologyltd.soundblasterconnect*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCU:\Software\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppContainer\Storage\dolbylaboratories.dolbyatmos*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCU:\Software\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppContainer\Storage\dtsinc.dtssoundunbound*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCU:\Software\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppContainer\Storage\dtsinc.dtsxultra*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCU:\Software\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppContainer\Storage\realteksemiconductorcorp.realtekaudiocontrol*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCU:\Software\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppModel\PolicyCache\A-Volute.Nahimic*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCU:\Software\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppModel\PolicyCache\A-Volute.SonicStudio*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCU:\Software\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppModel\PolicyCache\CreativeTechnologyLtd.SoundBlasterConnect*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCU:\Software\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppModel\PolicyCache\DolbyLaboratories.DolbyAtmos*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCU:\Software\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppModel\PolicyCache\DTSInc.DTSSoundUnbound*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCU:\Software\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppModel\PolicyCache\DTSInc.DTSXUltra*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCU:\Software\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppModel\PolicyCache\RealtekSemiconductorCorp.RealtekAudioControl*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCU:\Software\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppModel\Repository\Families\A-Volute.Nahimic*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCU:\Software\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppModel\Repository\Families\A-Volute.SonicStudio*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCU:\Software\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppModel\Repository\Families\CreativeTechnologyLtd.SoundBlasterConnect*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCU:\Software\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppModel\Repository\Families\DolbyLaboratories.DolbyAtmos*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCU:\Software\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppModel\Repository\Families\DTSInc.DTSSoundUnbound*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCU:\Software\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppModel\Repository\Families\DTSInc.DTSXUltra*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCU:\Software\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppModel\Repository\Families\RealtekSemiconductorCorp.RealtekAudioControl*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCU:\Software\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppModel\Repository\Packages\A-Volute.Nahimic*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCU:\Software\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppModel\Repository\Packages\A-Volute.SonicStudio*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCU:\Software\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppModel\Repository\Packages\CreativeTechnologyLtd.SoundBlasterConnect*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCU:\Software\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppModel\Repository\Packages\DolbyLaboratories.DolbyAtmos*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCU:\Software\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppModel\Repository\Packages\DTSInc.DTSSoundUnbound*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCU:\Software\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppModel\Repository\Packages\DTSInc.DTSXUltra*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCU:\Software\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppModel\Repository\Packages\RealtekSemiconductorCorp.RealtekAudioControl*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCU:\Software\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppModel\SystemAppData\A-Volute.Nahimic*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCU:\Software\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppModel\SystemAppData\A-Volute.SonicStudio*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCU:\Software\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppModel\SystemAppData\CreativeTechnologyLtd.SoundBlasterConnect*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCU:\Software\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppModel\SystemAppData\DolbyLaboratories.DolbyAtmos*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCU:\Software\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppModel\SystemAppData\DTSInc.DTSSoundUnbound*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCU:\Software\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppModel\SystemAppData\DTSInc.DTSXUltra*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKCU:\Software\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppModel\SystemAppData\RealtekSemiconductorCorp.RealtekAudioControl*" -Recurse -Force -ea SilentlyContinue
		Remove-ItemProperty -Name "A-Volute.SonicStudio*" -Path "HKLM:\Software\Microsoft\UserData\UninstallTimes" -Force -ea SilentlyContinue
		Remove-ItemProperty -Name "CreativeTechnologyLtd.SoundBlasterConnect*" -Path "HKLM:\Software\Microsoft\UserData\UninstallTimes" -Force -ea SilentlyContinue
		Remove-ItemProperty -Name "RealtekSemiconductorCorp.RealtekAudioControl*" -Path "HKLM:\Software\Microsoft\UserData\UninstallTimes" -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\A-Volute" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Analog Devices\DTSAPO" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\ASIO" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\AppID\153bbac0-23cb-11e9-b56e-0800200c9a66" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\AppID\CTAPO.DLL" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\AppID\Dax3Ref.dll" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\AppID\DTSDll.DLL" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\AppID\Nahimicsfx.dll" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\AppID\RTCOMDLL.DLL" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\AppID\{0A21D954-674A-4C09-806E-DB4FBE8F199C}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\AppID\{18A5395C-F7C7-45D1-8D6D-F6BF56FE9427}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\AppID\{a42365ad-1377-4a04-9dde-1c7cb2938db6}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\AppID\{D9CF0A3B-E47C-41BC-9A88-9BEC290C5D93}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\AudioEngine\AudioProcessingObjects\{0212AE2C-F779-4A50-9B10-57A0AEF22870}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\AudioEngine\AudioProcessingObjects\{031392C9-4725-4F53-9A62-E75D902BA553}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\AudioEngine\AudioProcessingObjects\{07531B73-E4CA-4B94-9D0E-D3C9A7825FE5}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\AudioEngine\AudioProcessingObjects\{0EBD8505-17BB-4AE7-AD76-E86F99A425E9}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\AudioEngine\AudioProcessingObjects\{0EBD8505-27BB-4AE7-AD76-E86F99A425E9}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\AudioEngine\AudioProcessingObjects\{0EBD8506-17BB-4AE7-AD76-E86F99A425E9}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\AudioEngine\AudioProcessingObjects\{0EBD8506-27BB-4AE7-AD76-E86F99A425E9}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\AudioEngine\AudioProcessingObjects\{0EBD8507-17BB-4AE7-AD76-E86F99A425E9}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\AudioEngine\AudioProcessingObjects\{0EBD8507-27BB-4AE7-AD76-E86F99A425E9}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\AudioEngine\AudioProcessingObjects\{0EBD8508-17BB-4AE7-AD76-E86F99A425E9}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\AudioEngine\AudioProcessingObjects\{0EBD8508-27BB-4AE7-AD76-E86F99A425E9}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\AudioEngine\AudioProcessingObjects\{0EBD8509-17BB-4AE7-AD76-E86F99A425E9}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\AudioEngine\AudioProcessingObjects\{0EBD8509-27BB-4AE7-AD76-E86F99A425E9}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\AudioEngine\AudioProcessingObjects\{0EBD8510-17BB-4AE7-AD76-E86F99A425E9}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\AudioEngine\AudioProcessingObjects\{0EBD8510-27BB-4AE7-AD76-E86F99A425E9}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\AudioEngine\AudioProcessingObjects\{0EBD8511-17BB-4AE7-AD76-E86F99A425E9}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\AudioEngine\AudioProcessingObjects\{0EBD8511-27BB-4AE7-AD76-E86F99A425E9}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\AudioEngine\AudioProcessingObjects\{0EBD8512-17BB-4AE7-AD76-E86F99A425E9}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\AudioEngine\AudioProcessingObjects\{0EBD8512-27BB-4AE7-AD76-E86F99A425E9}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\AudioEngine\AudioProcessingObjects\{0F62DFB3-DB5B-458D-9371-6B45C4582560}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\AudioEngine\AudioProcessingObjects\{17AB05B2-E3B4-43FE-885B-06B84E251E5D}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\AudioEngine\AudioProcessingObjects\{1AAB27FA-5B3E-4CB1-9312-C66BD74FE739}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\AudioEngine\AudioProcessingObjects\{1BEDAECC-55F6-4149-95D9-A707A2FB4134}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\AudioEngine\AudioProcessingObjects\{27AFD1DB-3891-43EF-9888-CD558127FD42}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\AudioEngine\AudioProcessingObjects\{3B909255-8E8D-4997-8F8B-4C557F774D5F}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\AudioEngine\AudioProcessingObjects\{3CF95BBE-E76D-411C-A25C-BC94B072840E}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\AudioEngine\AudioProcessingObjects\{599C2638-CC15-4FFE-B16A-9246260D2DF7}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\AudioEngine\AudioProcessingObjects\{5F117246-A780-4B6C-B534-661509028E9F}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\AudioEngine\AudioProcessingObjects\{670173E3-78CF-11E5-A837-0800200C9A66}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\AudioEngine\AudioProcessingObjects\{670173E4-78CF-11E5-A837-0800200C9A66}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\AudioEngine\AudioProcessingObjects\{670173E5-78CF-11E5-A837-0800200C9A66}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\AudioEngine\AudioProcessingObjects\{670173F4-78CF-11E5-A837-0800200C9A66}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\AudioEngine\AudioProcessingObjects\{6E4DD785-E58A-4A6A-81D9-5EB9EB434EDA}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\AudioEngine\AudioProcessingObjects\{8B247353-92B7-4588-860C-6BB07BD74567}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\AudioEngine\AudioProcessingObjects\{97ACD2AB-83EC-494B-9FE4-922BCE1BD691}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\AudioEngine\AudioProcessingObjects\{A515262A-68B3-441A-A310-0D145362EE87}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\AudioEngine\AudioProcessingObjects\{C69FE6AD-9AA8-45DE-BA75-C72117B21C07}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\AudioEngine\AudioProcessingObjects\{D9916F9C-99F7-11E7-BF21-6C0B849889E1}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\AudioEngine\AudioProcessingObjects\{D9916F9D-99F7-11E7-BF21-6C0B849889E1}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\AudioEngine\AudioProcessingObjects\{D9916F9E-99F7-11E7-BF21-6C0B849889E1}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\AudioEngine\AudioProcessingObjects\{D9916F9F-99F7-11E7-BF21-6C0B849889E1}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\AudioEngine\AudioProcessingObjects\{D9916FA0-99F7-11E7-BF21-6C0B849889E1}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\AudioEngine\AudioProcessingObjects\{EFC7A7B3-40A7-4601-ABC1-878CD5EAE544}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\AudioEngine\AudioProcessingObjects\{FCDD3010-BB3F-4B24-8074-A18FC7D558F7}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\AudioEngine\AudioProcessingObjects\{71111103-AC62-4939-B476-4BB282B2B42C}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\AudioEngine\AudioProcessingObjects\{7121B512-6CC5-4C77-AE3A-823F966CCD3D}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\AudioEngine\AudioProcessingObjects\{8065FF2D-2394-4E99-999B-8F95C44F1799}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\AudioEngine\AudioProcessingObjects\{8068F4C9-F354-4BF1-8B69-EFB189A0761C}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\AudioEngine\AudioProcessingObjects\{806B324A-6827-46A8-AFD0-8AB09F8E6E61}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\AudioEngine\AudioProcessingObjects\{8081102E-9451-4412-A757-8404FEE22D52}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\AudioEngine\AudioProcessingObjects\{809191A2-FDE8-4A38-9F69-AC8E1AFEB9AD}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\AudioEngine\AudioProcessingObjects\{8101C8F5-13E9-43B0-8337-BC8586D600F9}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\AudioEngine\AudioProcessingObjects\{A27368B3-D810-42CE-B114-83900258B8EC}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\AudioEngine\AudioProcessingObjects\{A296D363-EE83-4AF9-9BE7-729C1296150A}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\AudioEngine\AudioProcessingObjects\{A29EB043-6CE2-4EE2-B38C-F58719E0D88F}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\AudioEngine\AudioProcessingObjects\{A51A19D6-80F1-4ABF-AB95-AF5215E8B052}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\AudioEngine\AudioProcessingObjects\{A69C91DC-11C4-414F-A919-4DA8EA3F3CA6}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\AudioEngine\AudioProcessingObjects\{A6EDD1A5-1ACA-4110-9B21-AD7EDC210CA3}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\AudioEngine\AudioProcessingObjects\{AB3B404A-B18F-4B4F-B91F-77F2DE95EB18}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\AudioEngine\AudioProcessingObjects\{DA2C9ECE-7418-4906-B4FA-0A00B3EB88AA}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\AudioEngine\AudioProcessingObjects\{DC253AB8-10DC-483C-AB5F-D6A4E189FD70}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\AudioEngine\AudioProcessingObjects\{EACD2258-FCAC-4FF4-B36D-419E924A6D79}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\AudioEngine\AudioProcessingObjects\{EC1CC9CE-FAED-4822-828A-82A81A6F018F}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\CLSID\{EACD2258-FCAC-4FF4-B36D-419E924A6D79}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\CLSID\{EC1CC9CE-FAED-4822-828A-82A81A6F018F}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\CLSID\{0113592D-0FDC-481F-88C8-294E28635456}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\CLSID\{0212AE2C-F779-4A50-9B10-57A0AEF22870}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\CLSID\{031392C9-4725-4F53-9A62-E75D902BA553}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\CLSID\{048E5288-25FF-4552-BFE0-A9B7DE629CBA}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\CLSID\{073E187F-BB72-4d0f-8368-C6A20CD9EA50}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\CLSID\{07531B73-E4CA-4B94-9D0E-D3C9A7825FE5}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\CLSID\{0E249A19-94DF-418A-9191-41D1FA0F3C2E}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\CLSID\{0EBD8505-17BB-4AE7-AD76-E86F99A425E9}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\CLSID\{0EBD8505-27BB-4AE7-AD76-E86F99A425E9}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\CLSID\{0EBD8506-17BB-4AE7-AD76-E86F99A425E9}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\CLSID\{0EBD8506-27BB-4AE7-AD76-E86F99A425E9}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\CLSID\{0EBD8507-17BB-4AE7-AD76-E86F99A425E9}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\CLSID\{0EBD8507-27BB-4AE7-AD76-E86F99A425E9}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\CLSID\{0EBD8508-17BB-4AE7-AD76-E86F99A425E9}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\CLSID\{0EBD8508-27BB-4AE7-AD76-E86F99A425E9}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\CLSID\{0EBD8509-17BB-4AE7-AD76-E86F99A425E9}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\CLSID\{0EBD8509-27BB-4AE7-AD76-E86F99A425E9}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\CLSID\{0EBD8510-17BB-4AE7-AD76-E86F99A425E9}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\CLSID\{0EBD8510-27BB-4AE7-AD76-E86F99A425E9}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\CLSID\{0EBD8511-17BB-4AE7-AD76-E86F99A425E9}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\CLSID\{0EBD8511-27BB-4AE7-AD76-E86F99A425E9}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\CLSID\{0EBD8512-17BB-4AE7-AD76-E86F99A425E9}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\CLSID\{0EBD8512-27BB-4AE7-AD76-E86F99A425E9}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\CLSID\{0F62DFB3-DB5B-458D-9371-6B45C4582560}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\CLSID\{11825B7C-5AA6-4E2F-A4BC-67659568E925}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\CLSID\{17AB05B2-E3B4-43FE-885B-06B84E251E5D}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\CLSID\{18FBF122-5E5C-48CC-A213-F396B43DC0D7}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\CLSID\{1AAB27FA-5B3E-4CB1-9312-C66BD74FE739}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\CLSID\{1BEDAECC-55F6-4149-95D9-A707A2FB4134}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\CLSID\{1FC71449-ACEC-420D-A3E9-7A0FC630926E}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\CLSID\{20532D01-15BE-4BB9-A727-CA34555D881C}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\CLSID\{2438FE00-BD99-49AF-9E48-D3B03885FA8B}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\CLSID\{248F37DE-5F40-4dc6-9B51-3A14C1D71FD5}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\CLSID\{26F518D6-88BB-4B03-B5B3-75147D609C90}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\CLSID\{272B9432-8AFD-4935-84B4-A77CFA09815E}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\CLSID\{28F69C2F-0073-4EDF-9AB9-97BB8C55C166}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\CLSID\{30543F69-1213-4284-9D0A-5CE5F71A82CD}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\CLSID\{31929B1C-6E3C-431c-A20D-2A2A8315344D}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\CLSID\{3739576F-F27B-4857-9E3E-8BAAA2A030B9}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\CLSID\{3833A070-8C55-4465-9B8F-BDBE0C6498B8}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\CLSID\{38361248-B055-4ea8-A373-940464FB318E}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\CLSID\{3A2B839D-6060-4711-B3A8-35132A881E78}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\CLSID\{3CF95BBE-E76D-411c-A25C-BC94B072840E}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\CLSID\{42D0571B-9239-4eee-B8A0-1C8B85608894}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\CLSID\{42E82F48-20E9-4B35-962A-4439059670D4}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\CLSID\{42F7121A-9917-4927-9E44-C9B305B0EDBB}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\CLSID\{44EE5F71-5DD2-4434-B1AA-16B850F4BEC5}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\CLSID\{45750165-6E3D-4413-AEE0-D486BC169E0B}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\CLSID\{498A0C2A-D4C5-4cbb-B62F-FB075A02F5A8}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\CLSID\{599C2638-CC15-4FFE-B16A-9246260D2DF7}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\CLSID\{5B05A596-33CA-4D65-B6C8-42704CA9BE2A}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\CLSID\{5F117246-A780-4B6C-B534-661509028E9F}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\CLSID\{615AC66B-72C3-4DEB-8F22-19B372142787}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\CLSID\{6201C0B0-A1DC-4AE2-9665-8DAB2E380073}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\CLSID\{670173E3-78CF-11E5-A837-0800200C9A66}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\CLSID\{670173E4-78CF-11E5-A837-0800200C9A66}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\CLSID\{670173E5-78CF-11E5-A837-0800200C9A66}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\CLSID\{670173F4-78CF-11E5-A837-0800200C9A66}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\CLSID\{68E6DF30-3484-489b-8120-3C4C0256A758}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\CLSID\{697A25AB-7233-4E22-A6AB-896387D1980F}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\CLSID\{6E4DD785-E58A-4A6A-81D9-5EB9EB434EDA}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\CLSID\{71111103-AC62-4939-B476-4BB282B2B42C}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\CLSID\{7121B512-6CC5-4C77-AE3A-823F966CCD3D}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\CLSID\{7505CB57-3A77-46a4-8B04-75897B0AA643}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\CLSID\{7e4ef2c1-2862-11e9-b56e-0800200c9a66}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\CLSID\{7ECCA61E-6028-4afa-B03C-B68004412CAF}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\CLSID\{8065FF2D-2394-4E99-999B-8F95C44F1799}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\CLSID\{8068F4C9-F354-4BF1-8B69-EFB189A0761C}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\CLSID\{806B324A-6827-46A8-AFD0-8AB09F8E6E61}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\CLSID\{8081102E-9451-4412-A757-8404FEE22D52}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\CLSID\{809191A2-FDE8-4A38-9F69-AC8E1AFEB9AD}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\CLSID\{8101C8F5-13E9-43B0-8337-BC8586D600F9}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\CLSID\{853B15F2-A9DE-4592-9FA9-7A69F6AEA6A2}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\CLSID\{88A0B959-0AAC-486e-90EC-90444C40F7EC}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\CLSID\{8B247353-92B7-4588-860C-6BB07BD74567}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\CLSID\{90D4AE46-D4E1-4AC8-9A7A-93776FB86FC0}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\CLSID\{93EC11E9-889B-458e-8DEE-B750C8AAC6C2}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\CLSID\{97ACD2AB-83EC-494B-9FE4-922BCE1BD691}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\CLSID\{9914A841-B21A-489C-949C-89306F33BF9A}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\CLSID\{9C4B415C-B076-43F4-928D-98D8B465087A}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\CLSID\{9D1C81FD-A77A-4cc0-BD6E-A827C9E38ACA}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\CLSID\{9F39C0AE-979D-4BFC-890D-4BDF6FD7BDE1}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\CLSID\{A27368B3-D810-42ce-B114-83900258B8EC}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\CLSID\{A296D363-EE83-4af9-9BE7-729C1296150A}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\CLSID\{A29EB043-6CE2-4ee2-B38C-F58719E0D88F}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\CLSID\{A4F8AE43-5C92-4DCC-AB3E-3CC4FC46ABC8}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\CLSID\{A515262A-68B3-441a-A310-0D145362EE87}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\CLSID\{A51A19D6-80F1-4abf-AB95-AF5215E8B052}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\CLSID\{A5A63314-41AC-484F-85B8-FC15335C24CF}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\CLSID\{A69C91DC-11C4-414f-A919-4DA8EA3F3CA6}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\CLSID\{A6EDD1A5-1ACA-4110-9B21-AD7EDC210CA3}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\CLSID\{A80362FF-CE76-4DD9-874A-704C57BF0D6A}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\CLSID\{A9C2CEBF-36DC-40A3-92E6-ED59FDD9D20D}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\CLSID\{AA9642C4-CE9B-4564-A57E-AC5B8F3E7D77}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\CLSID\{AB3B404A-B18F-4b4f-B91F-77F2DE95EB18}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\CLSID\{AC86A15E-8043-47BC-AE95-C0466E56F1AF}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\CLSID\{ACF17F45-928A-42A7-8591-B64CBA5EED63}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\CLSID\{AF099A7C-45D2-4CE6-9327-EEAAB0395444}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\CLSID\{B4928187-D2E3-4CFA-A2C2-A9C97B4956EA}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\CLSID\{b64ac411-2862-11e9-b56e-0800200c9a66}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\CLSID\{B9CF4A28-81F1-46AD-9071-F7215B349846}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\CLSID\{BBA39DEF-B0D8-4D50-9133-85D5B1AC7971}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\CLSID\{BC1F9ACF-DCA1-43d4-AFEE-D742DC11473C}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\CLSID\{C26C3384-7112-4b5a-8BB5-1328D9543D79}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\CLSID\{C51A2350-6AB3-44A5-8B32-61A9DBEBCF45}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\CLSID\{C5B4A9EB-034C-45D4-BFEF-4F08274EB9E2}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\CLSID\{C6606CA5-2108-4CAF-8E52-1953F2DBF716}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\CLSID\{C69FE6AD-9AA8-45DE-BA75-C72117B21C07}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\CLSID\{CC0CA09A-5B84-43F2-BE5C-9169C192565F}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\CLSID\{cdf28580-2862-11e9-b56e-0800200c9a66}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\CLSID\{CE93F536-D2FB-4e8f-8193-F57AD8BC90D5}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\CLSID\{d0d09f5b-08dd-4619-aa88-dc9cd2e794d1}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\CLSID\{D16DEBE9-40D9-41FA-9746-97FC1A152A9E}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\CLSID\{D9916F9C-99F7-11E7-BF21-6C0B849889E1}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\CLSID\{D9916F9D-99F7-11E7-BF21-6C0B849889E1}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\CLSID\{D9916F9E-99F7-11E7-BF21-6C0B849889E1}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\CLSID\{D9916F9F-99F7-11E7-BF21-6C0B849889E1}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\CLSID\{D9916FA0-99F7-11E7-BF21-6C0B849889E1}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\CLSID\{DA2C9ECE-7418-4906-B4FA-0A00B3EB88AA}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\CLSID\{DC253AB8-10DC-483c-AB5F-D6A4E189FD70}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\CLSID\{E0760680-E3E3-41A6-A5BE-275F5C21BDD9}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\CLSID\{E4D7C1C8-9459-45f8-A541-CE54DE835DD5}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\CLSID\{E51EF0ED-35D5-4bde-93E9-28CA62B1E704}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\CLSID\{E73377EB-B7EB-469F-9968-7FEDC46E3E9E}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\CLSID\{EFC7A7B3-40A7-4601-ABC1-878CD5EAE544}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\CLSID\{F2464A7E-5B09-4199-826F-7D6A16AF2E59}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\CLSID\{FBEBFC99-D58A-48F2-BD9B-96A9DE7DBDBA}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\CLSID\{FCDD3010-BB3F-4B24-8074-A18FC7D558F7}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\CLSID\{D38AC279-6A8A-4BEC-A559-E04D45E6393D}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppModel\PackageRepository\Extensions\ProgIDs\AppX4419cyv9scbka8b5c8n2y7ytz3qhrx5p" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppModel\PackageRepository\Extensions\ProgIDs\AppX5y9g1y8x8cthhd1nd9gyrmyz0xztge18" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppModel\PackageRepository\Extensions\ProgIDs\AppX6szhwxwfggxjdxt3n8akgb89acpwn92p" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppModel\PackageRepository\Extensions\ProgIDs\AppXr3z76yc7tz4me3df0wxk3pmrah7n9rhz" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppModel\PackageRepository\Extensions\ProgIDs\AppXxgzwrchmq2qzmqphep2m3vfevwky5q0f" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\SOFTWARE\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppModel\PackageRepository\Extensions\ProgIDs\AppXj59z2hqwz9v0mx97rbdz25w9k1kzkb1g" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppModel\PackageRepository\Extensions\windows.protocol\a-volute.SonicStudio*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppModel\PackageRepository\Extensions\windows.protocol\dolby-dax3*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppModel\PackageRepository\Extensions\windows.protocol\dts-sound-unbound" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppModel\PackageRepository\Extensions\windows.protocol\dtspostprocessing.dtsxultra" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppModel\PackageRepository\Extensions\windows.protocol\rtkuwp" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\SOFTWARE\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppModel\PackageRepository\Extensions\windows.protocol\nh3-msi" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\SOFTWARE\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppModel\PackageRepository\Packages\A-Volute.Nahimic*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppModel\PackageRepository\Packages\A-Volute.SonicStudio*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppModel\PackageRepository\Packages\CreativeTechnologyLtd.SoundBlasterConnect*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppModel\PackageRepository\Packages\DolbyLaboratories.DolbyAtmos*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppModel\PackageRepository\Packages\DTSInc.DTSSoundUnbound*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppModel\PackageRepository\Packages\DTSInc.DTSXUltra*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppModel\PackageRepository\Packages\RealtekSemiconductorCorp.RealtekAudioControl*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\SOFTWARE\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppModel\Deployment\Package\*\AllUsers\{15E8C9B1-EB89-4743-88C3-0E8866EB6C77}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppModel\Deployment\Package\*\AllUsers\{607DC7C5-2828-4484-AA21-307D9A3B7222}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppModel\Deployment\Package\*\AllUsers\{F7DF7BEB-002C-457E-8F70-48564E4427BC}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppModel\Deployment\Package\*\AllUsers\{15C36ADA-B3D3-4F67-9F78-95938EEA0C4D}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppModel\Deployment\Package\*\AllUsers\{EC55B85D-DF55-43F5-B475-CEF3990EB12C}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\RealtekLib.RtDataProc" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\RealtekLib.RtNuanceProc" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\RTCOMDLL.PropSet" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\SRS_APO_Universal.SRS_LFX_APO_Universal*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\SRS_APO_Universal.SRS_LFX_Capture_APO_Universal*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\TypeLib\{26F518D6-88BB-4B03-B5B3-75147D609C90}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\TypeLib\{28F69C2F-0073-4EDF-9AB9-97BB8C55C166}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\TypeLib\{7092F0B2-D28D-4095-95A7-6C37A97432A2}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\TypeLib\{71092E27-C34B-47D4-A961-8AD778F68191}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\TypeLib\{74D716F0-2862-11E9-B56E-0800200C9A66}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\TypeLib\{78483DBF-C119-4E98-AFE9-E517AF9ECE4A}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\TypeLib\{B7DE8AC9-9CAD-4B18-A7CE-42F3362D2B97}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\TypeLib\{C6E2F720-2862-11E9-B56E-0800200C9A66}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\WOW6432Node\AppID\153bbac0-23cb-11e9-b56e-0800200c9a66" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\WOW6432Node\AppID\CTAPO.DLL" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\WOW6432Node\AppID\Dax3Ref.dll" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\WOW6432Node\AppID\DTSDll.DLL" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\WOW6432Node\AppID\Nahimicsfx.dll" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\WOW6432Node\AppID\RTCOMDLL.DLL" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\WOW6432Node\AppID\{0A21D954-674A-4C09-806E-DB4FBE8F199C}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\WOW6432Node\AppID\{18A5395C-F7C7-45D1-8D6D-F6BF56FE9427}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\WOW6432Node\AppID\{a42365ad-1377-4a04-9dde-1c7cb2938db6}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\WOW6432Node\AppID\{D9CF0A3B-E47C-41BC-9A88-9BEC290C5D93}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\WOW6432Node\AudioEngine\AudioProcessingObjects\{0F62DFB3-DB5B-458D-9371-6B45C4582560}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\WOW6432Node\AudioEngine\AudioProcessingObjects\{17AB05B2-E3B4-43FE-885B-06B84E251E5D}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\WOW6432Node\AudioEngine\AudioProcessingObjects\{C69FE6AD-9AA8-45DE-BA75-C72117B21C07}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\WOW6432Node\CLSID\{0F62DFB3-DB5B-458D-9371-6B45C4582560}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\WOW6432Node\CLSID\{17AB05B2-E3B4-43FE-885B-06B84E251E5D}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\WOW6432Node\CLSID\{3739576F-F27B-4857-9E3E-8BAAA2A030B9}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\WOW6432Node\CLSID\{A80362FF-CE76-4DD9-874A-704C57BF0D6A}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\WOW6432Node\CLSID\{A9C2CEBF-36DC-40A3-92E6-ED59FDD9D20D}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\WOW6432Node\CLSID\{AF099A7C-45D2-4CE6-9327-EEAAB0395444}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\WOW6432Node\CLSID\{BBA39DEF-B0D8-4D50-9133-85D5B1AC7971}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\WOW6432Node\CLSID\{C6606CA5-2108-4CAF-8E52-1953F2DBF716}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\WOW6432Node\CLSID\{C69FE6AD-9AA8-45DE-BA75-C72117B21C07}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\WOW6432Node\CLSID\{CC0CA09A-5B84-43F2-BE5C-9169C192565F}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\WOW6432Node\CLSID\{d0d09f5b-08dd-4619-aa88-dc9cd2e794d1}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\WOW6432Node\Interface\{1191FCBC-AD6E-4991-992C-CA966DF163BC}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\WOW6432Node\Interface\{36CF0D6C-1E34-40AD-9CC3-EC6DAB247BFE}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\WOW6432Node\Interface\{6D734094-AED3-11E5-8376-F07959607BB1}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\WOW6432Node\Interface\{72C19E12-0DC9-4B15-9C40-A0AA7913EC8D}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\WOW6432Node\Interface\{7E4EF2C0-2862-11E9-B56E-0800200C9A66}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\WOW6432Node\Interface\{8BF259D5-2420-4AC9-B4A6-D49BB7F33A88}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\WOW6432Node\Interface\{A108D080-10D7-11E4-9191-0800200C9A66}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\WOW6432Node\Interface\{A108D081-10D7-11E4-9191-0800200C9A66}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\WOW6432Node\Interface\{A108D082-10D7-11E4-9191-0800200C9A66}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\WOW6432Node\Interface\{AA819549-4DB0-47B7-9646-BC653986E734}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\WOW6432Node\Interface\{B264EC4A-AE32-11E5-8374-F07959607BB1}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\WOW6432Node\Interface\{B64AC410-2862-11E9-B56E-0800200C9A66}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\WOW6432Node\Interface\{CCF707F9-DE56-48FC-B8AE-05AFD32CCCAA}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\WOW6432Node\Interface\{CF3F32EC-8681-438C-9AE8-3D80410F10AE}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\WOW6432Node\Interface\{DF5B03BC-7665-4FB9-BC23-D9AE845E8715}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\WOW6432Node\Interface\{E1AA2100-2862-11E9-B56E-0800200C9A66}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\WOW6432Node\Interface\{EB3266EB-878F-40DA-BBB3-5FBF84D1C7E4}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\WOW6432Node\TypeLib\{26F518D6-88BB-4B03-B5B3-75147D609C90}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\WOW6432Node\TypeLib\{28F69C2F-0073-4EDF-9AB9-97BB8C55C166}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\WOW6432Node\TypeLib\{7092F0B2-D28D-4095-95A7-6C37A97432A2}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\WOW6432Node\TypeLib\{71092E27-C34B-47D4-A961-8AD778F68191}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\WOW6432Node\TypeLib\{74D716F0-2862-11E9-B56E-0800200C9A66}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\WOW6432Node\TypeLib\{78483DBF-C119-4E98-AFE9-E517AF9ECE4A}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\WOW6432Node\TypeLib\{B7DE8AC9-9CAD-4B18-A7CE-42F3362D2B97}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\WOW6432Node\TypeLib\{C6E2F720-2862-11E9-B56E-0800200C9A66}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Dolby" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\DTS" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\EqualizerAPO" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\SOFTWARE\Microsoft\SecurityManager\CapAuthz\ApplicationsEx\A-Volute.Nahimic*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Microsoft\SecurityManager\CapAuthz\ApplicationsEx\A-Volute.SonicStudio*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Microsoft\SecurityManager\CapAuthz\ApplicationsEx\CreativeTechnologyLtd.SoundBlasterConnect*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Microsoft\SecurityManager\CapAuthz\ApplicationsEx\DolbyLaboratories.DolbyAtmos*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Microsoft\SecurityManager\CapAuthz\ApplicationsEx\DTSInc.DTSSoundUnbound*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Microsoft\SecurityManager\CapAuthz\ApplicationsEx\DTSInc.DTSXUltra*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Microsoft\SecurityManager\CapAuthz\ApplicationsEx\RealtekSemiconductorCorp.RealtekAudioControl*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\AppModel\StagingInfo\A-Volute.Nahimic*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\AppModel\StagingInfo\A-Volute.SonicStudio*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\AppModel\StagingInfo\CreativeTechnologyLtd.SoundBlasterConnect*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\AppModel\StagingInfo\DolbyLaboratories.DolbyAtmos*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\AppModel\StagingInfo\DTSInc.DTSXUltra*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\AppModel\StagingInfo\RealtekSemiconductorCorp.RealtekAudioControl*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\AppModel\StateRepository\Cache\*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\Appx\AppxAllUserStore\Applications\DTSInc.DTSSoundUnbound*" -Recurse -Force -ea SilentlyContinue
		Remove-ItemProperty -Name "{D38AC279-6A8A-4BEC-A559-E04D45E6393D}" -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\Explorer\ControlPanel\NameSpace" -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\MMDevices\Audio\Capture\{0625fa32-7654-491c-99d6-85e8715ac552}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\MMDevices\Audio\Capture\{27052db0-800c-4c4e-bcc4-10c841dae1c0}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\MMDevices\Audio\Capture\{45481f20-df9d-4de8-a99b-ce4bcf438e7f}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\MMDevices\Audio\Capture\{af1a476a-621c-4157-b213-f0a93d3264b7}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\MMDevices\Audio\Capture\{be9f0f57-7dbb-4ade-9360-3993f193de83}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\MMDevices\Audio\Capture\{f4bf79f5-2f78-4ee9-9009-14ca0eee5a66}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\MMDevices\Audio\Capture\{0c9ea20a-ef16-4c9c-baca-b9db068282c2}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\MMDevices\Audio\Capture\{2b6144d1-04a5-4d5f-903c-452b23d1e480}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\MMDevices\Audio\Capture\{3201f158-231b-4068-9eef-0c2aa5776b79}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\MMDevices\Audio\Capture\{3d0004d5-3621-4e48-9e40-386627d35238}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\MMDevices\Audio\Capture\{747182bd-bb6d-42d1-8e47-018dc12eeb2f}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\MMDevices\Audio\Capture\{838b5fb2-d1ac-402f-8b80-a91804aef5c9}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\MMDevices\Audio\Capture\{8b461a7b-7a8a-4b86-bca1-c368a3ced209}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\MMDevices\Audio\Capture\{954bb005-ebe6-4d6c-a098-2c7c75b30731}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\MMDevices\Audio\Capture\{9ff2395f-83eb-4c17-b077-78499f991452}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\MMDevices\Audio\Capture\{b16a0bf9-b887-4ab5-9f6c-07c4f138202d}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\MMDevices\Audio\Capture\{cb2b4bea-ad33-4745-9822-74aeaa66e9a6}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\MMDevices\Audio\Capture\{da4fa101-82fc-4111-9909-de2c11a83837}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\MMDevices\Audio\Capture\{f9b87f63-1deb-4672-8d2d-11735184c00d}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\MMDevices\Audio\Capture\{fcc3131b-f70d-43fb-b5bd-1deea2f91b9f}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\MMDevices\Audio\Capture\{5bdc1c93-392c-42d0-9cfa-c70c159c70c2}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\MMDevices\Audio\Capture\{5fb455b9-65ae-4759-816f-42b6feeffd74}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\MMDevices\Audio\Capture\{631ded76-292b-4c4e-a8b7-500b634c71ad}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\MMDevices\Audio\Capture\{67a6e567-2f0d-47fa-a1cd-34fe34c55093}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\MMDevices\Audio\Capture\{718d4d82-e834-400e-9a5d-1231dbfc29ae}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\MMDevices\Audio\Capture\{8d7b2351-b1b8-414f-9886-d47f28d78145}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\MMDevices\Audio\Capture\{b581cfa6-602a-4b64-945b-b39de3507996}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\MMDevices\Audio\Capture\{c4167b8d-6bbc-452a-a8b0-275fbe98645f}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\MMDevices\Audio\Capture\{c7442cd6-4f60-4f59-a7e3-94c5e05aaec9}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\MMDevices\Audio\Render\{02390f01-b264-45c7-a231-21c5004074df}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\MMDevices\Audio\Render\{0568d0c6-7174-4b7c-99f4-c951e823de4f}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\MMDevices\Audio\Render\{7eaa9ae5-2c91-4d7f-9424-85b223900cd4}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\MMDevices\Audio\Render\{a4135ab4-04fc-4de0-adc2-f053c6ccebd3}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\MMDevices\Audio\Render\{1642f5df-afdf-4e2b-bbd8-dbf6206f5eaf}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\MMDevices\Audio\Render\{a6bec63c-9287-4b42-8a77-18c0a18bdb86}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\MMDevices\Audio\Render\{c50168db-fa24-43a7-8602-1fa9ca430d96}" -Recurse -Force -ea SilentlyContinue
		Remove-ItemProperty -Name "*RtkTweakTool*" -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\SharedDLLs" -Force -ea SilentlyContinue
		Remove-ItemProperty -Name "RtkAudUService" -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\Run" -Force -ea SilentlyContinue
		Remove-ItemProperty -Name "*RtkTweakTool*" -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers" -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Nahimic" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Realtek" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\WOW6432Node\ASIO" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\WOW6432Node\Microsoft\SecurityManager\CapAuthz\ApplicationsEx\A-Volute.Nahimic*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\WOW6432Node\Microsoft\SecurityManager\CapAuthz\ApplicationsEx\A-Volute.SonicStudio*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\WOW6432Node\Microsoft\SecurityManager\CapAuthz\ApplicationsEx\CreativeTechnologyLtd.SoundBlasterConnect*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\WOW6432Node\Microsoft\SecurityManager\CapAuthz\ApplicationsEx\DolbyLaboratories.DolbyAtmos*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\WOW6432Node\Microsoft\SecurityManager\CapAuthz\ApplicationsEx\DTSInc.DTSSoundUnbound*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\WOW6432Node\Microsoft\SecurityManager\CapAuthz\ApplicationsEx\DTSInc.DTSXUltra*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\WOW6432Node\Microsoft\SecurityManager\CapAuthz\ApplicationsEx\RealtekSemiconductorCorp.RealtekAudioControl*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\WOW6432Node\Classes\AppID\153bbac0-23cb-11e9-b56e-0800200c9a66" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\WOW6432Node\Classes\AppID\CTAPO.DLL" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\WOW6432Node\Classes\AppID\Dax3Ref.dll" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\WOW6432Node\Classes\AppID\DTSDll.DLL" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\WOW6432Node\Classes\AppID\Nahimicsfx.dll" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\WOW6432Node\Classes\AppID\RTCOMDLL.DLL" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\WOW6432Node\Classes\AppID\{0A21D954-674A-4C09-806E-DB4FBE8F199C}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\WOW6432Node\Classes\AppID\{18A5395C-F7C7-45D1-8D6D-F6BF56FE9427}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\WOW6432Node\Classes\AppID\{a42365ad-1377-4a04-9dde-1c7cb2938db6}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\WOW6432Node\Classes\AppID\{D9CF0A3B-E47C-41BC-9A88-9BEC290C5D93}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\WOW6432Node\Classes\AudioEngine\AudioProcessingObjects\{0F62DFB3-DB5B-458D-9371-6B45C4582560}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\WOW6432Node\Classes\AudioEngine\AudioProcessingObjects\{17AB05B2-E3B4-43FE-885B-06B84E251E5D}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\WOW6432Node\Classes\AudioEngine\AudioProcessingObjects\{C69FE6AD-9AA8-45DE-BA75-C72117B21C07}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\WOW6432Node\Classes\CLSID\{0F62DFB3-DB5B-458D-9371-6B45C4582560}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\WOW6432Node\Classes\CLSID\{17AB05B2-E3B4-43FE-885B-06B84E251E5D}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\WOW6432Node\Classes\CLSID\{3739576F-F27B-4857-9E3E-8BAAA2A030B9}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\WOW6432Node\Classes\CLSID\{A80362FF-CE76-4DD9-874A-704C57BF0D6A}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\WOW6432Node\Classes\CLSID\{A9C2CEBF-36DC-40A3-92E6-ED59FDD9D20D}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\WOW6432Node\Classes\CLSID\{AF099A7C-45D2-4CE6-9327-EEAAB0395444}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\WOW6432Node\Classes\CLSID\{BBA39DEF-B0D8-4D50-9133-85D5B1AC7971}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\WOW6432Node\Classes\CLSID\{C6606CA5-2108-4CAF-8E52-1953F2DBF716}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\WOW6432Node\Classes\CLSID\{C69FE6AD-9AA8-45DE-BA75-C72117B21C07}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\WOW6432Node\Classes\CLSID\{CC0CA09A-5B84-43F2-BE5C-9169C192565F}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\WOW6432Node\Classes\CLSID\{d0d09f5b-08dd-4619-aa88-dc9cd2e794d1}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\WOW6432Node\Classes\TypeLib\{26F518D6-88BB-4B03-B5B3-75147D609C90}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\WOW6432Node\Classes\TypeLib\{28F69C2F-0073-4EDF-9AB9-97BB8C55C166}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\WOW6432Node\Classes\TypeLib\{7092F0B2-D28D-4095-95A7-6C37A97432A2}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\WOW6432Node\Classes\TypeLib\{71092E27-C34B-47D4-A961-8AD778F68191}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\WOW6432Node\Classes\TypeLib\{74D716F0-2862-11E9-B56E-0800200C9A66}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\WOW6432Node\Classes\TypeLib\{78483DBF-C119-4E98-AFE9-E517AF9ECE4A}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\WOW6432Node\Classes\TypeLib\{B7DE8AC9-9CAD-4B18-A7CE-42F3362D2B97}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\WOW6432Node\Classes\TypeLib\{C6E2F720-2862-11E9-B56E-0800200C9A66}" -Recurse -Force -ea SilentlyContinue
		Remove-ItemProperty -Name "*MyNewIcon*" -Path "HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\SharedDlls" -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\WOW6432Node\Realtek" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\SYSTEM\ControlSet001\Control\Class\{5989fce8-9cd0-467d-8a6a-5419e31529d4}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Class\{5989fce8-9cd0-467d-8a6a-5419e31529d4}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Class\{5c4c3332-344d-483c-8739-259e934c9cc8}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Class\{4d36e96c-e325-11ce-bfc1-08002be10318}" -Recurse -Force -ea SilentlyContinue
		Remove-ItemProperty -Name "{4D36E96C-E325-11CE-BFC1-08002BE10318}" -Path "HKLM:\SYSTEM\CurrentControlSet\Control\CoDeviceInstallers" -Force -ea SilentlyContinue
		Remove-ItemProperty -Name "*DolbyAPO*" -Path "HKLM:\SYSTEM\CurrentControlSet\Control\DeviceContainers\{00000000-0000-0000-FFFF-FFFFFFFFFFFF}\BaseContainers\{00000000-0000-0000-FFFF-FFFFFFFFFFFF}" -Force -ea SilentlyContinue
		Remove-ItemProperty -Name "*DolbyHSA*" -Path "HKLM:\SYSTEM\CurrentControlSet\Control\DeviceContainers\{00000000-0000-0000-FFFF-FFFFFFFFFFFF}\BaseContainers\{00000000-0000-0000-FFFF-FFFFFFFFFFFF}" -Force -ea SilentlyContinue
		Remove-ItemProperty -Name "*SS3APO*" -Path "HKLM:\SYSTEM\CurrentControlSet\Control\DeviceContainers\{00000000-0000-0000-FFFF-FFFFFFFFFFFF}\BaseContainers\{00000000-0000-0000-FFFF-FFFFFFFFFFFF}" -Force -ea SilentlyContinue
		Remove-ItemProperty -Name "*CTAPO*" -Path "HKLM:\SYSTEM\CurrentControlSet\Control\DeviceContainers\{00000000-0000-0000-FFFF-FFFFFFFFFFFF}\BaseContainers\{00000000-0000-0000-FFFF-FFFFFFFFFFFF}" -Force -ea SilentlyContinue
		Remove-ItemProperty -Name "*CTHSA*" -Path "HKLM:\SYSTEM\CurrentControlSet\Control\DeviceContainers\{00000000-0000-0000-FFFF-FFFFFFFFFFFF}\BaseContainers\{00000000-0000-0000-FFFF-FFFFFFFFFFFF}" -Force -ea SilentlyContinue
		Remove-ItemProperty -Name "*DTSInt*" -Path "HKLM:\SYSTEM\CurrentControlSet\Control\DeviceContainers\{00000000-0000-0000-FFFF-FFFFFFFFFFFF}\BaseContainers\{00000000-0000-0000-FFFF-FFFFFFFFFFFF}" -Force -ea SilentlyContinue
		Remove-ItemProperty -Name "*DTS4APO*" -Path "HKLM:\SYSTEM\CurrentControlSet\Control\DeviceContainers\{00000000-0000-0000-FFFF-FFFFFFFFFFFF}\BaseContainers\{00000000-0000-0000-FFFF-FFFFFFFFFFFF}" -Force -ea SilentlyContinue
		Remove-ItemProperty -Name "*DTS4HSA*" -Path "HKLM:\SYSTEM\CurrentControlSet\Control\DeviceContainers\{00000000-0000-0000-FFFF-FFFFFFFFFFFF}\BaseContainers\{00000000-0000-0000-FFFF-FFFFFFFFFFFF}" -Force -ea SilentlyContinue
		Remove-ItemProperty -Name "*RealtekAPO*" -Path "HKLM:\SYSTEM\CurrentControlSet\Control\DeviceContainers\{00000000-0000-0000-FFFF-FFFFFFFFFFFF}\BaseContainers\{00000000-0000-0000-FFFF-FFFFFFFFFFFF}" -Force -ea SilentlyContinue
		Remove-ItemProperty -Name "*RealtekCFG*" -Path "HKLM:\SYSTEM\CurrentControlSet\Control\DeviceContainers\{00000000-0000-0000-FFFF-FFFFFFFFFFFF}\BaseContainers\{00000000-0000-0000-FFFF-FFFFFFFFFFFF}" -Force -ea SilentlyContinue
		Remove-ItemProperty -Name "*RealtekHSA*" -Path "HKLM:\SYSTEM\CurrentControlSet\Control\DeviceContainers\{00000000-0000-0000-FFFF-FFFFFFFFFFFF}\BaseContainers\{00000000-0000-0000-FFFF-FFFFFFFFFFFF}" -Force -ea SilentlyContinue
		Remove-ItemProperty -Name "*02390f01-b264-45c7-a231-21c5004074df*" -Path "HKLM:\SYSTEM\CurrentControlSet\Control\DeviceContainers\{00000000-0000-0000-FFFF-FFFFFFFFFFFF}\BaseContainers\{00000000-0000-0000-FFFF-FFFFFFFFFFFF}" -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\SYSTEM\CurrentControlSet\Enum\HDAUDIO\FUNC_01&VEN_10EC&DEV_0221&SUBSYS_103C3397&REV_1000\4&158a5f66&0&0001" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\SYSTEM\CurrentControlSet\Enum\SWD\DRIVERENUM\{591cd622-9716-4b35-9dd5-f51fe449e9ea}#DolbyAPO&5&9e4f27*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\SYSTEM\CurrentControlSet\Enum\SWD\DRIVERENUM\{591cd622-9716-4b35-9dd5-f51fe449e9ea}#DolbyHSA&5&9e4f27*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\SYSTEM\CurrentControlSet\Enum\SWD\DRIVERENUM\{93cbe5a2-0799-4156-8e96-b47a15a4c66b}#SS3APO&5&9e4f27*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\SYSTEM\CurrentControlSet\Enum\SWD\DRIVERENUM\{975f967b-6149-4001-a093-fd3092f4d390}#CTAPO&5&9e4f27*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\SYSTEM\CurrentControlSet\Enum\SWD\DRIVERENUM\{975f967b-6149-4001-a093-fd3092f4d390}#CTHSA&5&9e4f27*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\SYSTEM\CurrentControlSet\Enum\SWD\DRIVERENUM\{c3351193-d5dc-4e5a-9638-06a200f41c0a}#DTSInt&5&9e4f27*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\SYSTEM\CurrentControlSet\Enum\SWD\DRIVERENUM\{ccbc11e8-c52c-4b7c-8ae6-cd4d36a3a743}#DTS4APO&5&9e4f27*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\SYSTEM\CurrentControlSet\Enum\SWD\DRIVERENUM\{ccbc11e8-c52c-4b7c-8ae6-cd4d36a3a743}#DTS4HSA&5&9e4f27*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\SYSTEM\CurrentControlSet\Enum\SWD\DRIVERENUM\{ccbc11e8-c52c-4b7c-8ae6-cd4d36a3a743}#RealtekAPO&5&9e4f27*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\SYSTEM\CurrentControlSet\Enum\SWD\DRIVERENUM\{ccbc11e8-c52c-4b7c-8ae6-cd4d36a3a743}#RealtekCFG&5&9e4f27*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\SYSTEM\CurrentControlSet\Enum\SWD\DRIVERENUM\{ccbc11e8-c52c-4b7c-8ae6-cd4d36a3a743}#RealtekHSA&5&9e4f27*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\SYSTEM\CurrentControlSet\Enum\SWD\MMDEVAPI\{0.0.0.00000000}.{c50168db-fa24-43a7-8602-1fa9ca430d96}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\SYSTEM\CurrentControlSet\Enum\SWD\MMDEVAPI\{0.0.0.00000000}.{02390f01-b264-45c7-a231-21c5004074df}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "$env:Public\Desktop\Realtek Audio Device Tweak.lnk" -Force -ea SilentlyContinue
		Remove-Item -Path "$env:Public\Desktop\AAF ALC Audio Policy Tweak Tool.lnk" -Force -ea SilentlyContinue
		Remove-Item -Path "$Env:LocalAppData\AAFStyle" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "$Env:LocalAppData\Packages\A-Volute.Nahimic*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "$Env:LocalAppData\Packages\A-Volute.SonicStudio*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "$Env:LocalAppData\Packages\CreativeTechnologyLtd.SoundBlasterConnect*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "$Env:LocalAppData\Packages\DolbyLaboratories.DolbyAtmos*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "$Env:LocalAppData\Packages\DTSInc.DTSSoundUnbound*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "$Env:LocalAppData\Packages\DTSInc.DTSXUltra*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "$Env:LocalAppData\Packages\RealtekSemiconductorCorp.RealtekAudioControl*" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "$Env:UserProfile\AppData\LocalLow\Microsoft\CryptnetUrlCache\Content\0D193F0CC28EFE3851D3319CAC9DF27D" -Force -ea SilentlyContinue
		Remove-Item -Path "$Env:UserProfile\AppData\LocalLow\Microsoft\CryptnetUrlCache\Content\2B4B1F137BC7AE46D0D0871B2EC54F71" -Force -ea SilentlyContinue
		Remove-Item -Path "$Env:UserProfile\AppData\LocalLow\Microsoft\CryptnetUrlCache\Content\57C8EDB95DF3F0AD4EE2DC2B8CFD4157" -Force -ea SilentlyContinue
		Remove-Item -Path "$Env:UserProfile\AppData\LocalLow\Microsoft\CryptnetUrlCache\Content\6BADA8974A10C4BD62CC921D13E43B18_711ED44619924BA6DC33E69F97E7FF63" -Force -ea SilentlyContinue
		Remove-Item -Path "$Env:UserProfile\AppData\LocalLow\Microsoft\CryptnetUrlCache\Content\7423F88C7F265F0DEFC08EA88C3BDE45_AA1E8580D4EBC816148CE81268683776" -Force -ea SilentlyContinue
		Remove-Item -Path "$Env:UserProfile\AppData\LocalLow\Microsoft\CryptnetUrlCache\Content\8890A77645B73478F5B1DED18ACBF795_C090A8C88B266C6FF99A97210E92B44D" -Force -ea SilentlyContinue
		Remove-Item -Path "$Env:UserProfile\AppData\LocalLow\Microsoft\CryptnetUrlCache\Content\DA3B6E45325D5FFF28CF6BAD6065C907_4350C5442E89A1A0F860D6E16B9A730D" -Force -ea SilentlyContinue
		Remove-Item -Path "$Env:UserProfile\AppData\LocalLow\Microsoft\CryptnetUrlCache\Content\DA3B6E45325D5FFF28CF6BAD6065C907_AB0AFAC4184BF4DB504DCE3CD13157DE" -Force -ea SilentlyContinue
		Remove-Item -Path "$Env:UserProfile\AppData\LocalLow\Microsoft\CryptnetUrlCache\MetaData\0D193F0CC28EFE3851D3319CAC9DF27D" -Force -ea SilentlyContinue
		Remove-Item -Path "$Env:UserProfile\AppData\LocalLow\Microsoft\CryptnetUrlCache\MetaData\2B4B1F137BC7AE46D0D0871B2EC54F71" -Force -ea SilentlyContinue
		Remove-Item -Path "$Env:UserProfile\AppData\LocalLow\Microsoft\CryptnetUrlCache\MetaData\57C8EDB95DF3F0AD4EE2DC2B8CFD4157" -Force -ea SilentlyContinue
		Remove-Item -Path "$Env:UserProfile\AppData\LocalLow\Microsoft\CryptnetUrlCache\MetaData\6BADA8974A10C4BD62CC921D13E43B18_711ED44619924BA6DC33E69F97E7FF63" -Force -ea SilentlyContinue
		Remove-Item -Path "$Env:UserProfile\AppData\LocalLow\Microsoft\CryptnetUrlCache\MetaData\7423F88C7F265F0DEFC08EA88C3BDE45_AA1E8580D4EBC816148CE81268683776" -Force -ea SilentlyContinue
		Remove-Item -Path "$Env:UserProfile\AppData\LocalLow\Microsoft\CryptnetUrlCache\MetaData\8890A77645B73478F5B1DED18ACBF795_C090A8C88B266C6FF99A97210E92B44D" -Force -ea SilentlyContinue
		Remove-Item -Path "$Env:UserProfile\AppData\LocalLow\Microsoft\CryptnetUrlCache\MetaData\DA3B6E45325D5FFF28CF6BAD6065C907_4350C5442E89A1A0F860D6E16B9A730D" -Force -ea SilentlyContinue
		Remove-Item -Path "$Env:UserProfile\AppData\LocalLow\Microsoft\CryptnetUrlCache\MetaData\DA3B6E45325D5FFF28CF6BAD6065C907_AB0AFAC4184BF4DB504DCE3CD13157DE" -Force -ea SilentlyContinue
		Remove-Item -Path "$Env:ProgramData\A-Volute" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "$Env:ProgramData\Creative\SoftwareLock" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "$Env:ProgramData\Dolby" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "$Env:ProgramData\Microsoft\Windows\ClipSVC\Archive\Apps\fe3196e1-bb10-a9f1-4d24-061d57d87207.xml" -Force -ea SilentlyContinue
		Remove-Item -Path "$Env:ProgramData\Microsoft\Windows\Start Menu\Programs\Administrative Tools\Realtek Audio Device Tweak.lnk" -Force -ea SilentlyContinue
		Remove-Item -Path "$Env:ProgramData\Microsoft\Windows\Start Menu\Programs\AAF Optimus" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "$Env:CommonProgramFiles\AAF" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "$Env:CommonProgramFiles\Realtek" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "$Env:ProgramFiles\AAF" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "$Env:ProgramFiles\Realtek" -Recurse -Force -ea SilentlyContinue
		Write-Host "Complete!"
		Write-Host ""
		Write-Host "Deleting AAF DCH Optimus Sound installer information..."
		# AAF DCH Optimus Sound
		Remove-Item -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\EqualizerAPO" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\{F132AF7F-7BCA-4EDE-8A7C-958108FE7DBD}_is1" -Recurse -Force -ea SilentlyContinue
		Remove-ItemProperty -Name "*AAF*" -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\Installer\Folders" -Force -ea SilentlyContinue
		Remove-ItemProperty -Name "*{7BECF9EA-ADD7-4ABD-9332-BC63AD0D4CE3}*" -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\Installer\Folders" -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\Installer\Features\E5987C8A1AF8092409532B1D077DDB13" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\Installer\Products\E5987C8A1AF8092409532B1D077DDB13" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\Installer\Features\AE9FCEB77DDADBA43923CB36DAD0C43E" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\Installer\Products\AE9FCEB77DDADBA43923CB36DAD0C43E" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\Installer\UpgradeCodes\3974E3745099EBB488073A9861C7A071" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Classes\Installer\UpgradeCodes\AB2CF005200637B42AE16E771F7E9678" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\Installer\UpgradeCodes\3974E3745099EBB488073A9861C7A071" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\Installer\UpgradeCodes\AB2CF005200637B42AE16E771F7E9678" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\Installer\UserData\S-1-5-18\Components\1828A7CAD69986840A46CCD941DA8D77" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\Installer\UserData\S-1-5-18\Components\19D7C8607F8D2674F8ABF6DEBD2C315A" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\Installer\UserData\S-1-5-18\Components\19FBEFCDCC8F6864BAB39467E2F55D7B" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\Installer\UserData\S-1-5-18\Components\21C9F61F06414FE49B2586C9655CE4DA" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\Installer\UserData\S-1-5-18\Components\22994B9B1EBBAC3418D1FC4E3ABA2353" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\Installer\UserData\S-1-5-18\Components\2DC1EB0821C10EE468DE083495B8F357" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\Installer\UserData\S-1-5-18\Components\2DC5F840FB817274FB073BAB39AEE4D2" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\Installer\UserData\S-1-5-18\Components\3ADA5384BAF00F2428C38AF35111247F" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\Installer\UserData\S-1-5-18\Components\53D7C84841BDE784C970C8EF4EC2167E" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\Installer\UserData\S-1-5-18\Components\5A1A0F8C43470BA49AD267702F202970" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\Installer\UserData\S-1-5-18\Components\5DF3E9F455CB09C47AB6DD1EADAFAD83" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\Installer\UserData\S-1-5-18\Components\897E7AEBFF00F224FA25575E038E34C3" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\Installer\UserData\S-1-5-18\Components\90D6770C7FF14314A8476F5A96B6FF39" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\Installer\UserData\S-1-5-18\Components\A55940997E61275449A0223DF2BBC033" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\Installer\UserData\S-1-5-18\Components\A988B106DAF731245A5E34137ED313E7" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\Installer\UserData\S-1-5-18\Components\AFD459952D17FD64A80E38F2B9FE4871" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\Installer\UserData\S-1-5-18\Components\B77E4A61C33885D41A4FF230C2AA7F69" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\Installer\UserData\S-1-5-18\Components\C00E783674DA7E548B77CB42B2C1241F" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\Installer\UserData\S-1-5-18\Components\C2089E5E6B7616740A2EC6B274532D63" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\Installer\UserData\S-1-5-18\Components\C437E03483E039846B0599E46E9210D6" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\Installer\UserData\S-1-5-18\Components\D143DA41E3CDCC74F91564839D28ED73" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\Installer\UserData\S-1-5-18\Components\D3EAEC3C2D70FDC42BDD681DD2FA6B8A" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\Installer\UserData\S-1-5-18\Components\DA6C3FA407EBF4742891999F09B5CAA6" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\Installer\UserData\S-1-5-18\Components\E42172E211EE3B4499D02ACF9FF51293" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\Installer\UserData\S-1-5-18\Components\F883FF3A6BC11654CAF190AA9CD97F7D" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\Installer\UserData\S-1-5-18\Components\FBFA190DFA1B7584CB8F8F61722EDC0A" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\Installer\UserData\S-1-5-18\Components\8C6F4B5F80CB5FB4CB91590752B7C98F" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\Installer\UserData\S-1-5-18\Components\A05527C8A763E1947961D02FFB47F2C7" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\Installer\UserData\S-1-5-18\Components\BCA25BCB04F969B478F35CDBBBB8D438" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\Installer\UserData\S-1-5-18\Products\E5987C8A1AF8092409532B1D077DDB13" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\Installer\UserData\S-1-5-18\Products\AE9FCEB77DDADBA43923CB36DAD0C43E" -Recurse -Force -ea SilentlyContinue
		# AAF Realtek Audio Device Tweak
		Remove-Item -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\{A8C7895E-8FA1-4290-9035-B2D170D7BD31}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\{7BECF9EA-ADD7-4ABD-9332-BC63AD0D4CE3}" -Recurse -Force -ea SilentlyContinue
		Remove-ItemProperty -Name "*A8C7895E-8FA1-4290-9035-B2D170D7BD31*" -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\Installer\Folders" -Force -ea SilentlyContinue
		Remove-ItemProperty -Name "*7BECF9EA-ADD7-4ABD-9332-BC63AD0D4CE3*" -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\Installer\Folders" -Force -ea SilentlyContinue
		Remove-Item -Path "$Env:SystemRoot\Installer\{A8C7895E-8FA1-4290-9035-B2D170D7BD31}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "$Env:SystemRoot\Installer\36c8db.msi" -Force -ea SilentlyContinue
		Remove-Item -Path "$Env:SystemRoot\Installer\SourceHash{A8C7895E-8FA1-4290-9035-B2D170D7BD31}" -Force -ea SilentlyContinue
		Remove-Item -Path "$Env:SystemRoot\Installer\{7BECF9EA-ADD7-4ABD-9332-BC63AD0D4CE3}" -Recurse -Force -ea SilentlyContinue
		Remove-Item -Path "$Env:SystemRoot\Installer\4f1020.msi" -Force -ea SilentlyContinue
		Remove-Item -Path "$Env:SystemRoot\Installer\SourceHash{7BECF9EA-ADD7-4ABD-9332-BC63AD0D4CE3}" -Force -ea SilentlyContinue
		Write-Host "Complete!"
		Write-Host ""
		Write-Host "Starting Windows audio services..."
		Start-Service -Name "Audiosrv"
		Start-Service -Name "AudioEndpointBuilder"
		Set-ExecutionPolicy Bypass -Scope LocalMachine -Confirm:$False -Force -wa SilentlyContinue
		Write-Host "Complete!"
		Write-Host ""
		Write-Host "Removal completed. Please, restart your computer."
		Start-Sleep -Seconds 60
        }
    1   {
        Write-Host "Nothing changed. Exiting..."
		Start-Sleep -Seconds 5
        }
    }
Write-Output $message