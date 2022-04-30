﻿
#NoEnv
#MaxHotkeysPerInterval 99000000
#HotkeyInterval 99000000
#KeyHistory 0
ListLines Off
Process, Priority, , A
SetBatchLines, -1
SetKeyDelay, -1, -1
SetMouseDelay, -1
SetDefaultMouseSpeed, 0
SendMode Input
SetWorkingDir %A_ScriptDir%
DetectHiddenWindows, On
#Persistent
accel := "Enter"
turnLeft := "Left"
turnRight := "Right"
brake := "Up"
nitros := "Down"
t := 380000
intensity := 1
delay := 10000
MenuDirect := "Right"
Menu_loops := 6
menu_s := 1
color_check1 :=  0xBBE044
color_check2 :=  0xACCF3B
color_check3 :=  0x5A79BA
c1_alt := false
color_2_delay := 500
color_3_delay := 5
racecounter := 0
cleanrace := 0
ps_win_width  := 640
ps_win_height := 360
pix1x := 457
pix1y := 112
pix2x := 608
pix2y := 321
pix3x := 306
pix3y := 206
ps_load_time1 := 3000
ps_load_time2 := 7000
ps_load_time3 := 8400
Gui, -MaximizeBox
Gui, 2: -MaximizeBox
Gui, 2: -MinimizeBox
Gui, Color, c282a36, c6272a4
Gui, Add, Button, x15 y10 w70 default, Start
Gui, Add, Button, x15 y40 w70 default gVariableWindow, Variables
Gui, Add, Button, x15 y70 w70 default gGetColo_p, ColorP1
Gui, Add, Button, x110 y70 w70 default gGetColo_g, ColorP2
Gui, Add, Button, x110 y10 w70 default gGetColo_C, CleanCheck
Gui, Add, DropDownList, w50 Choose1 vMenuDirect, Right|Left
Gui, Add, Edit, vMenu_loops w20 x165 y39, 6
Gui, Font, ce8dfe3 s9 w550 Bold
Gui, Add, Radio, Group x15 y100 altsubmit Checked gPSystem vSysCheck, PS5
Gui, Add, Radio, Group x15 y120 altsubmit Checked gMenuSel vMenuCheck, Pixel
Gui, Add, Text,, _________________
Gui, Add, Text,, GT7 Clubman Cup AFK Script
Gui, Add, Text,, Alpha Version 0.1
Gui, Add, Text,, Long term stability not tested.
Gui, Add, Text,, Credit: Septomor, Rust, JordanD
Gui, Font, ce8dfe3 s9 w550 Bold
Gui, 2: Color, c535770, c6272a4
Gui, 2: Font, c11f s9 Bold
Gui, 2: Add, Text,, Turn Length (time miliseconds)
Gui, 2: Add, Edit,  w70 vA, %t%
Gui, 2: Add, Text,, Turn Intensity
Gui, 2: Add, Edit,  w40 vB, %intensity%
Gui, 2: Add, Text,, Turn Delay
Gui, 2: Add, Edit,  w40 vC, %delay%
Gui, 2: Add, Text, x100 y90, Color 2 Delay
Gui, 2: Add, Edit, x100 y110 w40 vD, %color_2_delay%
Gui, 2: Add, Button, x20  y170 gSaveVars, Save
Gui, 2: Add, Button, x100 y170 gVarDef, Defaults
Gui, Show,w210 h280,  GT7 Clubman Plus AFK
return
VariableWindow:
Gui, 2: Show, w220 h205, Variables
return
SaveVars:
Gui, 2:Submit
GuiControlGet, t, 2:, A
GuiControlGet, intensity, 2:, B
GuiControlGet, delay, 2:, C
GuiControlGet, color_2_delay, 2:, D
return
VarDef:
t = 390000
intensity = 50
delay := 140
GuiControl, 2:, A, %t%
GuiControl, 2:, B, %intensity%
GuiControl, 2:, C, %delay%
GuiControl, 2:, D, %color_2_delay%
return
ButtonStart:
Gui, Submit, NoHide
id := ""
SetKeyDelay, 10
Process, priority, , High
gosub, GrabRemotePlay
if  (id = "")
return
gosub, PauseLoop
CoordMode, Pixel, Screen
CoordMode, ToolTip, Screen
sleep 1000
gosub, AFKLoop
AFKLoop:
loop{
gosub, PressX
ToolTip, Races %racecounter% Clean Races %cleanrace%, 100, 100, screen
DllCall("Sleep", "UInt", 6000)
gosub, Race
gosub, Menu
}
return
PressX:
ControlSend,, {%accel% down}, ahk_id %id%
DllCall("Sleep", "UInt", 200)
ControlSend,, {%accel% up}, ahk_id %id%
return
PressX2:
ControlSend,, {%accel% down}, ahk_id %id%
DllCall ("Sleep", "UInt", 20)
ControlSend,, {%accel% up}, ahk_id %id%
return
PressO:
ControlSend,, {Esc down}, ahk_id %id%
DllCall("Sleep", "UInt", 200)
ControlSend,, {Esc up}, ahk_id %id%
return
PressRight:
ControlSend,, {%turnRight% down}, ahk_id %id%
Sleep, 50
ControlSend,, {%turnRight% up}, ahk_id %id%
return
TurnRight:
t0 := A_TickCount
tf := t0+t
loop 	{
ControlSend,, {%turnRight% down}, ahk_id %id%
DllCall("Sleep", "UInt", intensity)
ControlSend,, {%turnRight% up}, ahk_id %id%
DllCall("Sleep", "UInt", delay)
} until A_TickCount > tf
return
TurnLeft:
t0 := A_TickCount
tf := t0+t
loop 	{
ControlSend,, {%turnLeft% down}, ahk_id %id%
DllCall("Sleep", "UInt", intensity)
ControlSend,, {%turnLeft% up}, ahk_id %id%
DllCall("Sleep", "UInt", delay)
} until A_TickCount > tf
return
Race:
ControlSend,, {%accel% down}, ahk_id %id%
ControlSend,, {%nitros% down}, ahk_id %id%
DllCall("Sleep", "UInt", 100)
gosub TurnRight
loop {
PixelSearch, x, y, pix1x-10, pix1y-10, pix1x+10, pix1y+10, %color_check1%, 32, Fast RGB
If (ErrorLevel != 0) {
ControlSend,, {%turnRight% down}, ahk_id %id%
Sleep, 140
ControlSend,, {%turnRight% up}, ahk_id %id%
Sleep, 200
}
else{
break
}
}
ControlSend,, {%accel% up}, ahk_id %id%
ControlSend,, {%nitros% up}, ahk_id %id%
sleep 100
gosub, PressX
sleep 800
gosub, PressX
return
Menu:
if (menu_s = 1){
gosub, Menu_pixel
}
if (menu_s = 2){
gosub, Menu_time
}
return
Menu_pixel:
loop 300 {
PixelSearch, x, y, pix3x-20, pix3y-20, pix3x+20, pix3y+20, %color_check3%, 32, Fast RGB
If (ErrorLevel != 0) {
ToolTip, Searching for Clean Race, 100, 100, Screen
}
else{
cleanrace++
ToolTip, Clean Race Detected, 100, 100, Screen
break
}
}
loop {
PixelSearch, x, y, pix2x-2, pix2y-2, pix2x+2, pix2y+2, %color_check2%, 32, Fast RGB
If (ErrorLevel != 0) {
gosub, PressX
sleep %color_2_delay%
}
else{
break
}
}
racecounter++
ToolTip, Found color 2, 100, 100, Screen
Sleep, 200
ControlSend,, {Esc down}, ahk_id %id%
Sleep, 200
ControlSend,, {Esc up}, ahk_id %id%
Sleep, 200
ControlSend,, {Right down}, ahk_id %id%
Sleep, 200
ControlSend,, {Right up}, ahk_id %id%
Sleep, 500
gosub, PressX
Sleep, %ps_load_time1%
gosub, PressX
Sleep, 1000
return
Menu_time:
loop, 9{
gosub, PressX
Sleep, 1700
}
Sleep, 2000
ControlSend,, {Right down}, ahk_id %id%
Sleep, 200
ControlSend,, {Right up}, ahk_id %id%
Sleep, 500
gosub, PressX
Sleep, %ps_load_time1%
gosub, PressX
Sleep, 1000
ControlSend,, {Esc down}, ahk_id %id%
Sleep, 200
ControlSend,, {Esc up}, ahk_id %id%
loop, 2 {
gosub, PressX
Sleep, 500
}
Sleep,  %ps_load_time2%
ControlSend,, {Down down}, ahk_id %id%
Sleep, 200
ControlSend,, {Down up}, ahk_id %id%
Sleep, 500
loop, %menu_loops% {
ControlSend,, {%MenuDirect% down}, ahk_id %id%
Sleep, 50
ControlSend,, {%MenuDirect% up}, ahk_id %id%
Sleep, 200
}
loop, 2{
gosub, PressX
Sleep, 2000
}
Sleep,  %ps_load_time3%
gosub, PressX
Sleep, 2000
return
PixelTuning:
x_ratio := ps_win_width/640
y_ratio := ps_win_height/360
x_ratio2 := ps_win_width/640
y_ratio2 := ps_win_height/360
pix1x := Floor(pix1x*x_ratio)
pix1y := Floor(pix1y*y_ratio)
pix2x := Floor(pix2x*x_ratio)
pix2y := Floor(pix2y*y_ratio)
pix3x := Floor(pix3x*x_ratio2)
pix3y := Floor(pix3y*y_ratio2)
return
GrabRemotePlay:
WinGet, remotePlay_id, List, ahk_exe RemotePlay.exe
if (remotePlay_id = 0)
{
MsgBox, PS4 Remote Play not found
return
}
Loop, %remotePlay_id%
{
id := remotePlay_id%A_Index%
WinGetTitle, title, % "ahk_id " id
If InStr(title, "PS Remote Play")
break
}
WinGetClass, remotePlay_class, ahk_id %id%
WinMove, ahk_id %id%,,  0, 0, 640, 360
ControlFocus,, ahk_class %remotePlay_class%
WinActivate, ahk_id %id%
GetClientSize(id, ps_win_width, ps_win_height)
gosub, PixelTuning
return
RPwind:
WinGet, remotePlay_id, List, ahk_exe RemotePlay.exe
if (remotePlay_id = 0)
{
MsgBox, PS4 Remote Play not found
return
}
Loop, %remotePlay_id%
{
id := remotePlay_id%A_Index%
WinGetTitle, title, % "ahk_id " id
If InStr(title, "PS Remote Play")
break
}
WinGetClass, remotePlay_class, ahk_id %id%
WinMove, ahk_id %id%,,  -700, -400, 640, 360
ControlFocus,, ahk_class %remotePlay_class%
WinActivate, ahk_id %id%
return
PixelColorSimple(pc_x, pc_y)
{
WinGet, remotePlay_id, List, ahk_exe RemotePlay.exe
if (remotePlay_id = 0)
{
MsgBox, PS4 Remote Play not found
return
}
if remotePlay_id
{
pc_wID := remotePlay_id[0]
pc_hDC := DllCall("GetDC", "UInt", pc_wID)
pc_fmtI := A_FormatInteger
SetFormat, IntegerFast, Hex
pc_c := DllCall("GetPixel", "UInt", pc_hDC, "Int", pc_x, "Int", pc_y, "UInt")
pc_c := pc_c >> 16 & 0xff | pc_c & 0xff00 | (pc_c & 0xff) << 16
pc_c .= ""
SetFormat, IntegerFast, %pc_fmtI%
DllCall("ReleaseDC", "UInt", pc_wID, "UInt", pc_hDC)
return pc_c
}
}
GetClientSize(hWnd, ByRef w := "", ByRef h := "")
{
VarSetCapacity(rect, 16)
DllCall("GetClientRect", "ptr", hWnd, "ptr", &rect)
w := NumGet(rect, 8, "int")
h := NumGet(rect, 12, "int")
}
Distance(c1, c2)
{
return Sqrt((((c1>>16)-(c2>>16))**2)+(((c1>>8&255)-(c2>>8&255))**2)+(((c1&255)-(c1&255))**2))
}
MenuTest:
gosub, GrabRemotePlay
GetClientSize(id, ps_win_width, ps_win_height)
gosub, PixelTuning
MsgBox, Width %ps_win_width% Height %ps_win_height% pix1 %pix1x%
return
GetColo_p:
gosub, GrabRemotePlay
color_check1 := PixelColorSimple(pix1x, pix1y)
c1_alt := true
MsgBox, Put this in for color_check1 %color_check1%
return
GetColo_g:
gosub, GrabRemotePlay
color_check2 := PixelColorSimple(pix2x, pix2y)
c1_alt := false
MsgBox, Put this in for color_check2 %color_check2%
return
GetColo_C:
gosub, GrabRemotePlay
color_check3 := PixelColorSimple(pix3x, pix3y)
c1_alt := false
MsgBox, Put this in for color_check3 %color_check3%
return
PSystem:
Gui, Submit, NoHide
if (SysCheck = 1){
ps_load_time1 := 14000
ps_load_time2 := 7000
ps_load_time3 := 8400
}
if (SysCheck = 2){
ps_load_time1 := 41500
ps_load_time2 := 12000
ps_load_time3 := 40000
}
return
MenuSel:
Gui, Submit, NoHide
if (MenuCheck = 1){
menu_s := 1
}
if (MenuCheck = 2){
menu_s := 2
}
return
PauseLoop:
ControlSend,, {%accel% up}, ahk_id %id%
ControlSend,, {%nitros% up}, ahk_id %id%
ControlSend,, {%turnLeft% up}, ahk_id %id%
ControlSend,, {%turnRight% up}, ahk_id %id%
return
GuiClose:
gosub, PauseLoop
ExitApp
^Esc::ExitA
;================= END SCRIPT ===================
