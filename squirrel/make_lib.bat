@echo off
@DIR /b c\squirrel\*.cpp > list.txt
@FOR /F %%i IN (list.txt) DO @\dm\bin\dmc.exe -i c\squirrel -i c\include -c c\squirrel\%%i >NUL 2> NUL
@DEL lib\squirrel.lib 2>NUL >NUL
@\dm\bin\lib.exe -c lib\squirrel.lib sqapi.obj sqbaselib.obj sqclass.obj sqcompiler.obj sqdebug.obj sqfuncstate.obj sqlexer.obj sqmem.obj sqobject.obj sqstate.obj sqtable.obj sqvm.obj > NUL
@DEL list.txt
@DEL /Q *.obj