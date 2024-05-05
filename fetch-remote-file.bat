@echo off

set target=C5455-01-03.wav
echo %target%
set number=%target:C=%
set number=%number:~0,4%

echo %number%
set /a "lownum=number - (number %% 2000)"
set /a "hinum=lownum + 1999"
set sharename=CD%lownum%-%hinum%
set /a "lownum=number - (number %% 100)"
set /a "hinum=lownum + 99"
pushd \\fas-media\%sharename%\%lownum%-%hinum%
copy %target% c:\exports
popd
