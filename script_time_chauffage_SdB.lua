 -- Armand DEHEUNYNCK - 2016
 -- This script allows ...
 
 --------------------------------
 ------ Start of edit section ------
 --------------------------------
 local sensor = 'Cuisine' --Name of the thermometer
 local temperature = (string.sub(otherdevices_svalues[sensor], 0, string.find(otherdevices_svalues[sensor], ";")-1))
 local comfort_temperature = uservariables['Température confort']
 local HeureReveil = uservariables['HeureReveil']
 local heating = 'Chauf. SdB'
 local pas_la = 'Pas Là'
 --------------------------------
 -- End of edit section --
 --------------------------------

 commandArray = {}

ostime = os.date('%H:%M')

heureAllumage = string.sub (HeureReveil,0, 3) .. string.sub("%02d", tonumber(string.sub(HeureReveil, 4)) - 8)
heureExtinction = string.sub (HeureReveil,0, 3) .. string.sub("%02d", tonumber(string.sub(HeureReveil, 4)) + 10)

if otherdevices[pas_la]=='Off' and os.date('%A') ~=  'Saturday' and os.date('%A') ~=  'Sunday' then

	if (ostime == heureAllumage and temperature < (comfort_temperature - 1)) then 
		print ("Allumage du chauffage de la salle de bain")
		commandArray[heating]='On'
	end

	if (ostime == heureExtinction) then 
		print ("Extinction du chauffage de la salle de bain")
		commandArray[heating]='Off'
	end

end

return commandArray