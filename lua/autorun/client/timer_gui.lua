if CLIENT then

    print("-----------------------------\n--Shutdown Timer GUI Loaded--\n-----------------------------")
    
    local timerUI = {}
    local timerProgress = {}

    
    --[[
        Function: Draws or hide the Timer GUI based on wether it should be drawn or not according to the server
        INPUT: INT time, INT status
        OUTPUT: Tells the client to draw or hide the timer GUI
    ]]--
    function StartShutdownTimer(time, status)

        if status == 1 then
            DebugPrint("Server shutting down in ".. time.. " seconds. There is ".. TIMER_TimeRemaining * 100 .. " % of time left.")
            CreateFrame()
        else
            DebugPrint("Server shutdown aborted.")
            if timerUI:IsValid() then timerUI:SetVisible(false) end
        end

    end
--[[
        Function: Updates the progress bar on the GUI to properly reflect the time remaining
        INPUT: INT timeRemaining, INT time
        OUTPUT: NONE
    ]]--
    function UpdateTimer(timeRemaining, time)

        if not timerUI:IsValid() then return end

        DebugPrint("Time Remaining: ".. timeRemaining.. "\nTimer Length: ".. time.."\nSetting Progress bar to: "..timeRemaining / time)
        timerProgress:SetFraction(timeRemaining / time)
    end


    -- Derma Settings
        dermaPanelFontType = "HudSelectionText"
        dermaPanelFontColour = Color(119, 135, 137, 255)
        dermaPanelFontColour2 = Color(255, 255, 255, 255)
        dermaPanelButtonColour1 = Color(119, 135, 137, 255)
        dermaPanelButtonColour2 = Color(234, 204, 84, 255)
        dermaPanelButtonColour3 = Color(159, 234, 84, 255)
        dermaPanelButtonColour4 = Color(239, 134, 134, 255)
        dermaPanelButtonColour5 = Color(145, 145, 145, 255)
        dermaPanelButtonColour6 = Color(60, 60, 145, 255)
        dermaPanelButtonColour7 = Color(239, 134, 134, 100)
        dermaPanelButtonColour8 = Color(119, 135, 137, 100)
        dermaFrameCurve = 10
        dermaPanelButtonCurve = 10
    -- End of Derma Settings
    
    --[[
        Function: Draws the actual frame for the GUI and sets everything into it's position. The paint functions paint the items and give them color & make it look prettier
        INPUT: NONE
        OUTPUT: NONE
    ]]--
    function CreateFrame()
        timerUI = vgui.Create("DFrame")
		timerUI:SetPos(ScrW() * 1620/1920, ScrH() * 0/1080)
		timerUI:SetSize( ScrW() * 600/1920, ScrH() * 60/1080 )
        timerUI:SetPos()
        timerUI:SetVisible(true)
        timerUI:SetTitle("")
        timerUI:ShowCloseButton(true)
        timerUI.Paint = function(s, w, h)
            draw.RoundedBox(dermaFrameCurve, 0, 0, w, h, Color(0,0,0, 100))
            draw.RoundedBox(dermaFrameCurve, 2, 2, w-4, h-4, Color(199,204,157, 100))
        end

        timerProgress = vgui.Create("DProgress")
        timerProgress:SetPos(50, 30)
        timerProgress:SetSize(500, 20)
        timerProgress:SetFraction(1)
        timerProgress:SetParent(timerUI)
        timerProgress.Paint = function(s, w, h)
            
            draw.RoundedBox(dermaFrameCurve, 0, 0, w, h, Color(0,0,0, 180))
            draw.RoundedBox(dermaFrameCurve, 2, 2, w-4, h-4, Color(199,204,157, 180))

            draw.RoundedBox(dermaFrameCurve, 2, 2, w * timerProgress:GetFraction(), h-4, Color(255,255,255, 180))

        end
    end


    

end
