 -- Armand DEHEUNYNCK - 2016

 --------------------------------
 ------ Start of edit section ------
 --------------------------------
 local blind_cuisine = 'Cuisine' 
 local blind_salon = 'Salon' 
 local mode_automatique = 'Mode automatique'
 local offset_sunrise = uservariables['Décalage lever du soleil']
 local offset_sunset = uservariables['Décalage coucher du soleil']

 --------------------------------
 -- End of edit section --
 --------------------------------

 commandArray = {}

ostime = os.date('%H:%M') -- récupération de l'heure système

-- détermination des minutes de l'heure d'ouverture et de fermeture
-- gestion des cas où l'offset utilisateur amène à passer à l'heure suivante
minute_ouverture = timeofday['SunriseInMinutes'] % 60 + offset_sunrise
offset_heure_ouverture = math.floor (minute_ouverture / 60)
minute_ouverture = minute_ouverture % 60

minute_fermeture = timeofday['SunsetInMinutes'] % 60 + offset_sunset
offset_heure_fermeture = math.floor (minute_fermeture / 60)
minute_fermeture = minute_fermeture % 60

-- détermination des heures d'ouvertures et de fermeture
heure_ouverture = string.format("%02d", math.floor(timeofday['SunriseInMinutes'] / 60) + offset_heure_ouverture)  .. ":" ..   string.format("%02d",minute_ouverture)
heure_fermeture = string.format("%02d",math.floor(timeofday['SunsetInMinutes'] / 60) + offset_heure_fermeture)  .. ":" ..  string.format("%02d",minute_fermeture)

-- lancement des commandes dans le cas où l'heure système est identique à l'heure d'ouverture ou fermeture
if (ostime == heure_ouverture and otherdevices[mode_automatique] == 'On') then
	commandArray[blind_cuisine]='Off' -- commande inversée ?!
	commandArray[blind_salon]='Off' -- commande inversée ?!
end 

if (ostime == heure_fermeture and otherdevices[mode_automatique] == 'On') then
	commandArray[blind_cuisine]='On' -- commande inversée ?!
	commandArray[blind_salon]='On' -- commande inversée ?!
end 

return commandArray