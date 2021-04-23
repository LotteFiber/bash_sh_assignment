@echo off
title OS_Assignment_1
color 0F
rem เก็บชื่อไฟล์(รวมทั้งนามสกุลไฟล์)ไว้ในตัวแปร filename
rem %~0 เป็น environment variable ที่มีค่าเป็น full path ของ batch file เช่น
rem %~0 = C:\Users\User\Desktop\test.bat
rem prefix n คือ ชื่อไฟล์, x คือ file extension
rem %~nx0 = test.bat
set filename=%~nx0

::FUNC SELECT
:select
echo Main Menu
echo 1. Displays current year in CE and BE formats.
echo 2. Moves all files in specified directory to its root.
echo 3. Plays Guess the Number.
echo.

rem set /p คือ การรับค่า input แล้วเอาไปเก็บในตัวแปร
set /p choice="Please Select: "
rem เข้าไปเมนูต่าง ๆ ถ้า input ไม่ใช่เลข 1-3 จะต้องใส่ input
rem goto จะทำให้โปรแกรมจะกระโดดไปตัวงานใน labelต่าง ๆ ตามที่ประกาศไว้
rem label คือบรรทัดที่ขึ้นต้นด้วย colon(:)
if %choice%==1 goto :choice1
if %choice%==2 goto :choice2
if %choice%==3 (goto :choice3) else (goto :reselect)

::FUNC MENU1
:choice1
rem %date% จะ return ค่าในรูปแบบ   Thu 23/07/2020
rem ~10,4 หมายถึง เอาตั้งแต่ตัวที่ 10  ถึงตัวที่ 14 (10+4) ทำให้เหลือแค่ 2020
set dm=%date:~0,9%
set /a yearCE=%date:~10,4%
set /a yearBE=%yearCE%+543
echo This is %dm%/%yearCE% CE or %dm%/%yearBE% BE.
pause
echo.
echo.
goto :select

::FUNC MENU2
:choice2
echo Please enter directory.
echo Enter "quit" to cancel.

rem รับค่า path ไปยังโฟล์เดอร์ที่จะย้ายไฟล์
rem เช่น C:\ffmpeg\bin
set /p dpath="Directory: "
if exist "%dpath%" (
    echo Directory Exist!
    rem cd = change directory (/d หมายถึงให้เปลี่ยน drive ด้วย)
    cd /d "%dpath%"
    rem วน loop (รอบเดียว) ที่โฟล์เดอร์ตาม input
    rem เนื่องจาก  การใช้ prefix ทำได้แค่เฉพาะกับตัวแปรใน loop และ environment variable เท่านั้น
    rem จะได้ CurrDirName=ชื่อโฟล์เดอร์อย่างเดียว
    rem สมมุติให้ %dpath% คือ C:\ffmpeg\bin จะได้  CurrDirName = bin
    for %%I in (.) do set CurrDirName=%%~nxI
    rem change directory ขึ้นไป 1 ขั้น เช่นจาก  C:\ffmpeg\bin ไป  C:\ffmpeg
    cd ..
    rem กำหนดค่า parent path
    set ppath=%cd%
    rem ถ้า path ที่ user ใส่เข้ามา ไม่มี parent folder จะข้ามไปที่  :wrongdir
    if "%ppath%"=="%dpath%" (
        echo cd=%cd%
        echo dpath=%dpath%
        goto :wrongdir
    )
) else (
    goto :wrongdir
)

echo.
echo Source Directory = %dpath%
echo Destination Directory = %cd%
echo.
set ans=0
set fail=1
echo Note: Subfolder(s) will not be moved.
echo Do you really want to move file(s)?
set /p choice="Yes(Y)/No(N): "
if %choice%==Y (set ans=1
    set fail=0)
if %choice%==y (set ans=1
    set fail=0)
if %choice%==N (set ans=0
    set fail=0)
if %choice%==n (set ans=0
    set fail=0)
if %ans%==1 (
    rem วน loop ทุก ๆ ไฟล์ที่อยู่ในโฟล์เดอร์
    for /r %%i in ("%CurrDirName%\*.*") do (
        if not %%~nxi==%filename% (
            rem ทำการย้ายไฟล์ ถ้าพบว่าไฟล์ในโฟล์เดอร์มีชื่อไม่ตรงกับชื่อของ batch file ที่ทำงานอยู่นี้
            echo Moving %%~nxi ...
            move "%%i" "%cd%"
        )
    )
    echo.
    echo.
    echo Success!
    pause  
)
if %fail%==1 goto :c2fail
echo.
goto :select

::FUNC FAIL
:c2fail
echo.
echo Invalid Choice!
echo Program will return to Main Menu.
pause
echo.
goto :select

::FUNC MENU3
:choice3
rem สุ่มเลข 1-100
rem %random% จะให้ค่าตัวเลขตั้งแต่ 0 ถึง 32767
set /a number=%random% * 100 / 32768 +1
rem echo %number%
:guess
set /p inum="Guess the Number (1-100): "
rem number operations: GTR คือ มากกว่า, LSS คือ น้อยกว่า, EQU คือ เท่ากับ
if %inum% GTR %number% (
    echo Too high!
    pause
)
if %inum% LSS %number% (
    echo Too low!
    pause
)
if %inum% EQU %number% (
    echo Correct!
    echo.
    pause
    goto :select
)
echo.
goto :guess

::FUNC WRONGCHOICE
:reselect
echo Invalid Choice!
pause
cls
goto :select

::FUNC WRONGDIR
:wrongdir
echo Invalid Directory!
pause
echo.
goto :choice2

::FUNC END
:end
pause