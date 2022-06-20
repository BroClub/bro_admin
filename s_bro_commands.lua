RegisterCommand("noclip", function(source --[[ this is the player ID (on the server): a number ]], args --[[ this is a table of the arguments provided ]], rawCommand --[[ this is what the user entered ]])
    if source > 0 then
        TriggerClientEvent("bro_admin:on_noclip", source, args)
    else
        print("This is console!")
    end
end, true) -- this true bool means that the user cannot execute the command unless they have the 'command.commandName' ACL object allowed to one of their identifiers.

RegisterCommand("tp", function(source --[[ this is the player ID (on the server): a number ]], args --[[ this is a table of the arguments provided ]], rawCommand --[[ this is what the user entered ]])
    if source > 0 then
        TriggerClientEvent("bro_admin:on_tp", source, args)
    else
        print("This is console!")
    end
end, true) -- this true bool means that the user cannot execute the command unless they have the 'command.commandName' ACL object allowed to one of their identifiers.

RegisterCommand("car", function(source --[[ this is the player ID (on the server): a number ]], args --[[ this is a table of the arguments provided ]], rawCommand --[[ this is what the user entered ]])
    if source > 0 then
        TriggerClientEvent("bro_admin:on_car", source, args)
    else
        print("This is console!")
    end
end, true) -- this true bool means that the user cannot execute the command unless they have the 'command.commandName' ACL object allowed to one of their identifiers.