@ECHO OFF
SETLOCAL ENABLEEXTENSIONS

IF NOT "%~1"=="" IF "%~2"=="" GOTO BEGIN
ECHO Please specify the target folder (MON2, TUE2, ...)
GOTO :EOF

:BEGIN
SET folder=%1

REM DIR /A:D /B

FOR /d %%s IN (%folder%/*) DO RENAME %folder%\%%s\REMO1001.WAV %folder%%%s-S1-IN.WAV 1>nul 2>nul
FOR /d %%s IN (%folder%/*) DO RENAME %folder%\%%s\REMO1002.WAV %folder%%%s-S1-OUT.WAV 1>nul 2>nul
FOR /d %%s IN (%folder%/*) DO RENAME %folder%\%%s\REMO1003.WAV %folder%%%s-S2-IN.WAV 1>nul 2>nul
FOR /d %%s IN (%folder%/*) DO RENAME %folder%\%%s\REMO1004.WAV %folder%%%s-S2-OUT.WAV 1>nul 2>nul
FOR /d %%s IN (%folder%/*) DO RENAME %folder%\%%s\REMO1005.WAV %folder%%%s-S3-IN.WAV 1>nul 2>nul
FOR /d %%s IN (%folder%/*) DO RENAME %folder%\%%s\REMO1006.WAV %folder%%%s-S3-OUT.WAV 1>nul 2>nul
FOR /d %%s IN (%folder%/*) DO RENAME %folder%\%%s\REMO1007.WAV %folder%%%s-S4-IN.WAV 1>nul 2>nul
FOR /d %%s IN (%folder%/*) DO RENAME %folder%\%%s\REMO1008.WAV %folder%%%s-S4-OUT.WAV 1>nul 2>nul
FOR /d %%s IN (%folder%/*) DO RENAME %folder%\%%s\REMO1009.WAV %folder%%%s-S5-IN.WAV 1>nul 2>nul
FOR /d %%s IN (%folder%/*) DO RENAME %folder%\%%s\REMO1010.WAV %folder%%%s-S5-OUT.WAV 1>nul 2>nul
FOR /d %%s IN (%folder%/*) DO RENAME %folder%\%%s\REMO1011.WAV %folder%%%s-S6-IN.WAV 1>nul 2>nul
FOR /d %%s IN (%folder%/*) DO RENAME %folder%\%%s\REMO1012.WAV %folder%%%s-S6-OUT.WAV 1>nul 2>nul

REM RENAME %%s\REMO10001.WAV %folder%-S1-IN.WAV 

@ECHO DONE