Rubik_Config = Rubik_Config or {}
Rubik_Lang = Rubik_Lang or {}


PlayerInServerList = PlayerInServerList or {}
Ranks = Ranks or {}

-- NetworkString Client
util.AddNetworkString("SendPlayerRanks") -- Send Ranks to a specific client - (Needed for creation panel)
util.AddNetworkString("SendPlayerData") -- Send player's data to client - (User Data - Characters Data) - Will evolve in future update
util.AddNetworkString("SendPlayerRanksPanel") -- Send Ranks to a specific client and ask for the character panel to open
-- NetworkString Server
util.AddNetworkString("OpenRubikCharactersPanel") -- Ask for server t resend some date before opening the panel


-- Void - Network Sending
function GetAllRanks(ply,panel) -- This Function return a dictionnary of all ranks in the database - JSON
    print(Rubik_Config.url .."/get/ranks.php?key=".. Rubik_Config.api_key)
    http.Fetch( Rubik_Config.url .."/get/ranks.php?key=".. Rubik_Config.api_key,
    function( body, len, headers, code )
        Ranks = util.JSONToTable(body) or Ranks or {} 
        if (panel) then
            net.Start("SendPlayerRanksPanel")
        else
            net.Start("SendPlayerRanks")
        end
        net.WriteTable(Ranks)
        net.Send(ply)
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
        PlayerInServerList[ply:SteamID64()] = util.JSONToTable(body) or PlayerInServerList[ply:SteamID64()] or {}
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

        
        GetPlayerData(ply,false)

        
        
    end



end


function PlayerCharacterPanelOpening(len,ply)
    
    GetPlayerData(ply,true)


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