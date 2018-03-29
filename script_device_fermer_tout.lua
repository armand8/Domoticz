 -- Armand DEHEUNYNCK - 2016
 
 --------------------------------
 ------ Start of edit section ------
 --------------------------------
 local blind_cuisine = 'Cuisine' 
 local blind_salon = 'Salon' 
 local fermer_tout = 'Fermer tout'

 --------------------------------
 -- End of edit section --
 --------------------------------

 commandArray = {}

if devicechanged[fermer_tout] == 'On' then
	commandArray[blind_cuisine]='On' -- commande inversée ?!
	commandArray[blind_salon]='On' -- commande inversée ?!

end

return commandArray