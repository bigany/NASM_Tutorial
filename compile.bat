@echo off
set ProjectName=%1
set objName=%2
if "%ProjectName%"=="" (set ProjectName=hello_world.c)

set AdditionalLinkerLib=%3

set Compiler=msvc
if "%Compiler%"=="msvc" (
    REM    Set up the Visual Studio environment variables for calling the MSVC compiler;
    REM    we do this after the call to pushd so that the top directory on the stack
    REM    is saved correctly; the check for DevEnvDir is to make sure the vcvarsall.bat
    REM    is only called once per-session (since repeated invocations will screw up
    REM    the environment)
    if not defined DevEnvDir (
        call "%vs2017installdir%\VC\Auxiliary\Build\vcvarsall.bat" x64
        REM    Or maybe you're on VS 2015? Call this instead:
        REM call "C:\Program Files (x86)\Microsoft Visual Studio 14.0\VC\vcvarsall.bat" x64
    )
)
REM /FA --- get list /fp:fast
set CompileCommand=cl "%ProjectName%" "%objName%" /Ox /FA /fp:fast /arch:AVX2 /link /subsystem:console /entry:main /incremental:no /machine:x64  /defaultlib:Kernel32.lib /defaultlib:User32.lib /defaultlib:ucrt.lib /defaultlib:msvcrt.lib /opt:ref %AdditionalLinkerLib%

echo.
echo Compiling (command follows below)...
echo %CompileCommand%

%CompileCommand%