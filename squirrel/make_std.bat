@echo off
@DIR /b c\sqstdlib\*.cpp > list.txt
@FOR /F %%i IN (list.txt) DO @\dm\bin\dmc.exe -i c\sqstdlib -i c\include -c c\sqstdlib\%%i >NUL 2>NUL
@DEL lib\sqstdlib.lib 2>NUL >NUL
@\dm\bin\lib.exe -c lib\sqstdlib.lib sqstdaux.obj sqstdblob.obj sqstdio.obj sqstdmath.obj sqstdrex.obj sqstdstream.obj sqstdstring.obj sqstdsystem.obj > NUL
@DEL list.txt
@DEL /Q *.obj