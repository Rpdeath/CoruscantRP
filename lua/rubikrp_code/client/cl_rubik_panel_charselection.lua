Rubik_Config = Rubik_Config or {}
Rubik_Lang = Rubik_Lang or {}

PlayerData = PlayerData or {}
Ranks = Ranks or {}

RanksToShow = RanksToShow or {}

RubikCharacterPanelHome = RubikCharacterPanelHome or nil

ScreenW = ScrW()
ScreenH = ScrH()

RubikCharPanelOpen1 = false
RubikCharPanelOpen2 = false

RubikCharacterPanelCharacterList = RubikCharacterPanelCharacterList or {}
RubikCharacterPanelCharacterList["background"] = {}
RubikCharacterPanelCharacterList["model"] = {}
  
function OpenRubikCharactersPanel()
    
    
    ScreenW = ScrW()
    ScreenH = ScrH()

    local frame = vgui.Create("DFrame")
    frame:SetSize(ScreenW,ScreenH)
	frame:Center()
	frame:SetVisible(true)
	frame:SetTitle("")
    frame:MakePopup()
    frame:SetDraggable(false) 
	frame.Paint = function(s,w,h)
    
    end 
    frame:ShowCloseButton(false)
    frame.Onclose = function() 
        RubikCharPanelOpen1 = false
        RubikCharPanelOpen2 = false
        
    end

    RubikCharacterPanelHome = frame 


    local background = vgui.Create( "DImage", frame )
	background:SetPos( 0, 0 )
	background:SetSize( ScreenW, ScreenH )
    background:SetImage( "rubik/all/background.png" )
    background:SetZPos( -10 )

    local html = vgui.Create("DHTML", frame)
    html:SetSize(ScreenW,ScreenH)
    html:Center()
    // html:OpenURL("http://rubik.rpdeath.com/website/gamelogin.php?steamid="..PlayerData["users"]["users_steamid_64"].."&secret="..PlayerData["users"]["users_api_key"])
    // html:OpenURL("http://rubik.rpdeath.com/ingame/characterCreationP1.php")
    html:OpenURL("http://coruscant.aperoyoutube.fr/ingame/index.php?steamid="..PlayerData["users"]["users_steamid_64"].."&secret="..PlayerData["users"]["users_api_key"])
    
     
    html:SetAllowLua(true)
    
    // Add JS callback fonctions here
    html.OnBeginLoadingDocument = function()
        html:AddFunction("rubik", "close", function()
            RubikCharPanelOpen2 = false
            RubikCharPanelOpen1 = false
            RubikCharacterPanelHome:Close()
        end) 
        html:AddFunction("rubik", "changeBackground", function(nb)
            
            if (nb=="1") then background:SetImage("rubik/Char_Creation/background.png")
            elseif (nb=="2") then background:SetImage("rubik/all/background.png")
            end 
        end)  
        html:AddFunction("rubik", "animationStarted", function()
            RubikCharacterPanelHome:SetKeyBoardInputEnabled(false)
            RubikCharacterPanelHome:SetMouseInputEnabled(false)
        end) 
        html:AddFunction("rubik", "animationEnded", function()
            RubikCharacterPanelHome:SetKeyBoardInputEnabled(true)
            RubikCharacterPanelHome:SetMouseInputEnabled(true)
        end)
    
        html:AddFunction("rubik", "SelectChar", function(charid)
            print(charid)

            
            
        end)
    end
 // end of JS callback functions

    html:SetZPos( -10 )
    
    
    RubikCharacterPanelHtml = html
    
    local quit = vgui.Create( "DImageButton", frame )
    quit:SetPos(ScreenW-252/3,10)
    quit:SetSize(252/4,93/4)
    quit:SetImage( "rubik/characterpanel/all/close_pressed.png" )
    quit.OnDepressed = function()
        RubikCharPanelOpen2 = false
        RubikCharPanelOpen1 = false
        RubikCharacterPanelHome:Close()
    end
    quit:SetZPos( 10 )


    RubikCharPanelOpen2 = true
end
    




hook.Add("HUDPaint", "identification_system", function()

    if(!RubikCharPanelOpen1) then
        -- Opening the panel by pressing a specific Key
        if (input.IsKeyDown(Rubik_Config["KeyOpenWebSite"])) then

            AskServerDataForSelectionPanel()
            RubikCharPanelOpen1 = true

        end
    else
        
    end


   



end)











-- Testing


    -- RanksToShow = util.JSONToTable(jobslist)
    -- nbJobs = table.getn(RanksToShow)
    -- startposX = ((ScreenW/100)*50) - ((ScreenW/100)*5)*(nbJobs/2) - (nbJobs*50)
    -- for k,v in pairs(RanksToShow) do

    -- jobData = {} 
    -- for k2,v2 in pairs(Ranks) do

    --     if(v2["ranks"]["ranks_id"]==""..v["ranks_id"])then 
    --         jobData = v2
    --     end
    -- end
    -- print("JobData : ")
    -- print(util.TableToJSON(jobData,true))
    -- print(" ")


    -- local charmodel = vgui.Create( "DModelPanel", frame )
    -- charmodel:SetPos( startposX + (k*50) + k*((ScreenW/100)*5) + 5, (ScreenH/100) * 85 +5 )
    -- charmodel:SetSize(  (ScreenW/100)*5 - 15, (ScreenW/100)*5 - 15 )
    -- charmodel:SetModel(jobData["skins"][1]["skins_model"])
    -- charmodel:SetAnimated(true)
    -- local yaw = 0  
    -- function charmodel:LayoutEntity( Entity ) return  end
    -- local eyepos = charmodel.Entity:GetBonePosition(charmodel.Entity:LookupBone("ValveBiped.Bip01_Head1"))
    -- eyepos:Add(Vector(15, 0, 2))	-- Move up slightly
    -- charmodel:SetLookAt(eyepos)
    -- -- charmodel.Entity:SetSequence( 2 )
    -- charmodel:SetCamPos(eyepos-Vector(-1, 0, 0))
    -- charmodel.Entity:SetEyeTarget(eyepos-Vector(-20, 0, 0))
    -- charmodel:SetZPos( 2 )


    -- local backgroundJob = vgui.Create( "DImageButton", frame )
    -- backgroundJob:SetPos( startposX + (k*50) + k*((ScreenW/100)*5), (ScreenH/100) * 85 )
    -- backgroundJob:SetSize( (ScreenW/100)*5, (ScreenW/100)*5 )
    -- backgroundJob:SetImage( "rubik/Char_Creation/Phase_2/Slot_classe.png" )
    -- backgroundJob:SetZPos( 1 )
    -- backgroundJob.OnDepressed = function()
        
    -- end