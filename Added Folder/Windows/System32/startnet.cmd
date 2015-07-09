@echo off
set DRIVES=C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z
for %%i IN (%DRIVES%) DO (call :Find_MININT %%i)
goto Find_TS

:Find_MININT
cd /d %1:\ 1>nul 2>nul
if errorlevel 1 goto :EOF
if exist "%1:\MININT" set MININT=%1
goto :EOF

:Find_TS
set DRIVES=C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z
for %%i IN (%DRIVES%) DO (call :Find_TS-2 %%i)
IF Defined MININT Goto Found_TS
IF Defined TS Goto Found_TS
Goto LaunchLTI

:Find_TS-2
cd /d %1:\ 1>nul 2>nul
if errorlevel 1 goto :EOF
if exist "%1:\_SMSTaskSequence" set TS=%1
goto :EOF



:Found_TS
set /p choice= An existing Task Sequence has been detected, do you want to delete this? Y/N:
if /I "%choice%" == "y" goto DeleteTS
if /I "%choice%" == "n" goto LaunchLTI
Goto Found_TS
:DeleteTS
IF Defined MININT RD %MININT%:\MININT /S /Q
IF Defined TS RD %TS%:\_SMSTaskSequence /S /Q

:LaunchLTI
Exit