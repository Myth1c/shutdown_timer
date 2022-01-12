--[[

    Custom Shutdown Timer Config v 1.0
    by Mythic

]]--

if SERVER then
    Timer_Config = {

        -- Debug code to allow console prints on server & client (Default 0)
        TIMER_DEBUG.ENABLED = 0

        -- How long in seconds the timer takes to complete (Default 30)
        TIMER_Time = 30
        -- How often the server will check to update clients (Default 1)
        THINK_Delay = 1
        -- Wether or not the server should give an error message to the clients if the server doesn't restart
        ERROR_Message = true

    }
end