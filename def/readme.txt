Export definiton files for win32 dll -> dmd interfacing:

Use in the same way you would use an implib for linking into your application:

dmd -ofmyprogram.exe myprog.obj win32lib.def




