# Use this command to modify the sox path in CMI export files (CMI-A.bat, CMI-B.bat, etc.)
# Here's how to invoke it:
#
#    sed -i '' -f sox_path_fix.sed [CMI batch file]
#
s|C:\\sox-14-4-2\\sox\.exe|"C:\\Program Files (x86)\\sox-14-4-2\\sox.exe"|g
