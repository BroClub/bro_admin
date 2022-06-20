-- teleports the player to a specific location
function teleport(x,y,z)
    Citizen.CreateThread(function() -- create a new thread, to run parallel. 

        RequestCollisionAtCoord(x, y, z) -- make sure the player can actually arrive at the destination

        while not HasCollisionLoadedAroundEntity(PlayerPedId()) do -- create a loop and wait until the collision is loaded.
            RequestCollisionAtCoord(x, y, z)
            Citizen.Wait(1)
        end
    
        SetPedCoordsKeepVehicle(PlayerPedId(), x, y, z) -- at this point the collision is loaded, so set the entity coords. 

    end)
end

RegisterCommand("tp", function(source --[[ this is the player ID (on the server): a number ]], args --[[ this is a table of the arguments provided ]], rawCommand --[[ this is what the user entered ]])
    if source >= 0 then
        if args[1] and args[2] and args[3] then
            teleport(args[1],args[2],args[3])
        else -- if no coorda re given, maybe the user want to teleport to an blip
           
            local WaypointHandle = GetFirstBlipInfoId(8)  -- fetch the current player blip. The return is a handle, which is a referenz for this blip. 
            if DoesBlipExist(WaypointHandle) then -- check if the blip exists
                local waypointCoords = GetBlipInfoIdCoord(WaypointHandle) -- if it does exist, fecth its coords. 
                teleport(waypointCoords.x, waypointCoords.y, waypointCoords.z) -- we can reuse our function, with different input
            end
        end
    else
        print("This is console!")
    end
end, true) -- this true bool means that the user cannot execute the command unless they have the 'command.commandName' ACL object allowed to one of their identifiers.
