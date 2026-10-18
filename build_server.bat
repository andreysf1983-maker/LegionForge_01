@echo off
chcp 866 >nul 2>&1
setlocal EnableExtensions EnableDelayedExpansion
title LEGIONFORGE 7.3.5.26124 (2026-10-21) - Автоматическая сборка сервера
rem ============================================================
rem  LEGIONFORGE 7.3.5 build 26124 - сборка из исходников core\.
rem  Ничего ставить вручную не нужно: CMake, Boost, OpenSSL,
rem  MySQL скачаются в tools\ автоматически; при отсутствии
rem  компилятора будет предложена установка Visual Studio 2022
rem  Build Tools (нужны права администратора и интернет).
rem  /auto - без паузы (вызывается из setup.bat)
rem ============================================================
set "ROOT=%~dp0"
set "ROOT=%ROOT:~0,-1%"
set "AUTO="
if /I "%~1"=="/auto" set "AUTO=1"
powershell -NoProfile -ExecutionPolicy Bypass -File "%ROOT%\scripts\build_server.ps1" -Root "%ROOT%"
if errorlevel 1 (
    echo.
    echo  [ОШИБКА] Сборка не удалась. Подробности: %ROOT%\build_log.txt
    if not defined AUTO pause
    exit /b 1
)
echo.
echo  [OK] Сборка завершена: программы лежат в папке server\.
if not defined AUTO pause
exit /b 0
