del ..\d3dreflect.lib
del /y ..\..\internal\bin\Debug\*.*
del /y ..\..\internal\bin\Release\*.*
md Debug
md Release
cls
cd Debug
cl /LD /Y- /MT /Od /Zi -I..\..\..\..\zoren\external\DirectX\Include ..\d3dreflect.cpp
cd ..
cd Release
cl /LD /Y- /MT /O2 /LD /DLL /Zi -I..\..\..\..\zoren\external\DirectX\Include ..\d3dreflect.cpp
cd ..
coffimplib Release\d3dreflect.lib x86\d3dreflect.lib
md ..\..\internal\bin\Debug
md ..\..\internal\bin\Release
copy Debug\d3dreflect.dll ..\..\internal\bin\Debug
copy Release\d3dreflect.dll ..\..\internal\bin\Release
