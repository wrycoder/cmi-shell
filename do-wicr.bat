@ECHO OFF
SETLOCAL ENABLEEXTENSIONS

IF NOT "%~1"=="" IF "%~2"=="" GOTO BEGIN
ECHO Please specify the source directory
GOTO :EOF

:BEGIN
SET sourcedir="%~1"
PUSHD "\\FAS-MEDIA\IMPORT\AV PROGRAMS"
COPY %sourcedir%\CMI-A1*.WAV .
COPY %sourcedir%\CMI-A2*.WAV .
COPY %sourcedir%\CMI-A3*.WAV .
COPY %sourcedir%\CMI-L3*.WAV .
COPY %sourcedir%\CMI-N4*.WAV .
COPY %sourcedir%\CMI-P1*.WAV .
COPY %sourcedir%\CMI-P2*.WAV .
POPD
@ECHO DONE