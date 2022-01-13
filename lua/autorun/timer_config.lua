--[[

    Custom Shutdown Timer Config v 1.2
    by Mythic https://steamcommunity.com/id/MythicalMythic/

]]--

Timer_Config = {
    
    --------------------
    --- Gen Settings ---
    --------------------
    -- Debug code to allow console prints on server & client. Default 0
    TIMER_DEBUG = { ENABLED = 0 },
    -- How long in seconds the timer takes to complete. Default 30
    TIMER_Time = 300,
    -- How often the server will check to update clients. Default 1
    THINK_Delay = 1,
    -- Wether or not the server should give an error message to the clients if the server doesn't restart. Default True
    ERROR_Message = true,




    --------------------
    ---  UI SECTION  ---
    --------------------
    -- Font for all text displayed on the display. Default "HudSelectionText"
    GUI_Font = "HudSelectionText",
    -- Color for the text. Default Color(255, 255, 255, 255)
    GUI_Font_mainColour = Color(255, 255, 255, 255),
    -- Color for the shadow/backdrop of the text. Default Color(119, 135, 137, 255)
    GUI_Font_shadowColour = Color(119, 135, 137, 255),
    -- Color for the foreground of the main frame. Default Color(120, 120, 120, 0)
    GUI_Frame_Foreground = Color(120, 120, 120, 0),
    -- Color for the background of the main frame. Default Color(0, 0, 0, 0)
    GUI_Frame_Background = Color(0, 0, 0, 0),
    -- Color for the background of the progress bar. Default Color(60, 60, 60, 180)
    GUI_ProgressBar_Background = Color(60, 60, 60, 180),
    -- Color for the border on the progress bar. Default Color(0, 0, 0, 180)
    GUI_ProgressBar_Border = Color(0,0,0, 180),
    -- Color for the moving part of the progress bar. Default Color(255, 255, 255, 180)
    GUI_ProgressBar_BarColor = Color(255, 255, 255, 180),
    -- How much the UI should be smoothed out for curves. Default 10
    GUI_FrameCurve = 10,

}

print("----------------------------\n---    Config Loaded     ---\n----------------------------")

if SERVER then
    AddCSLuaFile("includes/init_timer.lua")
    include "includes/init_timer.lua"
else
    include "includes/init_timer.lua"
end
