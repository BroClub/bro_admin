# Bro_Club lightweight admin control
This resource is completely free to use in any way. 

##tp
this first basic command allows you to teleport freely ont he map. 
We utilise a double check and either tp to the provided x,y,z or we check if a marker is set on the map and teleport there. 
We also make sure to keep the current vehicle you are in

##car
The second command allows you to freely spawn any vehicle, vanilly or custom.
We load the model and wait for it before we actually spawn in the vehicle using the respective native.
This vehicle is local, meaning its not networked. Mostly this is used at selling or preview resources. 

##noclip
The third and last command allows you to use noclip. With this you can freely travel the world at different speed.
This resource uses the basic client template from https://github.com/BroClub/hero.
We are creating commands (key mapping) which can be changed by the user in the settings, instead of using isControlJustPressed. 