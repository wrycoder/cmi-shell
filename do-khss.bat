@ECHO OFF
SETLOCAL ENABLEEXTENSIONS

IF NOT "%~1"=="" IF "%~2"=="" GOTO BEGIN
ECHO Please specify the source directory
GOTO :EOF

:BEGIN
SET sourcedir="%~1"
PUSHD "\\FAS-MEDIA\KHSS IMPORT"
COPY %sourcedir%\CMI-A*.WAV .
COPY %sourcedir%\CMI-P*.WAV .
COPY %sourcedir%\CMI-L*.WAV .
COPY %sourcedir%\CMI-N*.WAV .
POPD
@ECHO DONE