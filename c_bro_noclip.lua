-- define global variables for noclip navigation
local playerPed = nil
local noclip = false;
local noclip_left = false;
local noclip_right = false;
local noclip_foward = false;
local noclip_back = false;
local noclip_up = false;
local noclip_down = false;
local noclip_speed_up = false;
local noclip_speed_down = false;
local speed = 1.0;

function onStartup()
    TriggerServerEvent("bro:print_identifier")
    playerPed = PlayerPedId()

    -- begin of keyboard input mapping
    RegisterCommand('+noclip_left', function()
        noclip_left = true
    end, false)
    RegisterCommand('-noclip_left', function()
        noclip_left = false
    end, false)
    -- if we use a name with a leaing +, the same command with - is called as well. As soon as the button is no longer pressed. 
    RegisterKeyMapping('+noclip_left', 'No Clip Left', 'keyboard', 'a') -- actual native to setup the listener
    -- end of keyboard input mapping

    RegisterCommand('+noclip_right', function()
        noclip_right = true
    end, false)
    RegisterCommand('-noclip_right', function()
        noclip_right = false
    end, false)
    RegisterKeyMapping('+noclip_right', 'No Clip Right', 'keyboard', 'd')

    RegisterCommand('+noclip_foward', function()
        noclip_foward = true
    end, false)
    RegisterCommand('-noclip_foward', function()
        noclip_foward = false
    end, false)
    RegisterKeyMapping('+noclip_foward', 'No Clip Forward', 'keyboard', 'w')

    RegisterCommand('+noclip_back', function()
        noclip_back = true
    end, false)
    RegisterCommand('-noclip_back', function()
        noclip_back = false
    end, false)
    RegisterKeyMapping('+noclip_back', 'No Clip Back', 'keyboard', 's')
    
    RegisterCommand('+noclip_up', function()
        noclip_up = true
    end, false)
    RegisterCommand('-noclip_up', function()
        noclip_up = false
    end, false)
    RegisterKeyMapping('+noclip_up', 'No Clip UP', 'keyboard', 'space')
    
    RegisterCommand('+noclip_down', function()
        noclip_down = true
    end, false)
    RegisterCommand('-noclip_down', function()
        noclip_down = false
    end, false)
    RegisterKeyMapping('+noclip_down', 'No Clip Down', 'keyboard', 'lshift')

    RegisterCommand('+noclip_speed_up', function()
        noclip_speed_up = true
    end, false)
    RegisterCommand('-noclip_speed_up', function()
        noclip_speed_up = false
    end, false)
    RegisterKeyMapping('+noclip_speed_up', 'No Clip Speed Up', 'keyboard', 'IOM_WHEEL_UP')

    RegisterCommand('+noclip_speed_down', function()
        noclip_speed_down = true
    end, false)
    RegisterCommand('-noclip_speed_down', function()
        noclip_speed_down = false
    end, false)
    RegisterKeyMapping('+noclip_speed_down', 'No Clip Speed Down', 'keyboard', 'IOM_WHEEL_DOWN')
end

-- called on every frame. Used for ingame Settings. No calculations like distances
function onFrame()
    if not playerPed then
        return
    end

    if noclip then
        HudWeaponWheelIgnoreSelection()
        HudForceWeaponWheel(false)

        local x, y, z =  table.unpack(GetEntityCoords(playerPed, true))
        local dx, dy, dz = getCamDirection()
        
        if noclip_foward then
            x = x + speed * dx
            y = y + speed * dy
            z = z + speed * dz
        end

        if noclip_back then
            x = x - speed * dx
            y = y - speed * dy
            z = z - speed * dz
        end

        if noclip_up then
            z = z + speed
        end

        if noclip_down then
            z = z - speed
        end

        if noclip_right then
            local head = GetGameplayCamRelativeHeading() + GetEntityHeading(playerPed) - 90

            local locx = -math.sin(head * math.pi/180.0)
            local locy = math.cos(head * math.pi/180.0)
        
            x = x + speed * locx
            y = y + speed * locy
        end

        if noclip_left then
            local head = GetGameplayCamRelativeHeading() + GetEntityHeading(playerPed) + 90

            local locx = -math.sin(head * math.pi/180.0)
            local locy = math.cos(head * math.pi/180.0)
        
            x = x + speed * locx
            y = y + speed * locy
        end

        if noclip_speed_up then
            if speed < 7.5 then
                speed = speed + 0.05
            end
        end        
        
        if noclip_speed_down then
            if speed > 0.1 then
                speed = speed - 0.05
            end
        end


        -- SetFollowPedCamViewMode(4)
        SetEntityCoordsNoOffset(playerPed, x, y, z, true, true, true)
    end
end

-- called every 500ms. Used for expensive calculations.
function onCalculation()
end

function getCamDirection()
	local heading = GetGameplayCamRelativeHeading() + GetEntityHeading(playerPed)
	local pitch = GetGameplayCamRelativePitch()

	local x = -math.sin(heading * math.pi/180.0)
	local y = math.cos(heading * math.pi/180.0)
	local z = math.sin(pitch * math.pi/180.0)

	local len = math.sqrt(x * x + y * y + z * z)

	if len ~= 0 then
		x = x/len
		y = y/len
		z = z/len
	end

	return x, y, z
end

-- start every frame function
AddEventHandler("onClientResourceStart", function (resourcename)
	if resourcename == GetCurrentResourceName() then
        Citizen.CreateThread(function()
            Citizen.Wait(2500)
            onStartup()
        end)
		-- Every Frame
		Citizen.CreateThread(function()
			Citizen.Wait(100)
			while true do
				Citizen.Wait(0)
				onFrame()
			end
		end)
		-- Once every 500ms
		Citizen.CreateThread(function()
			Citizen.Wait(100)
			while true do
				Citizen.Wait(500)
				onCalculation()
			end
		end)
    end
end)

RegisterNetEvent("bro_admin:on_noclip")
AddEventHandler("bro_admin:on_noclip", function()
    noclip = not noclip
end)