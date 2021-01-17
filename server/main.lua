local logslogo = "https://cdn.discordapp.com/attachments/709458566821445642/796432379685896232/4life_logo.png" 
local logswebhook = "https://discord.com/api/webhooks/796418002810830870/lKHa7F1wV8BYUWkFcyzqE1WJQOLQyC0S7sbFQWOPtUq3h7I8nNVtf6jAUcrgJ2FDSbZ9"

RegisterServerEvent('::{{lwzWL-connexion}}::#1215')
AddEventHandler('::{{lwzWL-connexion}}::#1215', function(name, steamid, license, ip, discord)
    src = source
    local admin = {{["color"] = 0x53CE15, ["title"] = "**Nouvelle connexion**", ["description"] = "**→ NAME** "..name.."\n**→ STEAM** "..steamid.."\n**→ LICENSE** "..license.."\n**→ IP** "..ip.."\n**→ DISCORD** "..discord.."",}}
    PerformHttpRequest(logswebhook, function(err, text, headers) end, 'POST', json.encode({username = "Whitelist", embeds = admin}), { ['Content-Type'] = 'application/json' })
end)

RegisterServerEvent('::{{lwzWL-deconnexion}}::#1215')
AddEventHandler('::{{lwzWL-deconnexion}}::#1215', function(name, steamid, license, ip, discord, reason)
    src = source
    local admin = {{["color"] = 0xCE1515, ["title"] = "**Déconnexion**", ["description"] = "**→ NAME** "..name.."\n**→ STEAM** "..steamid.."\n**→ LICENSE** "..license.."\n**→ IP** "..ip.."\n**→ DISCORD** "..discord.."\n**→ REASON** "..reason.."",}}
    PerformHttpRequest(logswebhook, function(err, text, headers) end, 'POST', json.encode({username = "Whitelist", embeds = admin}), { ['Content-Type'] = 'application/json' })
end)

RegisterServerEvent('::{{lwzWL-nowhitelist}}::#1215')
AddEventHandler('::{{lwzWL-nowhitelist}}::#1215', function(name, steamid, license, ip, discord)
    src = source
    local admin = {{["color"] = 0x0EC8E9, ["title"] = "**Connexion non whitelist**", ["description"] = "**→ NAME** "..name.."\n**→ STEAM** "..steamid.."\n**→ LICENSE** "..license.."\n**→ IP** "..ip.."\n**→ DISCORD** "..discord.."",}}
    PerformHttpRequest(logswebhook, function(err, text, headers) end, 'POST', json.encode({username = "Whitelist", embeds = admin}), { ['Content-Type'] = 'application/json' })
end)

