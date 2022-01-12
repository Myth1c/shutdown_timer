--[[

    Custom Shutdown Timer v 1.0
    by Mythic https://steamcommunity.com/id/MythicalMythic/
    
]]--
TIMER_DEBUG = Timer_Config.TIMER_DEBUG or { ENABLED = 1 }

if SERVER then
    

    AddCSLuaFile()

    TIMER_Time = Timer_Config.TIMER_Time or 30
    THINK_Delay = Timer_Config.THINK_Delay or 1
    ERROR_Message = Timer_Config.ERROR_Message or true

    shouldShutdown = 0
    THINK_NextThink = CurTime() + THINK_Delay
    TIMER_TimeStarted = 0
    TIMER_TimeRemaining = 0



    print("----------------------------\n---Shutdown Script Loaded---\n----------------------------")


    util.AddNetworkString("shutdown_notify")

    concommand.Add("sv_start_shutdown", function(ply, cmd, args) ToggleShutdown() end, nil, "Start the timer on the server.", 0)

    --[[
        Function: Toggles the shouldShutdown variable between 0 & 1. Also will notify the client that they should either draw or clear the GUI for the timer.
        INPUT: None
        OUTPUT: Sends a networked string to the client
    ]]--
    function ToggleShutdown()

        TIMER_TimeStarted = CurTime()
        TIMER_TimeRemaining = TIMER_TimeStarted + TIMER_Time - CurTime()


        shouldShutdown = 1 - shouldShutdown;
        DebugPrint("Shutdown Status: ".. shouldShutdown.. "\nTime Started: ".. TIMER_TimeStarted.. "\nTime Remaining: ".. TIMER_TimeRemaining)

        SendNetMessage(shouldShutdown, TIMER_TimeRemaining, TIMER_Time, "toggle")


    end

    --[[
        Function: A think function that updates every tick on the server. If there the timer isn't active or if it is active and not enough time has been set for the think, it won't do anything.
        INPUT: None
        OUTPUT: 2 Network Messages that give information for the GUI
    ]]--
    hook.Add("Think", "ShutdownThink", function() 
        if shouldShutdown ~= 1 then return end

        if CurTime() > THINK_NextThink then
            
            TIMER_TimeRemaining = TIMER_TimeStarted + TIMER_Time - CurTime()
            THINK_NextThink = CurTime() + THINK_Delay

            DebugPrint("Time Started: ".. TIMER_TimeStarted.. "\nTime Remaining: ".. TIMER_TimeRemaining)

            SendNetMessage(shouldShutdown, TIMER_TimeRemaining, TIMER_Time, "update")

            if TIMER_TimeRemaining < 1 then 
                shouldShutdown = 0 
                DebugPrint("Shut Down Complete.")

                SendNetMessage(shouldShutdown, TIMER_TimeRemaining, TIMER_Time, "toggle")

            end

        else 
            return 
        end


    end)

    function SendNetMessage(status, time, timeRemaining, type)

        net.Start("shutdown_notify")
            net.WriteInt(shouldShutdown, 2)
            net.WriteInt(TIMER_TimeRemaining, 32)
            net.WriteInt(TIMER_Time, 32)
            net.WriteString(type)
        net.Broadcast()

    end


elseif CLIENT then

    --[[
        Function: Receives network messages for when the timer should be activated or deactivated
        INPUT: None
        OUTPUT: Tells the client to draw or hide the timer GUI
    ]]--

    net.Receive("shutdown_notify", function(len, ply)
    
        local status = net.ReadInt(2)
        local timeRemaining = net.ReadInt(32)
        local time = net.ReadInt(32)
        local type = net.ReadString()

        DebugPrint("Client Status: ".. status .. "\nWarning Length: "..time.."\nTime Remaining: "..timeRemaining)

        if type == "toggle" then 
            StartShutdownTimer(status)
        elseif type == "update" then 
            UpdateTimer(timeRemaining, time)
        else 
            DebugPrint("Invalid network message.") 
        end
    
    end)
        
    -- TODO: Add a client hook to draw the timer if someone connects while the timer is active

end

--[[
    Function: A custom function to print to console while debug mode is activated.
    INPUT: String
    OUTPUT: Prints the input into the console

    TODO: Add a cleaner debug system like this:
    ----   DEBUG   ----
    *messages*
    ---- DEBUG END ----
]]--
function DebugPrint(message)

    if TIMER_DEBUG.ENABLED ~= 1 then return end
    print(message)

end