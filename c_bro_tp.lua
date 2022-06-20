-- teleports the player to a specific location
function teleport(x,y,z)
    Citizen.CreateThread(function() -- create a new thread, to run parallel. 

        x = x + 0.0
        y = y + 0.0
        z = z + 0.0
        RequestCollisionAtCoord(x, y, z) -- make sure the player can actually arrive at the destination

        while not HasCollisionLoadedAroundEntity(PlayerPedId()) do -- create a loop and wait until the collision is loaded.
            RequestCollisionAtCoord(x, y, z)
            Citizen.Wait(1)
        end

        SetPedCoordsKeepVehicle(PlayerPedId(), x, y, z) -- at this point the collision is loaded, so set the entity coords. 
        for height = 1, 1000 do
            SetPedCoordsKeepVehicle(PlayerPedId(), x, y, height+0.0) -- at this point the collision is loaded, so set the entity coords. 
            local retval, ground_z = GetGroundZFor_3dCoord(x,y,height+0.0,false)
            print(retval, ground_z, height)
            if retval then
                print(retval, ground_z)
                SetPedCoordsKeepVehicle(PlayerPedId(), x, y, ground_z) -- at this point the collision is loaded, so set the entity coords. 
                break;
            end
            -- Citizen.Wait(0)
        end

    end)
end



RegisterNetEvent("bro_admin:on_tp")
AddEventHandler("bro_admin:on_tp", function(args)
    if args[1] and args[2] and args[3] then
        teleport(args[1],args[2],args[3])
    else -- if no coorda re given, maybe the user want to teleport to an blip
       
        local WaypointHandle = GetFirstBlipInfoId(8)  -- fetch the current player blip. The return is a handle, which is a referenz for this blip. 
        if DoesBlipExist(WaypointHandle) then -- check if the blip exists
            local waypointCoords = GetBlipInfoIdCoord(WaypointHandle) -- if it does exist, fecth its coords. 
            teleport(waypointCoords.x, waypointCoords.y, waypointCoords.z) -- we can reuse our function, with different input
        end
    end
end)