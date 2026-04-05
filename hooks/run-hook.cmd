@echo off
REM Windows wrapper for bash hook scripts (same pattern as superpowers)
set "SCRIPT=%~dp0%~1"
bash "%SCRIPT%"
