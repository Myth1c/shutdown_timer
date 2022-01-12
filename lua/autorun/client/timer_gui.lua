--[[

    Custom Shutdown UI v 1.0
    by Mythic https://steamcommunity.com/id/MythicalMythic/

]]--
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

        local hours = math.floor(timeRemaining / 3600)
        local minutes = math.floor(timeRemaining / 60)
        local seconds = math.floor(timeRemaining % 60)

        local hourText = "" .. tostring(hours)
        local minuteText = "" .. tostring(minutes)
        local secondText = "" .. tostring(seconds)

        if hours < 10 then hourText = "0"..hours end
        if minutes < 10 then minuteText = "0"..minutes end
        if seconds < 10 then secondText = "0"..seconds end

        fullText = "Restart in: "..hourText..":"..minuteText..":"..secondText

        timerLabel:SetText(fullText)
        timerLabel:SetPos(250 - string.len(timerLabel:GetText()), 5)
    end


    -- Derma Settings
        FontType = Timer_Config.GUI_Font or "HudSelectionText"
        FontColour = Timer_Config.GUI_Font_mainColour or Color(255, 255, 255, 255)
        FontColourShadow = Timer_Config.GUI_Font_shadowColour or Color(119, 135, 137, 255)
        FramePrimaryColour = Timer_Config.GUI_Frame_Foreground or Color(120,120,120, 0)
        FrameBorderColour = Timer_Config.GUI_Frame_Background or Color(0,0,0, 0)
        ProgressEmptyColour = Timer_Config.GUI_ProgressBar_Background or Color(60,60,60, 180)
        ProgressBorderColour = Timer_Config.GUI_ProgressBar_Border or Color(0,0,0, 180)
        ProgressBarColour = Timer_Config.GUI_ProgressBar_BarColor or Color(255,255,255, 180)
        FrameCurve = Timer_Config.FrameCurve or 10
    -- End of Derma Settings
    
    --[[
        Function: Draws the actual frame for the GUI and sets everything into it's position. The paint functions paint the items and give them color & make it look prettier
        INPUT: NONE
        OUTPUT: NONE
    ]]--
    function CreateFrame()
        timerUI = vgui.Create("DFrame")
		timerUI:SetPos(ScrW() * 660/1920, ScrH() * 0/1080)
		timerUI:SetSize( ScrW() * 600/1920, ScrH() * 60/1080 )
        timerUI:SetVisible(true)
        timerUI:SetTitle("")
        timerUI:ShowCloseButton(false)
        timerUI.Paint = function(s, w, h)
            draw.RoundedBox(FrameCurve, 0, 0, w, h, FrameBorderColour)
            draw.RoundedBox(FrameCurve, 2, 2, w-4, h-4, FramePrimaryColour)
        end

        timerProgress = vgui.Create("DProgress")
        timerProgress:SetPos(50, 30)
        timerProgress:SetSize(500, 20)
        timerProgress:SetFraction(1)
        timerProgress:SetParent(timerUI)
        timerProgress.Paint = function(s, w, h)
            
            draw.RoundedBox(FrameCurve, 0, 0, w, h, ProgressBorderColour)
            draw.RoundedBox(FrameCurve, 2, 2, w-4, h-4, ProgressEmptyColour)

            draw.RoundedBox(FrameCurve, 2, 2, w * timerProgress:GetFraction(), h-4, ProgressBarColour)

        end

        timerLabel = vgui.Create("DLabel")
        timerLabel:SetFont(FontType)
        timerLabel:SetText("Time Remaining:")
        timerLabel:SetSize( timerUI:GetSize(), 15 )
        timerLabel:SetPos(250 - string.len(timerLabel:GetText()), 5)
        timerLabel:SetParent(timerUI)
        timerLabel:SetTextColor(FontColour)
        timerLabel.Paint = function(s, w, h)
            
            struc = {}
            struc["pos"] = {0, 0}
            struc["color"] = FontColourShadow
            struc["text"] = timerLabel:GetText()
            struc["font"] = FontType
            struc["xalign"] = TEXT_ALIGN_LEFT
            struc["yalign"] = TEXT_ALIGN_TOP
            

            draw.TextShadow(struc, 2, 200)

        end
        
    end


    

end
