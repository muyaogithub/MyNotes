@echo off
chcp 65001 >nul
setlocal
cd /d "%~dp0"
title MyNotes 知识库 Git 一键同步工具

echo ======================================================
echo          MyNotes 知识库 Git 自动化同步助手
echo ======================================================
echo.

echo [1/4] 正在拉取远程更新 (git pull)...
git pull origin main
if errorlevel 1 goto PULL_ERROR
echo [成功] 远程分支已是最新状态。
echo.

echo [2/4] 检查本地是否有修改...
git status --porcelain > "%temp%\git_status_check.txt"
set HAS_CHANGES=0
for %%A in ("%temp%\git_status_check.txt") do if %%~zA GTR 0 set HAS_CHANGES=1
del "%temp%\git_status_check.txt"

if "%HAS_CHANGES%"=="0" (
    echo [2/4] 本地没有任何修改或新增文件，无需提交。
    echo.
    echo ======================================================
    echo [完成] 知识库已保持最新同步！
    echo ======================================================
    goto FINISH
)

echo [2/4] 检测到本地修改，正在暂存所有文件 (git add)...
git add .

for /f "tokens=*" %%i in ('powershell -NoProfile -Command "Get-Date -Format 'yyyy-MM-dd HH:mm:ss'"') do set TIMESTAMP=%%i
echo [3/4] 正在提交变更: Update: %TIMESTAMP% ...
git commit -m "Update: %TIMESTAMP%"
if errorlevel 1 goto COMMIT_ERROR

echo [4/4] 正在推送到 GitHub (git push)...
git push origin main
if errorlevel 1 goto PUSH_ERROR

echo.
echo ======================================================
echo [成功] 知识库已全部同步至 GitHub！
echo ======================================================
goto FINISH

:PULL_ERROR
echo.
echo [错误] 拉取远程分支失败！请检查网络连接或手动解决冲突。
goto ERROR_PAUSE

:COMMIT_ERROR
echo.
echo [错误] 本地提交失败！
goto ERROR_PAUSE

:PUSH_ERROR
echo.
echo [错误] 推送到 GitHub 失败！请检查网络代理或 GitHub 授权。
goto ERROR_PAUSE

:ERROR_PAUSE
echo ======================================================
echo 同步过程中出现异常，窗口暂停，请查看上方错误信息。
echo ======================================================
pause
exit /b 1

:FINISH
echo.
echo 同步完成。
timeout /t 3 >nul 2>&1
exit /b 0