Rubik_Config = Rubik_Config or {}
Rubik_Lang = Rubik_Lang or {}

PlayerData = PlayerData or {}
Ranks = Ranks or {}
Skins = Skins or {}
SelectedChar = SelectedChar or {}

-- Receive Function

function SendPlayerData()
    PlayerData = net.ReadTable()
end

function SendPlayerSkins()
    Skins = net.ReadTable()
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

function SpawnCharacter(char)
    net.Start("RubikSpawnCharacter")
    net.WriteTable(PlayerData)
    net.SendToServer()
end


-- Network Receive

net.Receive("SendPlayerRanks",SendPlayerRanks)
net.Receive("SendPlayerSkins",SendPlayerSkins)
net.Receive("SendPlayerRanksPanel",SendPlayerRanksOpenPanel)
net.Receive("SendPlayerData",SendPlayerData)