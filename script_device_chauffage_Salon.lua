-- Armand DEHEUNYNCK - 2016
 -- This script allows ...

 --------------------------------
 ------ Start of edit section ------
 --------------------------------
 local sensor = 'Salon' --Name of the thermometer
 local temperature = tonumber(string.sub(otherdevices_svalues[sensor], 0, string.find(otherdevices_svalues[sensor], ";")-1))
 local comfort_temperature = uservariables['Température confort']
 local min_temperature = uservariables['Température mini']
 local heating = 'Chauffage Salon'
 local pas_la = 'Pas là'
 local la = 'Là'
 local planning = 'Planning Salon'
 local hysteresis = uservariables['Hysteresis']
 local mode_manuel = 'Mode manuel'
 local conso = tonumber(string.sub(otherdevices_svalues['Energie'], 0, string.find(otherdevices_svalues['Energie'], ";")-1))
 local max_conso = uservariables['max_conso']
 local heating_max_conso = uservariables['heating_max_conso']

 --------------------------------
 -- End of edit section --
 --------------------------------

 commandArray = {}

if devicechanged[sensor] then

        if otherdevices[pas_la]=='Off' and otherdevices[mode_manuel]=='Off' then

                if otherdevices[planning]=='On' or otherdevices[la]=='On' then

                        if (temperature < (comfort_temperature - hysteresis) and otherdevices[heating]=='Off') and conso < (max_conso - heating_max_conso)  then
                                print ("Allumage du chauffage du salon")
                                commandArray[heating]='On'
                        end

                        if ((temperature > (comfort_temperature + hysteresis) and otherdevices[heating]=='On')) or (conso > max_conso and otherdevices[heating]=='On')  then
                                print ("Extinction du chauffage du salon")
                                commandArray[heating]='Off'
                        end
                end

                if otherdevices[planning]=='Off' and otherdevices[la]=='Off' then

                        if (temperature < (min_temperature - hysteresis) and otherdevices[heating]=='Off') and conso < (max_conso - heating_max_conso)  then
                                print ("Allumage du chauffage du salon")
                        end

                        if ((temperature > (min_temperature + hysteresis) and otherdevices[heating]=='On')) or (conso > max_conso and otherdevices[heating]=='On')  then
                                print ("Extinction du chauffage du salon")
                                commandArray[heating]='Off'
                        end
                end

        end

end

return commandArray