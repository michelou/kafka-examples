@echo off
setlocal enabledelayedexpansion

@rem only for interactive debugging !
set _DEBUG=0

@rem #########################################################################
@rem ## Environment setup

set _EXITCODE=0

@rem copyright dates
set _COPYRIGHT_DATES_OLD=2018-2024
set _COPYRIGHT_DATES_NEW=2018-2025

call :env
if not %_EXITCODE%==0 goto end

call :args %*
if not %_EXITCODE%==0 goto end

@rem #########################################################################
@rem ## Main

if %_HELP%==1 (
    call :help
    exit /b !_EXITCODE!
)
if %_RUN%==1 (
    for %%i in (examples) do (
       if %_DEBUG%==1 echo %_DEBUG_LABEL% call :update_project "%_ROOT_DIR%\%%i" 1>&2
        call :update_project "%_ROOT_DIR%\%%i"
    )
)
goto end

@rem #########################################################################
@rem ## Subroutines

@rem output parameters: _DEBUG_LABEL, _ERROR_LABEL, _WARNING_LABEL
:env
set _BASENAME=%~n0
for /f "delims=" %%f in ("%~dp0\.") do set "_ROOT_DIR=%%~dpf"
@rem remove trailing backslash for virtual drives
if "%_ROOT_DIR:~-2%"==":\" set "_ROOT_DIR=%_ROOT_DIR:~0,-1%"

call :env_colors
set _DEBUG_LABEL=%_NORMAL_BG_CYAN%[%_BASENAME%]%_RESET%
set _ERROR_LABEL=%_STRONG_FG_RED%Error%_RESET%:
set _WARNING_LABEL=%_STRONG_FG_YELLOW%Warning%_RESET%:

if not exist "%GIT_HOME%\usr\bin\grep.exe" (
    echo %_ERROR_LABEL% Grep command not found 1>&2
    set _EXITCODE=1
    goto :eof
)
set "_GREP_CMD=%GIT_HOME%\usr\bin\grep.exe"
set "_SED_CMD=%GIT_HOME%\usr\bin\sed.exe"
set "_UNIX2DOS_CMD=%GIT_HOME%\usr\bin\unix2dos.exe"

goto :eof

:env_colors
@rem ANSI colors in standard Windows 10 shell
@rem see https://gist.github.com/mlocati/#file-win10colors-cmd

