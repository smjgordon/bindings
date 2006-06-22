@echo off
@\dmd\bin\dmd.exe examples\example.d import\sqstdlib.d import\squirrel.d import\squirreld.d lib\sqstdlib.lib lib\squirrel.lib -O -odexamples -ofexamples\example.exe
@DEL /Q examples\*.obj 2>NUL >NUL
@DEL /Q examples\example.map 2>NUL >NUL
@DEL /Q example.map 2>NUL >NUL