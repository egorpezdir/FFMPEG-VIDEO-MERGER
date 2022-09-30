setlocal enabledelayedexpansion
@echo off
echo[
echo[
echo[
more title.txt
color 0c
echo[
echo[
echo[
echo WELCOME TO THE VIDEO MERGER!
echo I hope that you have ffmpeg installed...
echo MAKE SURE THAT ALL YOUR VIDEOS HAVE THE SAME PARAMETERS (FPS, size, codecs,...)                                                                                                                                            
echo[
echo[
echo[
echo HOW MANY VIDEOS WOULD YOU LIKE TO MERGE? (type an integer)
echo[
set /p st=
set /a stminus1=%st%-1
echo[
echo DRAG AND DROP ONE VIDEO AND HIT ENTER... and continue in your desired order... 
echo[

set /p name1=
echo file %name1% >> "videos.txt"
set v=1
 
for /l %%v in (1, 1, %stminus1%) do (
	set /p name= 
	echo file !name! >> videos.txt
	
)
:: replace " with ' in videos.txt (cringe)

    set "textfile=videos.txt"
    set "tempfile=video-temp.txt"
    (for /f "delims=" %%i in (%textfile%) do (
        set "line=%%i"
        setlocal enabledelayedexpansion
        set "line=!line:"='!"
        echo(!line!
        endlocal
    ))>"%tempfile%"
    del %textfile%
    rename %tempfile%  %textfile%


ffmpeg -f concat -safe 0 -i videos.txt -c copy output.mp4

del /Q videos.txt