@rem normal foreground colors
set _NORMAL_FG_BLACK=[30m
set _NORMAL_FG_RED=[31m
set _NORMAL_FG_GREEN=[32m
set _NORMAL_FG_YELLOW=[33m
set _NORMAL_FG_BLUE=[34m
set _NORMAL_FG_MAGENTA=[35m
set _NORMAL_FG_CYAN=[36m
set _NORMAL_FG_WHITE=[37m

@rem normal background colors
set _NORMAL_BG_BLACK=[40m
set _NORMAL_BG_RED=[41m
set _NORMAL_BG_GREEN=[42m
set _NORMAL_BG_YELLOW=[43m
set _NORMAL_BG_BLUE=[44m
set _NORMAL_BG_MAGENTA=[45m
set _NORMAL_BG_CYAN=[46m
set _NORMAL_BG_WHITE=[47m

@rem strong foreground colors
set _STRONG_FG_BLACK=[90m
set _STRONG_FG_RED=[91m
set _STRONG_FG_GREEN=[92m
set _STRONG_FG_YELLOW=[93m
set _STRONG_FG_BLUE=[94m
set _STRONG_FG_MAGENTA=[95m
set _STRONG_FG_CYAN=[96m
set _STRONG_FG_WHITE=[97m

@rem strong background colors
set _STRONG_BG_BLACK=[100m
set _STRONG_BG_RED=[101m
set _STRONG_BG_GREEN=[102m
set _STRONG_BG_YELLOW=[103m
set _STRONG_BG_BLUE=[104m

@rem we define _RESET in last position to avoid crazy console output with type command
set _BOLD=[1m
set _UNDERSCORE=[4m
set _INVERSE=[7m
set _RESET=[0m
goto :eof

@rem input parameter: %*
:args
set _HELP=0
set _RUN=1
set _VERBOSE=0
:args_loop
set "__ARG=%~1"
if not defined __ARG goto args_done

if "%__ARG:~0,1%"=="-" (
    @rem option
    if "%__ARG%"=="-debug" ( set _DEBUG=1
    ) else if "%__ARG%"=="-help" ( set _HELP=1
    ) else if "%__ARG%"=="-verbose" ( set _VERBOSE=1
    ) else (
        echo %_ERROR_LABEL% Unknown option "%__ARG%" 1>&2
        set _EXITCODE=1
        goto args_done
    )
) else (
    @rem subcommand
    if "%__ARG%"=="help" ( set _HELP=1
    ) else if "%__ARG%"=="run" ( set _RUN=1
    ) else (
        echo %_ERROR_LABEL% Unknown subcommand "%__ARG%" 1>&2
        set _EXITCODE=1
        goto args_done
    )
)
shift
goto args_loop
:args_done
if %_DEBUG%==1 (
    echo %_DEBUG_LABEL% Options    : _VERBOSE=%_VERBOSE% 1>&2
    echo %_DEBUG_LABEL% Subcommands: _HELP=%_HELP% _RUN=%_RUN%  1>&2
)
goto :eof

:help
if %_VERBOSE%==1 (
    set __BEG_P=%_STRONG_FG_CYAN%
    set __BEG_O=%_STRONG_FG_GREEN%
    set __BEG_N=%_NORMAL_FG_YELLOW%
    set __END=%_RESET%
) else (
    set __BEG_P=
    set __BEG_O=
    set __BEG_N=
    set __END=
)
echo Usage: %__BEG_O%%_BASENAME% { ^<option^> ^| ^<subcommand^> }%__END%
echo.
echo   %__BEG_P%Options:%__END%
echo     %__BEG_O%-debug%__END%       print commands executed by this script
echo     %__BEG_O%-verbose%__END%     print progress messages
echo.
echo   %__BEG_P%Subcommands:%__END%
echo     %__BEG_O%help%__END%         print this help message
echo     %__BEG_O%run%__END%          execute main class
goto :eof

:run
for %%i in (examples) do (
    set "__PROJECT_DIR=%_ROOT_DIR%\%%i"
    if exist "!__PROJECT_DIR!\" (
        if %_DEBUG%==1 echo %_DEBUG_LABEL% call :update_project "!__PROJECT_DIR!" 1>&2
        call :update_project "!__PROJECT_DIR!"
    ) else (
        echo %_WARNING_LABEL% Project directory not found ^("!__PROJECT_DIR!"^) 1>&2
    )
)
goto :eof

:update_project
set "__PARENT_DIR=%~1"
set __N_SH=0
echo Parent directory: %__PARENT_DIR%
for /f %%i in ('dir /ad /b "%__PARENT_DIR%" ^| findstr /v /c:"lib"') do (
    set "__BUILD_SH=%__PARENT_DIR%\%%i\build.sh"
    if exist "!__BUILD_SH!" (
        if %_DEBUG%==1 echo %_DEBUG_LABEL% "%_GREP_CMD%" -q "%_COPYRIGHT_DATES_OLD%" "!__BUILD_SH!" 1>&2
        call "%_GREP_CMD%" -q "%_COPYRIGHT_DATES_OLD%" "!__BUILD_SH!"
        if !ERRORLEVEL!==0 (
            if %_DEBUG%==1 echo %_DEBUG_LABEL% "%_SED_CMD%" -i "s@%_COPYRIGHT_DATES_OLD%@%_COPYRIGHT_DATES_NEW%@g" "!__BUILD_SH!" 1>&2
            call "%_SED_CMD%" -i "s@%_COPYRIGHT_DATES_OLD%@%_COPYRIGHT_DATES_NEW%@g" "!__BUILD_SH!"
            call "%_UNIX2DOS_CMD%" -q "!__BUILD_SH!"
            set /a __N_SH+=1
        )
    ) else (
       echo    %_WARNING_LABEL% Could not find file "%%i\build.sh" 1>&2
    )
)
call :message %__N_SH% "build.sh"
goto :eof

@rem input parameters: %1=nr of updates, %2=file name
:message
set __N=%~1
set __FILE_NAME=%~2
if %__N% gtr 1 ( set __STR=files ) else ( set __STR=file )
echo    Updated %__N% %__FILE_NAME% %__STR%
goto :eof

@rem #########################################################################
@rem ## Cleanups

:end
if %_DEBUG%==1 echo %_DEBUG_LABEL% _EXITCODE=%_EXITCODE% 1>&2
exit /b %_EXITCODE%
endlocal
