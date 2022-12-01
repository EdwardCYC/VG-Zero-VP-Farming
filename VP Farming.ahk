#NoEnv  ; Performance and compatibility with future AutoHotkey releases.
SendMode Event  ; For new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#Warn

if(!A_IsAdmin) {
    Run, *RunAs "%A_AhkPath%" "%A_ScriptFullPath%"
    ExitApp
}



F1::
; Check PC resolution
SysGet, Res, Monitor

stop = 0
just_finished_match = 0
inactive_counter := 0
Loop
{
	
    if stop = 1
		break
	
	; If nothing from my script ran in 1 minute 45 seconds, I assume I won the game and take the necessary actions to continue
	if inactive_counter > 290
	{
		MouseClick, left, A_ScreenWidth*0.42, A_ScreenHeight*0.7
		inactive_counter = 0
		just_finished_match = 1
	}

    ; Confirm Mulligan
    ImageSearch, Image001_X, Image001_Y, %ResLeft%, %ResTop%, %ResRight%, %ResBottom%, *20 ok_button.bmp
    if ErrorLevel = 0
    {
		if stop = 1
			break
		just_finished_match = 0
		MouseClick, left, Image001_X*1.02, Image001_Y*1.02
		inactive_counter = 0
    }
	
	; Queue for next match
	if just_finished_match = 1
	{
		if stop = 1
			break
		Sleep 4000
		MouseClick, left, A_ScreenWidth*0.48, A_ScreenHeight*0.9
		Sleep 4000
		MouseClick, left, A_ScreenWidth*0.59, A_ScreenHeight*0.9
		; MouseMove, A_ScreenWidth*0.5, A_ScreenHeight*0.85
	
	}
   
   	; Ride Up
	ImageSearch, Image002_X, Image002_Y, %ResLeft%, %ResTop%, %ResRight%, %ResBottom%, *20 ride_up.bmp
	if ErrorLevel = 0
	{
		if stop = 1
			break
		MouseClick, left, Image002_X*1.54, Image002_Y*1.08
		inactive_counter = 0
	}
	else
	{
		ImageSearch, Image003_X, Image003_Y, %ResLeft%, %ResTop%, %ResRight%, %ResBottom%, *20 ride_up2.bmp
		if ErrorLevel = 0
		{
			if stop = 1
				break
			MouseClickDrag, left, Image003_X*1.17, Image003_Y*1.42, Image003_X*1.17, Image003_Y
			inactive_counter = 0
		}
	}
	
	; Battle
	ImageSearch, Image004_X, Image004_Y, %ResLeft%, %ResTop%, %ResRight%, %ResBottom%, *20 battle_button.bmp
    if ErrorLevel = 0
    {
		if stop = 1
			break
		MouseClick, left, Image004_X*1.02, Image004_Y*1.02
		Sleep 3000
		MouseClickDrag, left, Image004_X*0.86, Image004_Y*1.21, Image004_X*0.86, Image004_Y*0.84
		Sleep 1000
		MouseClickDrag, left, Image004_X*0.86, Image004_Y*1.21, Image004_X*0.75, Image004_Y*0.84
		Sleep 1000
		MouseClickDrag, left, Image004_X*0.86, Image004_Y*1.21, Image004_X*0.97, Image004_Y*0.84
		inactive_counter = 0
    }
	else
	{
		; End Turn
		ImageSearch, Image005_X, Image005_Y, %ResLeft%, %ResTop%, %ResRight%, %ResBottom%, *20 end_button.bmp
		if ErrorLevel = 0
		{
			if stop = 1
				break
			MouseClick, left, Image005_X*1.02, Image005_Y*1.02
			inactive_counter = 0
		}
	}
	
	
	; Ride Skip
    ImageSearch, Image006_X, Image006_Y, %ResLeft%, %ResTop%, %ResRight%, %ResBottom%, *20 ride_skip.bmp
    if ErrorLevel = 0
    {
		if stop = 1
			break
		MouseClick, left, Image006_X*1.02, Image006_Y*1.02
		Sleep 1000
		MouseClick, left, Image006_X*0.74, Image006_Y*1.21
		inactive_counter = 0
    }

	; Game Finished
	ImageSearch, Image007_X, Image007_Y, %ResLeft%, %ResTop%, %ResRight%, %ResBottom%, *20 lose_msg.bmp
    if ErrorLevel = 0
    {
		if stop = 1
			break
		Sleep 1000
		MouseClick, left, Image007_X*1.11, Image007_Y*1.31
		just_finished_match = 1

    }
	
	inactive_counter++
}
Return


F2::
   stop = 1
Return

F3::Reload