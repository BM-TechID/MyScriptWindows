@echo off
setlocal enabledelayedexpansion

set /a total=3

echo Tekan tombol apapun untuk membatalkan shutdown.
timeout /t 2 >nul

:countdown
cls
echo Tekan tombol apapun untuk membatalkan shutdown.
echo.
echo Komputer akan mati otomatis dalam %total% menit jika tidak ada respon.
echo.

choice /n /t 60 /d y >nul
if errorlevel 1 (
    echo.
    echo Ada respon (tombol ditekan), shutdown dibatalkan.
    pause
    exit /b 0
)

set /a total-=1
if %total% GEQ 0 goto countdown

cls
echo Tidak ada respon selama 3 menit, shutdown paksa.
shutdown /s /f /t 0
