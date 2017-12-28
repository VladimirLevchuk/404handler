@echo off
del *.nupkg 2> nul

msbuild BVNetwork.404Handler.Cms8.sln /t:Rebuild /p:Configuration=Release /v:m
rem echo %ErrorLevel%
if "%ErrorLevel%" neq "0" goto error

msbuild BVNetwork.404Handler.Cms9.sln /t:Rebuild /p:Configuration=Release /v:m
rem echo %ErrorLevel%
if "%ErrorLevel%" neq "0" goto error

msbuild BVNetwork.404Handler.Cms10.sln /t:Rebuild /p:Configuration=Release /v:m
rem echo %ErrorLevel%
if "%ErrorLevel%" neq "0" goto error

call ..\BVNetwork.404Handler.Tests\bin\Release\BVNetwork.404Handler.Tests.exe
rem echo %ErrorLevel%
if "%ErrorLevel%" neq "0" goto error

msbuild BVNetwork.404Handler.sln /t:Rebuild /p:Configuration=Release /v:m
rem echo %ErrorLevel%
if "%ErrorLevel%" neq "0" goto error

call ..\BVNetwork.404Handler.Tests\bin\Release\BVNetwork.404Handler.Tests.exe
rem echo %ErrorLevel%
if "%ErrorLevel%" neq "0" goto error


:end        
	echo Build successfully completed
	dir /b *.nupkg
	goto fin

:error      
	del *.nupkg 2>nul
	echo "Build FAILED, see output for details. Build results (if any) have been removed. "
	goto fin

:fin