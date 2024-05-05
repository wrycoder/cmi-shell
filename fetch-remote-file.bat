@echo off

set target=C5455-01-03.wav
rem set target=C10574-19.wav
set number=%target:C=%
set number=%number:~0,5%
set number=%number:\-=%
set /a "lownum=number - (number %% 2000)"
set /a "hinum=lownum + 1999"
set sharename=CD%lownum%-%hinum%
set /a "lownum=number - (number %% 100)"
set /a "hinum=lownum + 99"
echo \\fas-media\%sharename%\%lownum%-%hinum%
pushd \\fas-media\%sharename%\%lownum%-%hinum%
copy %target% c:\exports
popd
