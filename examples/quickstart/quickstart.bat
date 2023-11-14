@echo off
setlocal enabledelayedexpansion

set _DEBUG=0

@rem #########################################################################
@rem ## Environment setup

set _EXITCODE=0

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
if %_START%==1 (
    call :start_services
    if not !_EXITCODE!==0 goto end
)
if %_TEST%==1 (
    call :create_topic
    if not !_EXITCODE!==0 goto end

    call :check_topic
    if not !_EXITCODE!==0 goto end

    call :produce_message
    if not !_EXITCODE!==0 goto end

    call :consume_message
    if not !_EXITCODE!==0 goto end
)
if %_STOP%==1 (
    call :stop_servers
    if not !_EXITCODE!==0 goto end
)
goto end

@rem #########################################################################
@rem ## Subroutines

:env
set _BASENAME=%~n0
set "_ROOT_DIR=%~dp0"
set _TIMER=0

call :env_colors
set _DEBUG_LABEL=%_NORMAL_BG_CYAN%[%_BASENAME%]%_RESET%
set _ERROR_LABEL=%_STRONG_FG_RED%Error%_RESET%:
set _WARNING_LABEL=%_STRONG_FG_YELLOW%Warning%_RESET%:

if not exist "%JAVA_HOME%\bin\java.exe" (
    echo %_ERROR_LABEL% Java SDK installation directory not found 1>&2
    set _EXITCODE=1
    goto :eof
)
set "_JAVA_CMD=%JAVA_HOME%\bin\java.exe"
set "_JPS_CMD=%JAVA_HOME%\bin\jps.exe"

if not exist "%KAFKA_HOME%\bin\windows\kafka-topics.bat" (
    echo %_DEBUG_LABEL% Kafka installation directory not found 1>&2
    set _EXITCODE=1
    goto :eof
)
set "_ZOOKEEPER_START_CMD=%KAFKA_HOME%\bin\windows\zookeeper-server-start.bat"
set "_ZOOKEEPER_STOP_CMD=%KAFKA_HOME%\bin\windows\zookeeper-server-stop.bat"

set "_KAFKA_START_CMD=%KAFKA_HOME%\bin\windows\kafka-server-start.bat"
set "_KAFKA_STOP_CMD=%KAFKA_HOME%\bin\windows\kafka-server-stop.bat"
set "_KAFKA_TOPICS_CMD=%KAFKA_HOME%\bin\windows\kafka-topics.bat"

set "_CONSUMER_CMD=%KAFKA_HOME%\bin\windows\kafka-console-consumer.bat"
set "_PRODUCER_CMD=%KAFKA_HOME%\bin\windows\kafka-console-producer.bat"

for /f "delims=" %%f in ("%~dp0.") do set "_CONFIG_DIR=%%~dpf\config"

set _SERVER_HOST=localhost
set _SERVER_PORT=9092
set _BOOTSTRAP_SERVER=%_SERVER_HOST%:%_SERVER_PORT%

set _KAFKA_PROC_NAME=kafka.Kafka
set _ZOOKEEPER_PROC_NAME=zookeeper.server

set _TOPIC_NAME=quickstart-events
goto :eof

