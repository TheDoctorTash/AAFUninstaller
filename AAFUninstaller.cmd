@echo off
echo off
setlocal enableextensions enabledelayedexpansion
reg query "HKU\S-1-5-19\Environment" & cls
if %errorlevel% neq 0 (
	echo: Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
	echo: UAC.ShellExecute "%~f0", "", "", "runas", 0 >> "%temp%\getadmin.vbs"
	"%temp%\getadmin.vbs" goto :eof )
if exist "%temp%\getadmin.vbs" ( del /f /q "%temp%\getadmin.vbs" ) & goto :eof
pushd "%cd%"
cd /d "%~dp0"
if /i not "%cd%\"=="%~dp0" cd /d "%~dp0"
set MyOS=x64&(if "%PROCESSOR_ARCHITECTURE%"=="x86" if not defined PROCESSOR_ARCHITEW6432 set MyOS=x86)
set SystemUser=%~dp0\Resources\superUser_%MyOS%.exe -w -c
cls
%SystemUser% powershell.exe -ExecutionPolicy Bypass -file "%~dp0\Resources\AAFUninstaller.ps1" -WarningAction SilentlyContinue | break
exit