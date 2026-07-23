@echo off
setlocal

set "GRADLE_VERSION=8.10.2"
set "PROJECT_DIR=%~dp0"
set "DIST_DIR=%PROJECT_DIR%.gradle-dist"
set "GRADLE_HOME=%DIST_DIR%\gradle-%GRADLE_VERSION%"
set "ZIP_FILE=%DIST_DIR%\gradle-%GRADLE_VERSION%-bin.zip"
set "GRADLE_URL=https://services.gradle.org/distributions/gradle-%GRADLE_VERSION%-bin.zip"

if not exist "%GRADLE_HOME%\bin\gradle.bat" (
    if not exist "%DIST_DIR%" mkdir "%DIST_DIR%"
    echo Downloading Gradle %GRADLE_VERSION%...
    powershell -NoProfile -ExecutionPolicy Bypass -Command ^
      "$ErrorActionPreference='Stop'; Invoke-WebRequest -Uri '%GRADLE_URL%' -OutFile '%ZIP_FILE%'; Expand-Archive -Path '%ZIP_FILE%' -DestinationPath '%DIST_DIR%' -Force"
    if errorlevel 1 (
        echo Failed to download or extract Gradle.
        exit /b 1
    )
)

call "%GRADLE_HOME%\bin\gradle.bat" %*
exit /b %errorlevel%
