@echo off
cd /d C:\

rem --- Cek folder Mytask ---
if exist Mytask (
    echo Folder C:\Mytask sudah ada.
) else (
    echo Folder C:\Mytask tidak ada, membuat folder...
    mkdir Mytask
)

rem --- Cek file autosutdown.bat ---
set "file=C:\Mytask\autosutdown.bat"
set "fileexists=0"
if exist "%file%" (
    for %%I in ("%file%") do set size=%%~zI
    if defined size (
        if %size% GTR 0 (
            echo File autosutdown.bat sudah ada dengan ukuran %size% byte.
            set fileexists=1
        ) else (
            echo File autosutdown.bat kosong, akan didownload ulang.
        )
    ) else (
        echo Gagal cek ukuran file, akan didownload ulang.
    )
) else (
    echo File autosutdown.bat tidak ditemukan, akan didownload.
)

rem --- Download file jika perlu ---
if "%fileexists%"=="0" (
    echo Mengunduh autosutdown.bat...
    powershell -Command "Invoke-WebRequest -Uri 'https://raw.githubusercontent.com/BM-TechID/MyScriptWindows/refs/heads/main/AutoShutdown/autosutdown.bat' -OutFile '%file%'"
) else (
    echo Melewati download autosutdown.bat.
)

rem --- Cek Scheduled Task ---
schtasks /query /tn "AutoShutdownTask" >nul 2>&1
if %errorlevel%==0 (
    echo Scheduled Task AutoShutdownTask sudah ada.
    set taskexists=1
) else (
    echo Scheduled Task AutoShutdownTask tidak ditemukan.
    set taskexists=0
)

rem --- Buat Scheduled Task jika belum ada ---
if "%taskexists%"=="0" (
    echo Membuat Scheduled Task AutoShutdownTask...
    schtasks /create /tn "AutoShutdownTask" /tr "%file%" /sc daily /st 16:55 /f
) else (
    echo Melewati pembuatan Scheduled Task.
)

echo Selesai.
pause
