@echo off
:: =================================================================
:: DEEP WINDOWS UPDATE REPAIR - ANGOLO DI WINDOWS
:: Reset completo librerie, SID e componenti di sistema
:: =================================================================

:: --- INIZIO BLOCCO AUTO-ELEVAZIONE ---
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
if '%errorlevel%' NEQ '0' (
    echo Richiesta privilegi di amministratore in corso...
    goto uacPrompt
) else ( goto gotAdmin )

:uacPrompt
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    echo UAC.ShellExecute "%~s0", "", "", "runas", 1 >> "%temp%\getadmin.vbs"
    "%temp%\getadmin.vbs"
    exit /B

:gotAdmin
    if exist "%temp%\getadmin.vbs" ( del "%temp%\getadmin.vbs" )
    pushd "%cd%"
    CD /D "%~dp0"
:: --- FINE BLOCCO AUTO-ELEVAZIONE ---

title Deep WU Repair - Angolo di Windows
color 0e

echo ===================================================
echo   RIPARAZIONE PROFONDA WINDOWS UPDATE
echo ===================================================
echo.
echo ATTENZIONE: Questo script ri-registra le librerie di sistema.
echo Utile se Windows Update restituisce errori di DLL mancanti.
echo.
pause

echo [1/4] Arresto servizi e pulizia cache...
net stop bits /y
net stop wuauserv /y
net stop cryptsvc /y

if exist "%systemroot%\System32\Catroot2" ren "%systemroot%\System32\Catroot2" "oldcatroot2" 2>nul
del /f /q "%windir%\WindowsUpdate.log" 2>nul
del /f /s /q "%windir%\SoftwareDistribution\*.*" >nul

echo [2/4] Ri-registrazione librerie DLL (Silent Mode)...
:: Usiamo /s per evitare centinaia di finestre popup di conferma
for %%i in (atl.dll jscript.dll msxml3.dll softpub.dll wuapi.dll wuaueng.dll wuaueng1.dll wucltui.dll wups.dll wups2.dll wuweb.dll quartz.dll) do (
    regsvr32.exe /s %windir%\system32\%%i
)

echo [3/4] Reset componenti crittografici...
:: Ciclo per deregistrare e poi registrare nuovamente
for %%i in (wintrust.dll initpki.dll dssenh.dll rsaenh.dll gpkcsp.dll sccbase.dll slbcsp.dll mssip32.dll cryptdlg.dll) do (
    regsvr32.exe /u /s %%i
    regsvr32.exe /s %%i
)

echo [4/4] Pulizia chiavi Registro Windows Update...
:: Cancellazione ID univoci che potrebbero causare conflitti (SusClientId)
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate" /v AccountDomainSid /f 2>nul
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate" /v PingID /f 2>nul
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate" /v SusClientId /f 2>nul

echo Ripristino servizi...
net start bits
net start wuauserv
net start cryptsvc

echo Forzo rilevamento aggiornamenti...
wuauclt /resetauthorization /detectnow

echo.
echo ===================================================
echo   RIPARAZIONE COMPLETATA!
echo ===================================================
echo Si consiglia di riavviare il PC e controllare
echo la presenza di aggiornamenti.
echo.
pause
exit