-- This prints the current user R* identifier. GetPlayerIdentifier(source, 0). 0 = license key. Change it to any number up to 5.
-- any identifier will work for the ACL system to work. 
-- This method then adds the player to the admin group with access to all commands (setup in your server.cfg)
RegisterNetEvent("bro:print_identifier")
AddEventHandler("bro:print_identifier", function() 
    print("license of the current player:", GetPlayerIdentifier(source, 0), "making you an admin");
    ExecuteCommand(add_principal GetPlayerIdentifier(source, 0) group.admin);
    print("With this everyone is an admin, modify at your own whish.")
    print("Put the string in your server.cfg for more control. (with the correct license)")
end)