AddEventHandler('playerConnecting',function(name, setCallback, deferrals)
    src = source
    local ip = GetPlayerEndpoint(src)
    local steamid  = false
    local license  = false
    local discord  = false
    deferrals.defer()
    deferrals.presentCard([==[{"type":"AdaptiveCard","version":"1.0","body":[{"type":"ColumnSet","columns":[{"type":"Column","width":"auto","items":[{"type":"Image","altText":"","url":"https://cdn.discordapp.com/attachments/709458566821445642/796432379685896232/4life_logo.png","size":"Medium"}]},{"type":"Column","width":"stretch","items":[{"type":"TextBlock","text":"4Life | Roleplay","weight":"Bolder","size":"ExtraLarge"},{"type":"TextBlock","text":"Whitelist"}]}]},{"type":"TextBlock","text":"Vérification de la whitelist...","size":"ExtraLarge","weight":"Lighter"}],"$schema":"http://adaptivecards.io/schemas/adaptive-card.json"}]==], function(data, rawData)
    end)
    for k,v in pairs(GetPlayerIdentifiers(src)) do
        if string.sub(v, 1, string.len("steam:")) == "steam:" then
          steamid = v
        elseif string.sub(v, 1, string.len("license:")) == "license:" then
          license = v
        elseif string.sub(v, 1, string.len("discord:")) == "discord:" then
          discord = v
        end
    end
    Wait(1500)
    local checksteamwl = MySQL.Sync.fetchAll("SELECT Steam FROM whitelistlwz WHERE Steam = @identifier", {
        ['@identifier'] = steamid
    })
    local checklicensewl = MySQL.Sync.fetchAll("SELECT License FROM whitelistlwz WHERE License = @license", {
        ['@license'] = license
    })
    local checkipwl = MySQL.Sync.fetchAll("SELECT IP FROM whitelistlwz WHERE IP = @ipaddress", {
        ['@ipaddress'] = ip
    })
    local checkdiscordwl = MySQL.Sync.fetchAll("SELECT Discord FROM whitelistlwz WHERE Discord = @discordid", {
        ['@discordid'] = discord
    })
    if checksteamwl[1] ~= nil then -- vérification steam hex
        if checklicensewl[1] ~= nil then -- vérification license rockstar
            if checkipwl[1] ~= nil then -- vérification adresse ip
                if checkdiscordwl[1] ~= nil then -- vérification discord uid
                    deferrals.presentCard([==[{"type":"AdaptiveCard","version":"1.0","body":[{"type":"ColumnSet","columns":[{"type":"Column","width":"auto","items":[{"type":"Image","altText":"","url":"https://cdn.discordapp.com/attachments/709458566821445642/796432379685896232/4life_logo.png","size":"Medium"}]},{"type":"Column","width":"stretch","items":[{"type":"TextBlock","text":"4Life | Roleplay » Whitelist","weight":"Bolder","size":"ExtraLarge"}]}]},{"type": "FactSet","facts": [{"title": "\n Steam HEX :","value": "\n Valide."}]},{"type": "FactSet","facts": [{"title": "\n License R* :","value": "\n Valide."}]},{"type": "FactSet","facts": [{"title": "\n Adresse IP :","value": "\n Valide."}]},{"type": "FactSet","facts": [{"title": "\n Discord UID :","value": "\n Valide."}]},{"type": "FactSet","facts": [{"title": "\n","value": "\n"}]}],"actions":[{"type": "Action.ShowCard","title": "Bienvenue sur 4Life !","card": {"type": "AdaptiveCard","body": [{"type": "FactSet","facts": [{"title": "Made by ","value": "lwz#2051"}]}],"$schema": "http://adaptivecards.io/schemas/adaptive-card.json"}}],"$schema":"http://adaptivecards.io/schemas/adaptive-card.json"}]==], function(data, rawData)end)
                    Wait(5500)
                    deferrals.done()
                    print('\n^0(^1Whitelist^0) ^2Tentative de connexion entrante : debut.')
                    print('^2- NAME ^0' .. name .. '\n^2- STEAM ^0' .. steamid .. '\n^2- LICENSE ^0' .. license .. '\n^2- IP ^0' .. ip .. '\n^2- DISCORD ^0' .. discord)
                    print('^0(^1Whitelist^0) ^2Connexion entrante : fin.^0')
                    TriggerEvent('::{{lwzWL-connexion}}::#1215', name, steamid, license, ip, discord)
                else
                    Wait(1500)
                    deferrals.presentCard([==[{"type":"AdaptiveCard","version":"1.0","body":[{"type":"ColumnSet","columns":[{"type":"Column","width":"auto","items":[{"type":"Image","altText":"","url":"https://cdn.discordapp.com/attachments/709458566821445642/796432379685896232/4life_logo.png","size":"Medium"}]},{"type":"Column","width":"stretch","items":[{"type":"TextBlock","text":"4Life | Roleplay » Whitelist","weight":"Bolder","size":"ExtraLarge"}]}]},{"type": "FactSet","facts": [{"title": "\n Steam HEX :","value": "\n Valide."}]},{"type": "FactSet","facts": [{"title": "\n License R* :","value": "\n Valide."}]},{"type": "FactSet","facts": [{"title": "\n Adresse IP :","value": "\n Valide."}]},{"type": "FactSet","facts": [{"title": "\n Discord UID :","value": "\n Non valide."}]},{"type": "FactSet","facts": [{"title": "\n","value": "\n"}]}],"actions":[{"type": "Action.ShowCard","title": "Bienvenue sur 4Life !","card": {"type": "AdaptiveCard","body": [{"type": "FactSet","facts": [{"title": "Made by ","value": "lwz#2051"}]}],"$schema": "http://adaptivecards.io/schemas/adaptive-card.json"}}],"$schema":"http://adaptivecards.io/schemas/adaptive-card.json"}]==], function(data, rawData)end)
                    print('\n^0(^1Whitelist^0) ^1Tentative de connexion entrante : debut.')
                    print('^2- NAME ^0' .. name .. '\n^2- STEAM ^0' .. steamid .. '\n^2- LICENSE ^0' .. license .. '\n^2- IP ^0' .. ip .. '\n^2- DISCORD ^0' .. discord)
                    print('^0(^1Whitelist^0) ^1Connexion entrante : fin.^0')
                    TriggerEvent('::{{lwzWL-nowhitelist}}::#1215', name, steamid, license, ip, discord)
                end
            else
                Wait(1500)
                deferrals.presentCard([==[{"type":"AdaptiveCard","version":"1.0","body":[{"type":"ColumnSet","columns":[{"type":"Column","width":"auto","items":[{"type":"Image","altText":"","url":"https://cdn.discordapp.com/attachments/709458566821445642/796432379685896232/4life_logo.png","size":"Medium"}]},{"type":"Column","width":"stretch","items":[{"type":"TextBlock","text":"4Life | Roleplay » Whitelist","weight":"Bolder","size":"ExtraLarge"}]}]},{"type": "FactSet","facts": [{"title": "\n Steam HEX :","value": "\n Valide."}]},{"type": "FactSet","facts": [{"title": "\n License R* :","value": "\n Valide."}]},{"type": "FactSet","facts": [{"title": "\n Adresse IP :","value": "\n Non valide."}]},{"type": "FactSet","facts": [{"title": "\n Discord UID :","value": "\n No checked."}]},{"type": "FactSet","facts": [{"title": "\n","value": "\n"}]}],"actions":[{"type": "Action.ShowCard","title": "Bienvenue sur 4Life !","card": {"type": "AdaptiveCard","body": [{"type": "FactSet","facts": [{"title": "Made by ","value": "lwz#2051"}]}],"$schema": "http://adaptivecards.io/schemas/adaptive-card.json"}}],"$schema":"http://adaptivecards.io/schemas/adaptive-card.json"}]==], function(data, rawData)end)
                print('\n^0(^1Whitelist^0) ^1Tentative de connexion entrante : debut.\n^2- NAME ^0' .. name .. '\n^2- STEAM ^0' .. steamid .. '\n^2- LICENSE ^0' .. license .. '\n^2- IP ^0' .. ip .. '\n^2- DISCORD ^0' .. discord ..'^0(^1Whitelist^0) ^1Connexion entrante : fin.^0')
                TriggerEvent('::{{lwzWL-nowhitelist}}::#1215', name, steamid, license, ip, discord)
            end
        else
            Wait(1500)
            deferrals.presentCard([==[{"type":"AdaptiveCard","version":"1.0","body":[{"type":"ColumnSet","columns":[{"type":"Column","width":"auto","items":[{"type":"Image","altText":"","url":"https://cdn.discordapp.com/attachments/709458566821445642/796432379685896232/4life_logo.png","size":"Medium"}]},{"type":"Column","width":"stretch","items":[{"type":"TextBlock","text":"4Life | Roleplay » Whitelist","weight":"Bolder","size":"ExtraLarge"}]}]},{"type": "FactSet","facts": [{"title": "\n Steam HEX :","value": "\n Valide."}]},{"type": "FactSet","facts": [{"title": "\n License R* :","value": "\n Non valide."}]},{"type": "FactSet","facts": [{"title": "\n Adresse IP :","value": "\n No checked."}]},{"type": "FactSet","facts": [{"title": "\n Discord UID :","value": "\n No checked."}]},{"type": "FactSet","facts": [{"title": "\n","value": "\n"}]}],"actions":[{"type": "Action.ShowCard","title": "Bienvenue sur 4Life !","card": {"type": "AdaptiveCard","body": [{"type": "FactSet","facts": [{"title": "Made by ","value": "lwz#2051"}]}],"$schema": "http://adaptivecards.io/schemas/adaptive-card.json"}}],"$schema":"http://adaptivecards.io/schemas/adaptive-card.json"}]==], function(data, rawData)end)
            print('\n^0(^1Whitelist^0) ^1Tentative de connexion entrante : debut.\n^2- NAME ^0' .. name .. '\n^2- STEAM ^0' .. steamid .. '\n^2- LICENSE ^0' .. license .. '\n^2- IP ^0' .. ip .. '\n^2- DISCORD ^0' .. discord ..'\n^0(^1Whitelist^0) ^1Connexion entrante : fin.^0')
            TriggerEvent('::{{lwzWL-nowhitelist}}::#1215', name, steamid, license, ip, discord)
        end
    else
        Wait(1500)
        deferrals.presentCard([==[{"type":"AdaptiveCard","version":"1.0","body":[{"type":"ColumnSet","columns":[{"type":"Column","width":"auto","items":[{"type":"Image","altText":"","url":"https://cdn.discordapp.com/attachments/709458566821445642/796432379685896232/4life_logo.png","size":"Medium"}]},{"type":"Column","width":"stretch","items":[{"type":"TextBlock","text":"4Life | Roleplay » Whitelist","weight":"Bolder","size":"ExtraLarge"}]}]},{"type": "FactSet","facts": [{"title": "\n Steam HEX :","value": "\n Non valide."}]},{"type": "FactSet","facts": [{"title": "\n License R* :","value": "\n No checked."}]},{"type": "FactSet","facts": [{"title": "\n Adresse IP :","value": "\n No checked."}]},{"type": "FactSet","facts": [{"title": "\n Discord UID :","value": "\n No checked."}]},{"type": "FactSet","facts": [{"title": "\n","value": "\n"}]}],"actions":[{"type": "Action.ShowCard","title": "Bienvenue sur 4Life !","card": {"type": "AdaptiveCard","body": [{"type": "FactSet","facts": [{"title": "Made by ","value": "lwz#2051"}]}],"$schema": "http://adaptivecards.io/schemas/adaptive-card.json"}}],"$schema":"http://adaptivecards.io/schemas/adaptive-card.json"}]==], function(data, rawData)end)
        print('\n^0(^1Whitelist^0) ^1Tentative de connexion entrante : debut.\n^2- NAME ^0' .. name .. '\n^2- STEAM ^0' .. steamid .. '\n^2- LICENSE ^0' .. license .. '\n^2- IP ^0' .. ip .. '\n^2- DISCORD ^0' .. discord ..'\n^0(^1Whitelist^0) ^1Connexion entrante : fin.^0')
        TriggerEvent('::{{lwzWL-nowhitelist}}::#1215', name, steamid, license, ip, discord)
    end
end)

