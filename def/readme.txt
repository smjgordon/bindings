Export definiton files for win32 dll -> dmd interfacing:

Use in the same way you would use an implib for linking into your application:

dmd -ofmyprogram.exe myprog.obj win32lib.def



You can use a .def to create a .lib (using DM's implib):

implib shell32.lib shell32.def


