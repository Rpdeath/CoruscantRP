Rubik_Config = Rubik_Config or {}
Rubik_Lang = Rubik_Lang or {}


PlayerInServerList = PlayerInServerList or {}
Ranks = Ranks or {}
Skins = Skins or {}

-- NetworkString Client
util.AddNetworkString("SendPlayerRanks") -- Send Ranks to a specific client - (Needed for creation panel)
util.AddNetworkString("SendPlayerSkins") -- Send skins to a specific client - (Needed for creation panel)
util.AddNetworkString("SendPlayerData") -- Send player's data to client - (User Data - Characters Data) - Will evolve in future update
util.AddNetworkString("SendPlayerRanksPanel") -- Send Ranks to a specific client and ask for the character panel to open
-- NetworkString Server
util.AddNetworkString("OpenRubikCharactersPanel") -- Ask for server to resend some date before opening the panel
util.AddNetworkString("RubikSpawnCharacter") -- Ask the server to spawn the character selected by the player


utf8_ansi2 = {}
utf8_ansi2["\\u00c0"] = "À"
utf8_ansi2["\\u00c1"] = "Á"
utf8_ansi2["\\u00c2"] = "Â"
utf8_ansi2["\\u00c3"] = "Ã"
utf8_ansi2["\\u00c4"] = "Ä"
utf8_ansi2["\\u00c5"] = "Å"
utf8_ansi2["\\u00c6"] = "Æ"
utf8_ansi2["\\u00c7"] = "Ç"
utf8_ansi2["\\u00c8"] = "È"
utf8_ansi2["\\u00c9"] = "É"
utf8_ansi2["\\u00ca"] = "Ê"
utf8_ansi2["\\u00cb"] = "Ë"
utf8_ansi2["\\u00cc"] = "Ì"
utf8_ansi2["\\u00cd"] = "Í"
utf8_ansi2["\\u00ce"] = "Î"
utf8_ansi2["\\u00cf"] = "Ï"
utf8_ansi2["\\u00d1"] = "Ñ"
utf8_ansi2["\\u00d2"] = "Ò"
utf8_ansi2["\\u00d3"] = "Ó"
utf8_ansi2["\\u00d4"] = "Ô"
utf8_ansi2["\\u00d5"] = "Õ"
utf8_ansi2["\\u00d6"] = "Ö"
utf8_ansi2["\\u00d8"] = "Ø"
utf8_ansi2["\\u00d9"] = "Ù"
utf8_ansi2["\\u00da"] = "Ú"
utf8_ansi2["\\u00db"] = "Û"
utf8_ansi2["\\u00dc"] = "Ü"
utf8_ansi2["\\u00dd"] = "Ý"
utf8_ansi2["\\u00df"] = "ß"
utf8_ansi2["\\u00e0"] = "à"
utf8_ansi2["\\u00e1"] = "á"
utf8_ansi2["\\u00e2"] = "â"
utf8_ansi2["\\u00e3"] = "ã"
utf8_ansi2["\\u00e4"] = "ä"
utf8_ansi2["\\u00e5"] = "å"
utf8_ansi2["\\u00e6"] = "æ"
utf8_ansi2["\\u00e7"] = "ç"
utf8_ansi2["\\u00e8"] = "è"
utf8_ansi2["\\u00e9"] = "é"
utf8_ansi2["\\u00ea"] = "ê"
utf8_ansi2["\\u00eb"] = "ë"
utf8_ansi2["\\u00ec"] = "ì"
utf8_ansi2["\\u00ed"] = "í"
utf8_ansi2["\\u00ee"] = "î"
utf8_ansi2["\\u00ef"] = "ï"
utf8_ansi2["\\u00f0"] = "ð"
utf8_ansi2["\\u00f1"] = "ñ"
utf8_ansi2["\\u00f2"] = "ò"
utf8_ansi2["\\u00f3"] = "ó"
utf8_ansi2["\\u00f4"] = "ô"
utf8_ansi2["\\u00f5"] = "õ"
utf8_ansi2["\\u00f6"] = "ö"
utf8_ansi2["\\u00f8"] = "ø"
utf8_ansi2["\\u00f9"] = "ù"
utf8_ansi2["\\u00fa"] = "ú"
utf8_ansi2["\\u00fb"] = "û"
utf8_ansi2["\\u00fc"] = "ü"
utf8_ansi2["\\u00fd"] = "ý"
utf8_ansi2["\\u00ff"] = "ÿ"
 

function convert_TextTo_utf8(text)
    for k,v in pairs(utf8_ansi2) do
        text = string.Replace(text, k, v)
    end
    return text
end 
 
-- Void - Network Sending
function GetAllRanks(ply,panel) -- This Function return a dictionnary of all ranks in the database - JSON
    // print(Rubik_Config.url .."/get/ranks.php?key=".. Rubik_Config.api_key)
    http.Fetch( Rubik_Config.url .."/get/ranks.php?key=".. Rubik_Config.api_key,
    function( body, len, headers, code )
        Ranks = util.JSONToTable(convert_TextTo_utf8(body)) or Ranks or {} 
        if (panel) then
            net.Start("SendPlayerRanksPanel")
        else
            net.Start("SendPlayerRanks")
        end
        net.WriteTable(Ranks)
        net.Send(ply)
        GetAllskins(ply)
    end,   
    function( error )  
            
    end, {  
    ["accept-encoding"] = "gzip, deflate",
    ["accept-language"] = "fr" 
    }
    )