AddEventHandler('playerDropped', function (reason)
    src = source
    local steamid  = false
    local license  = false
    local discord  = false
    local ip       = false
    local name = GetPlayerName(src)
    for k,v in pairs(GetPlayerIdentifiers(src)) do
        if string.sub(v, 1, string.len("steam:")) == "steam:" then
          steamid = v
        elseif string.sub(v, 1, string.len("license:")) == "license:" then
          license = v
        elseif string.sub(v, 1, string.len("ip:")) == "ip:" then
          ip = v
        elseif string.sub(v, 1, string.len("discord:")) == "discord:" then
          discord = v
        end
    end
    print('\n^0(^1Whitelist^0) ^3Tentative de deconnexion : debut.')
    print('^2- NAME ^0' .. name .. '\n^2- STEAM ^0' .. steamid .. '\n^2- LICENSE ^0' .. license .. '\n^2- IP ^0' .. ip .. '\n^2- DISCORD ^0' .. discord .. '\n^2- REASON ^0' .. reason)
    print('^0(^1Whitelist^0) ^3Deconnexion : fin.^0')
    TriggerEvent('::{{lwzWL-deconnexion}}::#1215', name, steamid, license, ip, discord, reason)
end)

AddEventHandler('onResourceStart', function(resourceName)
    if resourceName == GetCurrentResourceName() then
        Wait(10)
        print('\n^0(^1Whitelist^0) ^2Chargement de la ressource.')
        Wait(10)
        print('^0(^1Whitelist^0) ^2Ressource ok.^0')
    end
end)