:env_colors
@rem ANSI colors in standard Windows 10 shell
@rem see https://gist.github.com/mlocati/#file-win10colors-cmd
set _RESET=[0m
set _BOLD=[1m
set _UNDERSCORE=[4m
set _INVERSE=[7m

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
goto :eof

:args
set _HELP=0
set _START=0
set _STOP=0
set _TEST=0
set _TIMER=0
set _VERBOSE=0
set __N=0
:args_loop
set "__ARG=%~1"
if not defined __ARG (
    if !__N!==0 set _HELP=1
    goto args_done
)
if "%__ARG:~0,1%"=="-" (
    @rem option
    if "%__ARG%"=="-debug" ( set _DEBUG=1
    ) else if "%__ARG%"=="-help" ( set _HELP=1
    ) else if "%__ARG%"=="-timer" ( set _TIMER=1
    ) else if "%__ARG%"=="-verbose" ( set _VERBOSE=1
    ) else (
        echo %_ERROR_LABEL% Unknown option "%__ARG%" 1>&2
        set _EXITCODE=1
        goto args_done
    )
) else (
    @rem subcommand
    if "%__ARG%"=="help" ( set _HELP=1
    ) else if "%__ARG%"=="start" ( set _START=1
    ) else if "%__ARG%"=="stop" ( set _STOP=1
    ) else if "%__ARG%"=="test" ( set _TEST=1
    ) else (
        echo %_ERROR_LABEL% Unknown subcommand "%__ARG%" 1>&2
        set _EXITCODE=1
        goto args_done
    )
    set /a __N+=1
)
shift
goto args_loop
:args_done
set _STDERR_REDIRECT=2^>NUL
if %_DEBUG%==1 set _STDERR_REDIRECT=

if %_DEBUG%==1 (
    echo %_DEBUG_LABEL% Options    : _TIMER=%_TIMER% _VERBOSE=%_VERBOSE% 1>&2
    echo %_DEBUG_LABEL% Subcommands: _START=%_START% _STOP=%_STOP% _TEST=%_TEST% 1>&2
    echo %_DEBUG_LABEL% Variables  : _BOOTSTRAP_SERVER=%_BOOTSTRAP_SERVER% 1>&2
    echo %_DEBUG_LABEL% Variables  : "JAVA_HOME=%JAVA_HOME%" 1>&2
    echo %_DEBUG_LABEL% Variables  : "KAFKA_HOME=%KAFKA_HOME%" 1>&2
)
if %_TIMER%==1 for /f "delims=" %%i in ('powershell -c "(Get-Date)"') do set _TIMER_START=%%i
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
echo     %__BEG_O%-debug%__END%      print commands executed by this script
echo     %__BEG_O%-timer%__END%      print total execution time
echo     %__BEG_O%-verbose%__END%    print progress messages
echo.
echo   %__BEG_P%Subcommands:%__END%
echo     %__BEG_O%help%__END%        print this help message
echo     %__BEG_O%start%__END%       start both servers
echo     %__BEG_O%stop%__END%        stop both servers
echo     %__BEG_O%test%__END%        execute producer/consumer test
goto :eof

:start_services
call :start_zookeeper
if not %_EXITCODE%==0 goto :eof
call :start_kafka
if not %_EXITCODE%==0 goto :eof
goto :eof

@rem input parameters: %1=process name, %2=service name
@rem output parameter: _IS_RUNNING
:is_running
set _IS_RUNNING=0
set __PROC_NAME=%~1
set __SERVICE_NAME=%~2

if %_DEBUG%==1 ( echo %_DEBUG_LABEL% "%_JPS_CMD%" -l^|findstr "%__PROC_NAME%" 1>&2
) else if %_VERBOSE%==1 ( echo Check if %__SERVICE_NAME% service is up and running 1>&2
)
for /f "usebackq" %%i in (`call "%_JPS_CMD%" -l^|findstr "%__PROC_NAME%" 2^>NUL`) do set _IS_RUNNING=1
goto :eof

:start_zookeeper
call :is_running "%_ZOOKEEPER_PROC_NAME%" Zookeeper
if %_IS_RUNNING%==1 (
    if %_VERBOSE%==1 echo Zookeeper service is up and running 1>&2
    goto :eof
)
set "__ZOOKEEPER_PROPS_FILE=%_CONFIG_DIR%\zookeeper.properties"
if not exist "%__ZOOKEEPER_PROPS_FILE%" (
    echo %_WARNING_LABEL% Property file 'zookeeper.properties' not found 1>&2
    set __ZOOKEEPER_PROPS_FILE=
)
set "__BATCH_FILE=%TEMP%\%_BASENAME%_zookeeper.bat"
(
    echo @echo off
    echo if %_DEBUG%==1 echo %_DEBUG_LABEL% "%_ZOOKEEPER_START_CMD%" %__ZOOKEEPER_PROPS_FILE% 1^>^&2
    echo call "%_ZOOKEEPER_START_CMD%" %__ZOOKEEPER_PROPS_FILE%
) > "%__BATCH_FILE%"
if %_DEBUG%==1 ( echo %_DEBUG_LABEL% start "%_ZOOKEEPER_PROC_NAME%" "%__BATCH_FILE%" 1>&2
) else if %_VERBOSE%==1 ( echo Start the Zookeeper service 1>&2
)
start "%_ZOOKEEPER_PROC_NAME%" "%__BATCH_FILE%"
if not %ERRORLEVEL%==0 (
    echo %_ERROR_LABEL% Failed to start the Zookeeper service 1>&2
    set _EXITCODE=1
    goto :eof
)
timeout /t 5 /nobreak 1>NUL
goto :eof

@rem input parameter: %1=local port number (to check)
:check_local_port
set __LOCAL_PORT=%~1

if %_DEBUG%==1 ( echo %_DEBUG_LABEL% netstat -aon ^| findstr %__LOCAL_PORT% 1>&2
) else if %_VERBOSE%==1 ( echo Check if local port %__LOCAL_PORT% is free ^(needed for Jetty AdminServer^) 1>&2
)
set __PID=
for /f "tokens=1-4,*" %%i in ('netstat -aon ^| findstr %__LOCAL_PORT%') do (
    set __PID=%%m
)
if defined __PID (
    if %_DEBUG%==1 ( echo %_DEBUG_LABEL% tasklist ^| findstr %__PID% 1>&2
    ) else if %_VERBOSE%==1 ( echo Process %__PID% already uses port %__LOCAL_PORT% 1>&2
    )
    @rem TODO : test output and (possibly) set _EXITCODE
    tasklist | findstr %__PID%
    set _EXITCODE=1
)
goto :eof

:start_kafka
call :is_running "%_KAFKA_PROC_NAME%" Kafka
if %_IS_RUNNING%==1 (
    if %_VERBOSE%==1 echo Kafka service is up and running 1>&2
    goto :eof
)
call :check_local_port 8081
if not %_EXITCODE%==0 goto :eof

set "__KAFKA_PROPS_FILE=%_CONFIG_DIR%\server.properties"
if not exist "%__KAFKA_PROPS_FILE%" (
    echo %_WARNING_LABEL% Property file 'server.properties' not found 1>&2
    set __KAFKA_PROPS_FILE=
)
set "__BATCH_FILE=%TEMP%\%_BASENAME%_kafka.bat"
(
    echo @echo off
    echo if %_DEBUG%==1 echo %_DEBUG_LABEL% "%_KAFKA_START_CMD%" %__KAFKA_PROPS_FILE% 1^>^&2
    echo call "%_KAFKA_START_CMD%" %__KAFKA_PROPS_FILE%
) > "%__BATCH_FILE%"
if %_DEBUG%==1 ( echo %_DEBUG_LABEL% start "%_KAFKA_PROC_NAME%" "%__BATCH_FILE%" 1>&2
) else if %_VERBOSE%==1 ( echo Start the Kafka service 1>&2
)
start "%_KAFKA_PROC_NAME%" "%__BATCH_FILE%"
if not %ERRORLEVEL%==0 (
    echo %_ERROR_LABEL% Failed to start the Kafka service 1>&2
    set _EXITCODE=1
    goto :eof
)
goto :eof

:create_topic
call :is_running "%_KAFKA_PROC_NAME%" Kafka
if %_IS_RUNNING%==0 (
    echo %_ERROR_LABEL% Kafka service must be started to create topic "%_TOPIC_NAME%" 1>&2
    set _EXITCODE=1
    goto :eof
)
set __TOPICS_OPTS=--create --if-not-exists --bootstrap-server %_BOOTSTRAP_SERVER% --replication-factor 1 --partitions 1 --topic "%_TOPIC_NAME%"

if %_DEBUG%==1 ( echo %_DEBUG_LABEL% "%_KAFKA_TOPICS_CMD%" %__TOPICS_OPTS% 1>&2
) else if %_VERBOSE%==1 ( echo Create topic "%_TOPIC_NAME%" 1>&2
)
call "%_KAFKA_TOPICS_CMD%" %__TOPICS_OPTS%
if not %ERRORLEVEL%==0 (
    echo %_ERROR_LABEL% Failed to create topic "%_TOPIC_NAME%" 1>&2
    set _EXITCODE=1
    goto :eof
)
set __TOPICS_OPTS=--describe --bootstrap-server %_BOOTSTRAP_SERVER% --topic "%_TOPIC_NAME%"

if %_DEBUG%==1 ( echo %_DEBUG_LABEL% "%_KAFKA_TOPICS_CMD%" %__TOPICS_OPTS% 1>&2
) else if %_VERBOSE%==1 ( echo Describe topic "%_TOPIC_NAME%" 1>&2
)
call "%_KAFKA_TOPICS_CMD%" %__TOPICS_OPTS%
if not %ERRORLEVEL%==0 (
    echo %_ERROR_LABEL% Failed to describe topic "%_TOPIC_NAME%" 1>&2
    set _EXITCODE=1
    goto :eof
)
goto :eof

:check_topic
set __TOPICS_OPTS=--list --bootstrap-server %_BOOTSTRAP_SERVER%

if %_DEBUG%==1 ( echo %_DEBUG_LABEL% "%_KAFKA_TOPICS_CMD%" %__TOPICS_OPTS% 1>&2
) else if %_VERBOSE%==1 ( echo List available topics 1>&2
)
call "%_KAFKA_TOPICS_CMD%" %__TOPICS_OPTS%
if not %ERRORLEVEL%==0 (
    echo %_ERROR_LABEL% Failed to list available topics 1>&2
    set _EXITCODE=1
    goto :eof
)
goto :eof

:produce_message
set "__PRODUCER_PROPS_FILE=%_CONFIG_DIR%\producer.properties"

set __PRODUCER_OPTS=--bootstrap-server "%_BOOTSTRAP_SERVER%" --topic "%_TOPIC_NAME%"

@rem see https://www.conduktor.io/kafka/kafka-producer-cli-tutorial
set "__DATA_FILE=C:\temp\%_BASENAME%_data.txt"
(
    echo Hello world
    echo Apache Kafka
) > "%__DATA_FILE%"
set "__BATCH_FILE=C:\temp\%_BASENAME%_producer.bat"
(
    echo @echo off
    echo if %_DEBUG%==1 echo %_DEBUG_LABEL% "%_PRODUCER_CMD%" %__PRODUCER_OPTS% "%__PRODUCER_PROPS_FILE%" ^< "%__DATA_FILE%" 1^>^&2
    echo call "%_PRODUCER_CMD%" %__PRODUCER_OPTS% "%__PRODUCER_PROPS_FILE%" ^< "%__DATA_FILE%"
) > "%__BATCH_FILE%"
if %_DEBUG%==1 ( echo %_DEBUG_LABEL% start "kafka.producer" "%__BATCH_FILE%" 1>&2
) else if %_VERBOSE%==1 ( echo Produce some messages to topic "%_TOPIC_NAME%" 1>&2
)
pause
start "kafka.producer" "%__BATCH_FILE%"
if not %ERRORLEVEL%==0 (
    echo %_ERROR_LABEL% Failed to produce messages to topic "%_TOPIC_NAME%" 1>&2
    set _EXITCODE=1
    goto :eof
)
goto :eof

:consume_message
set "__CONSUMER_PROPS_FILE=%_CONFIG_DIR%\consumer.properties"
if not exist "%__CONSUMER_PROPS_FILE%" (
    echo %_WARNING_LABEL% Property file 'consumer.properties' not found 1>&2
    set __CONSUMER_PROPS_FILE=
)
set __CONSUMER_OPTS=--bootstrap-server %_BOOTSTRAP_SERVER% --topic "%_TOPIC_NAME%" --from-beginning

if %_DEBUG%==1 ( echo %_DEBUG_LABEL% "%_CONSUMER_CMD%" %__CONSUMER_OPTS% "%__CONSUMER_PROPS_FILE%" 1>&2
) else if %_VERBOSE%==1 ( echo Consume the messages from topic "%_TOPIC_NAME%" 1>&2
)
call "%_CONSUMER_CMD%" %__CONSUMER_OPTS% "%__CONSUMER_PROPS_FILE%"
if not %ERRORLEVEL%==0 (
    echo %_ERROR_LABEL% Failed to consume messages from topic "%_TOPIC_NAME%" 1>&2
    set _EXITCODE=1
    goto :eof
)
goto :eof

:stop_servers
call :stop_kafka
if not %_EXITCODE%==0 goto :eof
call :stop_zookeeper
if not %_EXITCODE%==0 goto :eof
goto :eof

:stop_zookeeper
call :is_running "%_ZOOKEEPER_PROC_NAME%" Zookeeper
if %_IS_RUNNING%==0 goto :eof

if %_DEBUG%==1 ( echo %_DEBUG_LABEL% "%_ZOOKEEPER_STOP_CMD%" 1>&2
) else if %_VERBOSE%==1 ( echo Stop Zookeeper server process "%_ZOOKEEPER_PROC_NAME%" 1>&2
)
call "%_ZOOKEEPER_STOP_CMD%" %_STDERR_REDIRECT%
if not %ERRORLEVEL%==0 (
    echo %_ERROR_LABEL% Failed to stop Zookeeper server process "%_ZOOKEEPER_PROC_NAME%" 1>&2
    set _EXITCODE=1
    goto :eof
)
goto :eof

:stop_kafka
call :is_running "%_KAFKA_PROC_NAME%" Kafka
if %_IS_RUNNING%==0 goto :eof

if %_DEBUG%==1 ( echo %_DEBUG_LABEL% "%_KAFKA_STOP_CMD%" 1>&2
) else if %_VERBOSE%==1 ( echo Stop Kafka server process "%_KAFKA_PROC_NAME%" 1>&2
)
call "%_KAFKA_STOP_CMD%" %_STDERR_REDIRECT%
if not %ERRORLEVEL%==0 (
    echo %_ERROR_LABEL% Failed to stop Kafka server process "%_KAFKA_PROC_NAME%" 1>&2
    set _EXITCODE=1
    goto :eof
)
goto :eof

@rem output parameter: _DURATION
:duration
set __START=%~1
set __END=%~2

for /f "delims=" %%i in ('powershell -c "$interval = New-TimeSpan -Start '%__START%' -End '%__END%'; Write-Host $interval"') do set _DURATION=%%i
goto :eof

@rem #########################################################################
@rem ## Cleanups

:end
if %_TIMER%==1 (
    for /f "delims=" %%i in ('powershell -c "(Get-Date)"') do set __TIMER_END=%%i
    call :duration "%_TIMER_START%" "!__TIMER_END!"
    echo Total execution time: !_DURATION! 1>&2
)
if %_DEBUG%==1 echo %_DEBUG_LABEL% _EXITCODE=%_EXITCODE% 1>&2
exit /b %_EXITCODE%
endlocal
