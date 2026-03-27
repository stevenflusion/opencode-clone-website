@echo off
REM Clone Website Skill Installer for OpenCode
REM Works in CMD and PowerShell

echo 🎯 Installing Clone Website Skill for OpenCode...

REM Get the directory where the script is located
set "SCRIPT_DIR=%~dp0"

REM Create the skills directory if it doesn't exist
if not exist "%USERPROFILE%\.opencode\skills\clone-website" (
    mkdir "%USERPROFILE%\.opencode\skills\clone-website"
)

REM Copy the skill
copy /Y "%SCRIPT_DIR%.opencode\skills\clone-website\SKILL.md" "%USERPROFILE%\.opencode\skills\clone-website\" >nul

if %ERRORLEVEL% EQU 0 (
    echo ✅ Skill installed successfully!
    echo.
    echo Next steps:
    echo 1. Restart OpenCode
    echo 2. Use the skill by saying: "Clone this website: https://example.com"
) else (
    echo ❌ Error installing skill
)

pause