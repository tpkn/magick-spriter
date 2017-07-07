@echo off


echo.
echo Magick Spriter (2.1.20170707), http://tpkn.me
echo.


set JPGQUALITY=80
set FILETYPE=jpg
set ORIENTATION=1x
set FOLDER=%~dp1


echo Sprite sheet folder:
echo %FOLDER%


echo.
echo Select format:
echo 1. PNG (default)
echo 2. JPG
CHOICE /T 5 /C 12 /D 1 /N
call goto %ERRORLEVEL%
:1
set FILETYPE=png
goto orientation
:2
set FILETYPE=jpg
goto quality


:quality
echo.
echo Select quality:
echo 1. 25%%
echo 2. 50%%
echo 3. 80%% (default)
echo 4. 100%%
CHOICE /T 5 /C 1234 /D 3 /N
call goto %ERRORLEVEL%
:1
set JPGQUALITY=25
goto orientation
:2
set JPGQUALITY=50
goto orientation
:3
set JPGQUALITY=80
goto orientation
:4
set JPGQUALITY=100
goto orientation


:orientation
echo.
echo Select orientation:
echo 1. Horisontal
echo 2. Vertical (default)
echo 3. Square
CHOICE /T 5 /C 123 /D 2 /N
call goto %ERRORLEVEL%
:1
set ORIENTATION=x1
goto action
:2
set ORIENTATION=1x
goto action
:3
set ORIENTATION=16x
goto action


:action
echo.
echo Processing...
if %FILETYPE%==jpg (
   if %ORIENTATION%==16x (
      montage "%FOLDER%\*" -quality %JPGQUALITY% -tile 16x -geometry +0+0 "%FOLDER%\sprite.jpg"
   ) else (
      montage "%FOLDER%\*" -quality %JPGQUALITY% -tile %ORIENTATION% -geometry +0+0 "%FOLDER%\sprite.jpg"
   )
) else (
   if %ORIENTATION%==16x (
      montage "%FOLDER%\*" -background transparent -tile 16x -geometry +0+0 "%FOLDER%\sprite.png"
   ) else (
      montage "%FOLDER%\*" -background transparent -tile %ORIENTATION% -geometry +0+0 "%FOLDER%\sprite.png"
   )
)
goto complete


:complete
echo.
echo +-----------------------+
echo ^|         DONE          ^|
echo +-----------------------+
timeout /t 10