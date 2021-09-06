Rubik_Config = Rubik_Config or {}
Rubik_Lang = Rubik_Lang or {}

PlayerData = PlayerData or {}
Ranks = Ranks or {}

-- Receive Function

function SendPlayerData()
    PlayerData = net.ReadTable()
    -- print(util.TableToJSON(PlayerData, true))
end

function SendPlayerRanks()
    Ranks = net.ReadTable()
end

function SendPlayerRanksOpenPanel()
    Ranks = net.ReadTable()
    OpenRubikCharactersPanel()
end


-- Send Function

function AskServerDataForSelectionPanel()
    net.Start("OpenRubikCharactersPanel")
    net.WriteTable(PlayerData)
    net.SendToServer()
end



-- Network Receive

net.Receive("SendPlayerRanks",SendPlayerRanks)
net.Receive("SendPlayerRanksPanel",SendPlayerRanksOpenPanel)
net.Receive("SendPlayerData",SendPlayerData)