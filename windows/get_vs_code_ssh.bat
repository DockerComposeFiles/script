@echo off

set "source_path=%USERPROFILE%\.ssh"
set "target_path=.\ssh"

echo %target_path%

if exist "%target_path%" (
    rmdir /s /q "%target_path%"
)

:: Überprüfen, ob die Ziel- und Quell-Pfade existieren
if not exist "%source_path%" echo Fehler: SSH-Konfiguration nicht gefunden & pause & exit /b
if not exist "%target_path%" mkdir "%target_path%"

:: Kopieren des gesamten Ordners mit xcopy
xcopy /e /i /y "%source_path%\*" "%target_path%\"

echo SSH-Konfiguration kopiert.
pause
