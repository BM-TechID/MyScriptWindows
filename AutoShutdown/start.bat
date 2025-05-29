@echo off
cd /d C:\
mkdir Mytask 2>nul

echo Mengunduh autosutdown.bat...
powershell -Command "Invoke-WebRequest -Uri 'https://raw.githubusercontent.com/BM-TechID/MyScriptWindows/refs/heads/main/AutoShutdown/autosutdown.bat' -OutFile 'C:\Mytask\autosutdown.bat'"

echo Membuat Scheduled Task harian jam 16:55 (force overwrite)...
schtasks /create /tn "AutoShutdownTask" /tr "C:\Mytask\autosutdown.bat" /sc daily /st 16:55 /f

echo Selesai.
pause

del "%~f0"
