@echo off
setlocal enabledelayedexpansion
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
echo[
echo[
echo[
echo HOW MANY VIDEOS WOULD YOU LIKE TO MERGE? (type an integer)
echo[
set /p st=
echo[
echo DRAG AND DROP ONE VIDEO AND HIT ENTER... and continue in your desired order...
echo MAKE SURE THAT THERE ARE NO SPACES IN THE FILENAMES
echo[

set /p name1=
echo file '%name1%' >> "videos.txt"
set stored_name1=!name1!

 
for /l %%v in (2, 1, %st%) do (
	set /p name= 
	echo file '!name!' >> videos.txt
    set stored_name%%v=!name!
	
)

echo[
echo Do all your files have the same atributes (size, fps...) [Y/N]?
set /p question=
if %question%==y (goto ffmpeg) else (goto convert)

:ffmpeg
ffmpeg -f concat -safe 0 -i videos.txt -c copy output_merged.mp4
goto done

:convert
echo Since they do not, we need to reencode them. Input your desired settings:
echo[
set /p w=Width? (input a number divasible with 2)  
echo[
set /p h=Height? (input a number divasible with 2)   
echo[
set /p FPS=FPS? (missing frames will be duplicated)  
echo[

for /l %%k in (1, 1, %st%) do (
	echo file 'converted%%k.mp4' >> "videos_converted.txt"
	ffmpeg -i !stored_name%%k! -vf scale=%w%:%h% -r %FPS% converted%%k.mp4

	
)

ffmpeg -f concat -safe 0 -i videos_converted.txt -c copy output_merged.mp4

goto done
	
	

:done
del /Q videos.txt
del /Q videos_converted.txt
del /Q converted*.mp4
echo[
echo DONE!
echo[

pause
video-merger.bat
