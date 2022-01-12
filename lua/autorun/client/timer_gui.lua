if CLIENT then

    print("-----------------------------\n--Shutdown Timer GUI Loaded--\n-----------------------------")
    
    local timerUI = {}
    local timerProgress = {}
    local timerLabel = {}

    
    --[[
        Function: Draws or hide the Timer GUI based on wether it should be drawn or not according to the server
        INPUT: INT time, INT status
        OUTPUT: Tells the client to draw or hide the timer GUI
    ]]--
    function StartShutdownTimer(status)

        if status == 1 then
            DebugPrint("Server shutting down.")
            CreateFrame()
        else
            DebugPrint("Server shutdown aborted.")
            if IsValid(timerUI) then timerUI:SetVisible(false) end
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

        --local hours = math.floor(timeRemaining / 3600)
        local minutes = math.floor(timeRemaining / 60)
        local seconds = math.floor(timeRemaining % 60)

        timerLabel:SetText("Restart in: "..minutes..":"..seconds)
        timerLabel:SetPos(250 - string.len(timerLabel:GetText()), 5)
    end


    -- Derma Settings
        dermaPanelFontType = "HudSelectionText"
        dermaPanelFontColour = Color(119, 135, 137, 255)
        dermaPanelFontColour2 = Color(255, 255, 255, 255)
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

        timerLabel = vgui.Create("DLabel")
        timerLabel:SetFont(dermaPanelFontType)
        timerLabel:SetText("Time Remaining:")
        timerLabel:SetSize( timerUI:GetSize(), 15 )
        timerLabel:SetPos(250 - string.len(timerLabel:GetText()), 5)
        timerLabel:SetParent(timerUI)
        
    end


    

end