end

-- Void - Network Sending
function GetAllskins(ply) -- This Function return a dictionnary of all skins in the database - JSON
    http.Fetch( Rubik_Config.url .."/get/skins.php?key=".. Rubik_Config.api_key,
    function( body, len, headers, code )
        Skins = util.JSONToTable(convert_TextTo_utf8(body)) or Skins or {} 
        net.Start("SendPlayerSkins")
        net.WriteTable(Ranks)
        net.Send(ply)
        GetAllskins(ply)
    end,   
    function( error )  
            
    end, {  
    ["accept-encoding"] = "gzip, deflate",
    ["accept-language"] = "fr" 
    }
    )
end


-- Void - Network Sending
function GetPlayerData(ply,panel) -- This Function return a dictionnary of the player data - JSON
    print(Rubik_Config.url .."/get/users.php?key=".. Rubik_Config.api_key.."&steamid="..ply:SteamID64())
    http.Fetch( Rubik_Config.url .."/get/users.php?key=".. Rubik_Config.api_key.."&steamid="..ply:SteamID64(),
    function( body, len, headers, code )
        PlayerInServerList[ply:SteamID64()] = util.JSONToTable(convert_TextTo_utf8(body)) or PlayerInServerList[ply:SteamID64()] or {}
        net.Start("SendPlayerData")
        net.WriteTable(PlayerInServerList[ply:SteamID64()])
        net.Send(ply)
        GetAllRanks(ply,panel)
        
    end,   
    function( error )  
        print(error)
            
    end, {  
    ["accept-encoding"] = "gzip, deflate",
    ["accept-language"] = "fr" 
    }
    )
end

-- Void - Network Sending
function PlayerSpawing(ply)
    if(serverUP) then
        PlayerInServerList[ply:SteamID64()] = PlayerInServerList[ply:SteamID64()] or {}
        initial = false
        if (next(PlayerInServerList[ply:SteamID64()]) == nil ) then
            initial = true
        end
        GetPlayerData(ply,initial)
    end
end


function PlayerCharacterPanelOpening(len,ply)
    GetPlayerData(ply,true)
end


function RubikSpawnCharacter(len,ply) 
    PlayerInServerList[ply:SteamID64()]["SelectedCharacter"] = net.ReadTable()
    // print(util.TableToJSON(PlayerInServerList[ply:SteamID64()]["SelectedCharacter"]["characters"][1]["ranks_format"], true))
    charName =  PlayerInServerList[ply:SteamID64()]["SelectedCharacter"]["characters"][1]["ranks_format"]
    charName =  string.Replace(charName,"$surname$",PlayerInServerList[ply:SteamID64()]["SelectedCharacter"]["characters"][1]["characters_surname"])
    charName =  string.Replace(charName,"$name$",PlayerInServerList[ply:SteamID64()]["SelectedCharacter"]["characters"][1]["characters_name"])
    ply:setDarkRPVar("rpname",charName)
    ply:setDarkRPVar("job",PlayerInServerList[ply:SteamID64()]["SelectedCharacter"]["characters"][1]["ranks_name"])
    ply:setDarkRPVar("money",PlayerInServerList[ply:SteamID64()]["SelectedCharacter"]["characters"][1]["money"])
    ply:SetMaxHealth(100+tonumber(PlayerInServerList[ply:SteamID64()]["SelectedCharacter"]["characters"][1]["perks_health"]))
    ply:SetMaxArmor(0+tonumber(PlayerInServerList[ply:SteamID64()]["SelectedCharacter"]["characters"][1]["perks_armor"]))
    ply:SetHealth(100+tonumber(PlayerInServerList[ply:SteamID64()]["SelectedCharacter"]["characters"][1]["perks_health"]))
    ply:SetArmor(0+tonumber(PlayerInServerList[ply:SteamID64()]["SelectedCharacter"]["characters"][1]["perks_armor"]))
end 









-- Checking if API Server is working ( We are sure that the server is running without major problems)
firstConnecion = true
serverUP = true -- we're assuming the server is up before checking it

hook.Add( "PlayerConnect", "JoinGlobalMessage", function( name, ip )
    if(firstConnecion) then
        // print(Rubik_Config.url .."/get/status.php?key=".. Rubik_Config.api_key)
        http.Fetch( Rubik_Config.url .."/get/status.php?key=".. Rubik_Config.api_key,
        function( body, len, headers, code )  
                print("HTTP Succes") 
                firstConnecion = false
                serverUP = true
        end,   
        function( error )
                print("HTTP Failed : "..error)  
                firstConnecion = false
                serverUP = false
        end, {  
        ["accept-encoding"] = "gzip, deflate",
        ["accept-language"] = "fr" 
        }
        )
    end
end )



hook.Add( "PlayerSpawn", "rubik_spawn", PlayerSpawing ) -- Called every time a player spawn, have to check if player data exist in order to know if it's intialspawn


net.Receive("OpenRubikCharactersPanel", PlayerCharacterPanelOpening)
net.Receive("RubikSpawnCharacter", RubikSpawnCharacter)
