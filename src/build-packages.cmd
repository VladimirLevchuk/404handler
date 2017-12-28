@echo off
del *.nupkg 2> nul

echo building CMS8
msbuild BVNetwork.404Handler.Cms8.sln /t:Rebuild /p:Configuration=Release /v:m
rem echo %ErrorLevel%
if "%ErrorLevel%" neq "0" goto error
echo CMS8 - built

echo building CMS9
msbuild BVNetwork.404Handler.Cms9.sln /t:Rebuild /p:Configuration=Release /v:m
rem echo %ErrorLevel%
if "%ErrorLevel%" neq "0" goto error
echo CMS9 - built

echo building CMS10
msbuild BVNetwork.404Handler.Cms10.sln /t:Rebuild /p:Configuration=Release /v:m
rem echo %ErrorLevel%
if "%ErrorLevel%" neq "0" goto error
echo CMS10 built

call ..\BVNetwork.404Handler.Tests\bin\Release\BVNetwork.404Handler.Tests.exe
rem echo %ErrorLevel%
if "%ErrorLevel%" neq "0" goto error

echo building CMS11
msbuild BVNetwork.404Handler.sln /t:Rebuild /p:Configuration=Release /v:m
rem echo %ErrorLevel%
if "%ErrorLevel%" neq "0" goto error
echo CMS11 built

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