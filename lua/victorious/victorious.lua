VictoriousConfig = {}

SelectedChar = SelectedChar or {}
Skins = Skins or {}
include("config.lua")
include("languages.lua")
include("overhead.lua")

surface.CreateFont("CompassFont", {font = "BF4 Numbers", size = 16, weight = 200, extended = true})
surface.CreateFont("CompassFontL", {font = "BF4 Numbers", size = 20, weight = 200, extended = true})
surface.CreateFont("NumberFont", {font = "BF4 Numbers", size = 22, weight = 400, extended = true})
surface.CreateFont("WeaponFont", {font = "BF4 Numbers", size = 28, weight = 400, extended = true})
surface.CreateFont("PlayerMenu", {font = "BF4 Numbers", size = 32, weight = 400, extended = true})
surface.CreateFont("WeaponNumber", {font = "BF4 Numbers", size = 42, weight = 600, extended = true})

local Bullet = Material("icons/bullet.png")
local Arrow = Material("icons/arrow.png")
local Hungry = Material("icons/hunger.png")
local Heart = Material("icons/health.png")
local Rank = Material("icons/rank.png")
local Clip = Material("icons/clip.png")
local Shield = Material("icons/shield.png")
local ShieldDegrade = Material("shielddegrade.png")
local AngleL = Material("icons/angle.png")
local AngleR = Material("icons/angler.png")
local Star = Material("icons/handcuffs.png")
local Lock = Material("icons/lock.png")
local blur = Material( "pp/blurscreen" )
local ShieldPercentage = Material("icons/shield.png") 
local ply = LocalPlayer()
local keyfix = VictoriousConfig.ProfileKey


local function getPlayerTime(ply)
	if ulx ~= nil and ply:GetNWInt( "TotalUTime", -1 ) ~= -1 then
		return math.floor((ply:GetUTime() + CurTime() - ply:GetUTimeStart()))
	else
		return ply:GetNWInt( "Time_Fixed" ) + (CurTime() - ply:GetNWInt( "Time_Join" ))
	end
end

local function getPhrase(id, ...)
	local langtabl = VictoriousConfig.Languages[VictoriousConfig.Language]
	if langtabl then
		if langtabl[id] then
			return string.format(langtabl[id], ...)
		end
	end
	return nil
end

local function drawBlur( x, y, w, h, layers, density, alpha )
	surface.SetDrawColor( 255, 255, 255, alpha )
	surface.SetMaterial( blur )

	for i = 1, layers do
		blur:SetFloat( "$blur", ( i / layers ) * density )
		blur:Recompute()

		render.UpdateScreenEffectTexture()
		render.SetScissorRect( x, y, x + w, y + h, true )
			surface.DrawTexturedRect( 0, 0, ScrW(), ScrH() )
		render.SetScissorRect( 0, 0, 0, 0, false )
	end
end

local nd = 0
local nti = 360 / 15
local noi = 18
local ComPos = ScrH()/2 + 220

local function DrawCompass()
 
    local lp = LocalPlayer()   
    local size = ScrW()* 0.5   
   
    if IsValid(lp) then
        local dir = EyeAngles().y - nd
       
        for i=0, nti - 1 do
            local ang = i * 15
           
            local dif = math.AngleDifference(ang, dir)
           
            local numofinst = noi
           
            local offang = ( numofinst*12 )/2.8
			
            if math.abs(dif) < offang then
                local alpha = math.Clamp( 0.8-(math.abs(dif)/(offang)) , 0, 1 ) * 255            
               
                local dif2 = size / noi
               
                local pos = dif/15 * dif2
               
                local text = tostring(360 - ang)
               
                local font = "CompassFont"
				local directionfont = "CompassFontL"
               
                local clr = Color(170,170,170,alpha)
				local drt = Color(230,230,230,alpha)

                surface.SetDrawColor( VictoriousConfig.Theme )
                surface.SetMaterial( Arrow )
                surface.DrawTexturedRect( ScrW()/2 - 8, ComPos - 138, 16, 16 ) 
				
                if ang == 0 then
                    direction = "N"
					text = "0"
                    font = "CompassFont"
                    clr = Color(170,170,170,alpha)
					surface.SetDrawColor( VictoriousConfig.Theme.r, VictoriousConfig.Theme.g, VictoriousConfig.Theme.b, alpha ) 
					surface.DrawRect( ScrW()/2 - 25 - pos, ComPos - 100, 50, 3 )					
                elseif ang == 180 then
                    direction = "S"
                    font = "CompassFont"
                    clr = Color(170,170,170,alpha)
					surface.SetDrawColor( clr ) 
					surface.DrawRect( ScrW()/2 - 25 - pos, ComPos - 100, 50, 3 )
                elseif ang == 90 then
                    direction = "W"
                    font = "CompassFont"
                    clr = Color(170,170,170,alpha)
					surface.SetDrawColor( clr ) 
					surface.DrawRect( ScrW()/2 - 25 - pos, ComPos - 100, 50, 3 )					
                elseif ang == 270 then
                    direction = "E"
                    font = "CompassFont"
                    clr = Color(170,170,170,alpha)
					surface.SetDrawColor( clr ) 
					surface.DrawRect( ScrW()/2 - 25 - pos, ComPos - 100, 50, 3 )
                elseif ang == 45 then
                    direction = "NW"
                    font = "CompassFont"
                    clr = Color(170,170,170,alpha)
					surface.SetDrawColor( clr ) 
					surface.DrawRect( ScrW()/2 - 25 - pos, ComPos - 100, 50, 3 )
                elseif ang == 135 then
                    direction = "SW"
                    font = "CompassFont"
                    clr = Color(170,170,170,alpha)
					surface.SetDrawColor( clr ) 
					surface.DrawRect( ScrW()/2 - 25 - pos, ComPos - 100, 50, 3 )
                elseif ang == 225 then
                    direction = "SE"
                    font = "CompassFont"
                    clr = Color(170,170,170,alpha)
					surface.SetDrawColor( clr ) 
					surface.DrawRect( ScrW()/2 - 25 - pos, ComPos - 100, 50, 3 )
                elseif ang == 315 then
                    direction = "NE"
                    font = "CompassFont"
                    clr = Color(170,170,170,alpha)
					surface.SetDrawColor( clr ) 
					surface.DrawRect( ScrW()/2 - 25 - pos, ComPos - 100, 50, 3 )
                elseif ang == 15 then
					direction = ""
					surface.SetDrawColor( clr ) 
					surface.DrawRect( ScrW()/2 - 25 - pos, ComPos - 100, 50, 3 )
				elseif ang == 30 then
					direction = ""
					surface.SetDrawColor( clr ) 
					surface.DrawRect( ScrW()/2 - 25 - pos, ComPos - 100, 50, 3 )
                elseif ang == 60 then
					direction = ""
					surface.SetDrawColor( clr ) 
					surface.DrawRect( ScrW()/2 - 25 - pos, ComPos - 100, 50, 3 )
				elseif ang == 75 then
					direction = ""
					surface.SetDrawColor( clr ) 
					surface.DrawRect( ScrW()/2 - 25 - pos, ComPos - 100, 50, 3 )
                elseif ang == 105 then
					direction = ""
					surface.SetDrawColor( clr ) 
					surface.DrawRect( ScrW()/2 - 25 - pos, ComPos - 100, 50, 3 )
                elseif ang == 120 then
					direction = ""	
					surface.SetDrawColor( clr ) 
					surface.DrawRect( ScrW()/2 - 25 - pos, ComPos - 100, 50, 3 )
				elseif ang == 150 then
					direction = ""
					surface.SetDrawColor( clr ) 
					surface.DrawRect( ScrW()/2 - 25 - pos, ComPos - 100, 50, 3 )
                elseif ang == 165 then
					direction = ""
					surface.SetDrawColor( clr ) 
					surface.DrawRect( ScrW()/2 - 25 - pos, ComPos - 100, 50, 3 )
                elseif ang == 195 then
					direction = ""
					surface.SetDrawColor( clr ) 
					surface.DrawRect( ScrW()/2 - 25 - pos, ComPos - 100, 50, 3 )
                elseif ang == 210 then
					direction = ""	
					surface.SetDrawColor( clr ) 
					surface.DrawRect( ScrW()/2 - 25 - pos, ComPos - 100, 50, 3 )
				elseif ang == 240 then
					direction = ""
					surface.SetDrawColor( clr ) 
					surface.DrawRect( ScrW()/2 - 25 - pos, ComPos - 100, 50, 3 )
                elseif ang == 255 then
					direction = ""
					surface.SetDrawColor( clr ) 
					surface.DrawRect( ScrW()/2 - 25 - pos, ComPos - 100, 50, 3 )
                elseif ang == 285 then
					direction = ""
					surface.SetDrawColor( clr ) 
					surface.DrawRect( ScrW()/2 - 25 - pos, ComPos - 100, 50, 3 )
                elseif ang == 300 then
					direction = ""
					surface.SetDrawColor( clr ) 
					surface.DrawRect( ScrW()/2 - 25 - pos, ComPos - 100, 50, 3 )
                elseif ang == 330 then
					direction = ""
					surface.SetDrawColor( clr ) 
					surface.DrawRect( ScrW()/2 - 25 - pos, ComPos - 100, 50, 3 )
                elseif ang == 345 then
					direction = ""											
					surface.SetDrawColor( clr ) 
					surface.DrawRect( ScrW()/2 - 25 - pos, ComPos - 100, 50, 3 )
                end
               
                draw.DrawText( text, font, ScrW()/2 - pos, ComPos - 85, clr, TEXT_ALIGN_CENTER )
                draw.DrawText( direction, directionfont, ScrW()/2 - pos, ComPos - 125, drt, TEXT_ALIGN_CENTER )            
				
            end          
        end  
    end
end

local x = ScrW()/2
local y = 100
local HealthLerp = 0
local AmmunitionLerp = 0
local ArmorLerp = 0
local wantedpos = ScrH()/2 - 250
local lockdownpos = ScrH()/2 - 250
local agendapos = ScrH()/2 - 325
local HealthTeam = 100

local function vPlayerMenu()

	lp = LocalPlayer()
    local Armor = LocalPlayer():Armor()	
    local Health = LocalPlayer():Health()

	local HealthTable = VictoriousConfig.MaxHealthClass[team.GetName(LocalPlayer():Team())]
	if HealthTable then
        HealthTeam = HealthTable.Max
   	else
   		HealthTeam = 100
    end

	if Health > HealthTeam then Health = HealthTeam end
	if Health < 0 then Health = 0 end

	HealthLerp = Lerp( FrameTime()* 7, HealthLerp, Health)
	ArmorLerp = Lerp( FrameTime()* 7, ArmorLerp, Armor) 

	local HealthSpeed = 2	
    local Hunger = 0        
    if not DarkRP.disabledDefaults["modules"]["hungermod"] then
       Hunger = math.floor(LocalPlayer():getDarkRPVar("Energy") or 0, 0, 100)
    end


	local HeartRate = 3
	local HeartPulse = 0
	if Health < 71 then Hear0tRate = 4 end
	if Health < 51 then HeartRate = 5 end
	if Health < 31 then HeartRate = 6 end
	if Health < 21 then HeartRate = 7 end	
	if HeartPulse then 
		HeartPulse = 255 * math.sin( CurTime() * HeartRate )		
	else
		HeartPulse = math.Clamp( HeartPulse - 255, 0, 255)		
	end 

	if VictoriousConfig.DrawBlur then	
		drawBlur( VictoriousConfig.XPosition, VictoriousConfig.YPosition, 400, 60, 10, 5, 55 )
	end
	
	surface.SetDrawColor( 0,0,0,70 )
	surface.DrawRect( VictoriousConfig.XPosition, VictoriousConfig.YPosition, 400, 60 )		
	surface.SetDrawColor( 245,245,245,HeartPulse )
	surface.SetMaterial( Heart )
	surface.DrawTexturedRect( VictoriousConfig.XPosition + 15, VictoriousConfig.YPosition + 13, 32, 32 )
	surface.SetDrawColor( 0,0,0,80 )
	surface.DrawRect( VictoriousConfig.XPosition + 60, VictoriousConfig.YPosition + 42, 320, 2 )			
	surface.SetDrawColor( 255,255,255 )
	surface.DrawRect( VictoriousConfig.XPosition + 60, VictoriousConfig.YPosition + 42, (320) *HealthLerp / 100, 2 )		
	draw.DrawText( getPhrase("Health"), "NumberFont", VictoriousConfig.XPosition + 60, VictoriousConfig.YPosition + 10, Color( 255,255,255 ), TEXT_ALIGN_LEFT )			
	draw.DrawText( LocalPlayer():Health(), "NumberFont", VictoriousConfig.XPosition + 200, VictoriousConfig.YPosition + 10, VictoriousConfig.Theme, TEXT_ALIGN_CENTER )

	if VictoriousConfig.DrawBlur then	
		drawBlur( VictoriousConfig.XPosition, VictoriousConfig.YPosition + 70, 400, 60, 10, 5, 55 )
	end
	
	surface.SetDrawColor( 0,0,0,70 )
	surface.DrawRect( VictoriousConfig.XPosition, VictoriousConfig.YPosition + 70, 400, 60 )		
	surface.SetDrawColor( 245,245,245,255 )
	surface.SetMaterial( ShieldPercentage )
	surface.DrawTexturedRect( VictoriousConfig.XPosition + 15, VictoriousConfig.YPosition + 83, 32, 32 )
	surface.SetDrawColor( 0,0,0,80 )
	surface.DrawRect( VictoriousConfig.XPosition + 60, VictoriousConfig.YPosition + 112, 320, 2 )		
	surface.SetDrawColor( 255,255,255 )
	surface.DrawRect( VictoriousConfig.XPosition + 60, VictoriousConfig.YPosition +  112, (320) * ArmorLerp / 100, 2 )	
	draw.DrawText( getPhrase("Armor"), "NumberFont", VictoriousConfig.XPosition + 60, VictoriousConfig.YPosition + 80, Color( 255,255,255 ), TEXT_ALIGN_LEFT )		
	draw.DrawText( Armor, "NumberFont", VictoriousConfig.XPosition + 200, VictoriousConfig.YPosition + 80, VictoriousConfig.Theme, TEXT_ALIGN_CENTER )	
	
	local Weapon = LocalPlayer():GetActiveWeapon()
	local ReloadPulse = 0
	local levelpos = VictoriousConfig.YPosition + 140
	local hungerpos = VictoriousConfig.YPosition + 140
	local moneypos = VictoriousConfig.YPosition + 210
	
	if IsValid(Weapon) then 
		local Magazine = Weapon:GetMaxClip1() or 0
		local Ammunition = Weapon:Clip1() or 0          		

		if Ammunition <= Magazine / 3 and Magazine > 0  then 
			ReloadPulse = 255 * math.sin( CurTime() * 3 )		
		else
			ReloadPulse = math.Clamp( ReloadPulse - 255, 0, 255)		
		end 
			
		Magazine = LocalPlayer():GetActiveWeapon():GetMaxClip1()        
	  
		/*local defaultwep = {
		"weapon_crowbar", "weapon_357", "weapon_ar2", "weapon_bugbait", "weapon_crossbow",
		"weapon_pistol", "weapon_rpg", "weapon_shotgun", "weapon_smg1", "weapon_slam", "gmod_tool",
		"gmod_camera", "weapon_stunstick", "weapon_frag", "weapon_physcannon", "weapon_physgun"
		} */
		   
		local AmmunitionType = Weapon:GetPrimaryAmmoType()           
		local Ammunitionx = VictoriousConfig.XPosition + 200
		
		if (AmmunitionType >= 0) then
			if (Ammunition != -1) then   
			
				local WeaponName = Weapon:GetPrintName()		           	 
				local AmmunitionCount = Ammunition; if( string.len( AmmunitionCount ) < 2 ) then AmmunitionCount = "0" .. AmmunitionCount; end
				local AmmunitionExtended = LocalPlayer():GetAmmoCount(AmmunitionType); if( string.len( AmmunitionExtended ) < 2 ) then AmmunitionExtended = "0" .. AmmunitionExtended; end				
				local WeaponNameLength = WeaponName ; if( string.len( Weapon:GetPrintName()) > 10) then Ammunitionx = ScrW() - 205 end 										
			
				if VictoriousConfig.DrawBlur then			
					drawBlur( VictoriousConfig.XPosition, VictoriousConfig.YPosition + 140, 400, 60, 10, 5, 55 )
				end
			
				surface.SetDrawColor( 0,0,0,70 )
				surface.DrawRect( VictoriousConfig.XPosition, VictoriousConfig.YPosition + 140, 400, 60 )					
				surface.SetDrawColor( 245,245,245,255 )
				surface.SetMaterial( Bullet )
				surface.DrawTexturedRect( VictoriousConfig.XPosition + 15, VictoriousConfig.YPosition + 155, 32, 32 )

				surface.SetDrawColor( 0,0,0,80 )
				surface.DrawRect( VictoriousConfig.XPosition + 60, VictoriousConfig.YPosition + 182, 320, 2 )				
				surface.SetDrawColor( 255,255,255 )
				surface.DrawRect( VictoriousConfig.XPosition + 60, VictoriousConfig.YPosition + 182, (320) * Ammunition / Magazine, 2 )
				draw.DrawText( WeaponName, "NumberFont", VictoriousConfig.XPosition + 60, VictoriousConfig.YPosition + 150, Color( 255,255,255 ), TEXT_ALIGN_LEFT )				
				draw.DrawText( Ammunition .. " | " .. AmmunitionExtended, "NumberFont", Ammunitionx, VictoriousConfig.YPosition + 150, VictoriousConfig.Theme, TEXT_ALIGN_CENTER )
				
				moneypos = VictoriousConfig.YPosition + 280
				levelpos = VictoriousConfig.YPosition + 210 
				hungerpos = VictoriousConfig.YPosition + 210
				
			end                            
		end	
	end

	if VictoriousConfig.LevelSystem then

		moneypos = VictoriousConfig.YPosition + 350	
		hungerpos = VictoriousConfig.YPosition + 350 -140
		
		local AmmunitionType = Weapon:GetPrimaryAmmoType() 
		if (AmmunitionType >= 0) then
			if (Ammunition != -1) then  
				moneypos = VictoriousConfig.YPosition + 420
				hungerpos = VictoriousConfig.YPosition + 420 - 140				
			end
		end

		
		local OldXP = 0
		local PlayerLevel = LocalPlayer():getDarkRPVar('level')
		local PlayerExperience = LocalPlayer():getDarkRPVar('xp')
		local percent = ((LocalPlayer():getDarkRPVar('xp') or 0)/(((10+(((PlayerLevel or 1)*((PlayerLevel or 1)+1)*90))))*LevelSystemConfiguration.XPMult))	
		local PlayerExperienceBar = Lerp(8*FrameTime(),OldXP,percent)
		OldXP = PlayerExperienceBar
		local PlayerExperienced = percent*100
		PlayerExperienced = math.Round(PlayerExperienced)
		PlayerExperienced = math.Clamp(PlayerExperienced, 0, 99)

		if VictoriousConfig.DrawBlur then		
			drawBlur( VictoriousConfig.XPosition, levelpos, 400, 60, 10, 5, 55 )
		end

		surface.SetDrawColor( 0,0,0,70 )
		surface.DrawRect( VictoriousConfig.XPosition, levelpos, 400, 60 )				
		surface.SetDrawColor( 245,245,245,255 )
		surface.SetMaterial( Rank )
		surface.DrawTexturedRect( VictoriousConfig.XPosition + 15, levelpos + 16, 32, 32 )
		surface.SetDrawColor( 0,0,0,80 )
		surface.DrawRect( VictoriousConfig.XPosition + 60, levelpos + 42, 320, 2 )			
		surface.SetDrawColor( VictoriousConfig.Theme )
		surface.DrawRect( VictoriousConfig.XPosition + 60, levelpos + 42, (320) * percent, 2 )		
		draw.DrawText( getPhrase("Level"), "NumberFont", VictoriousConfig.XPosition + 60, levelpos + 10, Color( 255,255,255 ), TEXT_ALIGN_LEFT )		
		draw.DrawText( PlayerLevel, "NumberFont", VictoriousConfig.XPosition + 120, levelpos + 10, VictoriousConfig.Theme, TEXT_ALIGN_LEFT )
		
		if VictoriousConfig.ShowExperiencePercent then 		
			draw.DrawText( PlayerExperienced.." %" , "NumberFont", VictoriousConfig.XPosition + 200, levelpos + 10, Color( 255,255,255 ), TEXT_ALIGN_CENTER )		
		end

	end

    if not DarkRP.disabledDefaults["modules"]["hungermod"] then 
	
		moneypos = VictoriousConfig.YPosition + 280
		
		local AmmunitionType = Weapon:GetPrimaryAmmoType() 
		if (AmmunitionType >= 0) then
			if (Ammunition != -1) then  
				moneypos = VictoriousConfig.YPosition + 350
			end
		end	

		if VictoriousConfig.LevelSystem then

			moneypos = 500

			if (AmmunitionType >= 0) then
				if (Ammunition != -1) then  
					moneypos = VictoriousConfig.YPosition + 420
				end
			end
			
		end	

		if VictoriousConfig.DrawBlur then		
			drawBlur( VictoriousConfig.XPosition, hungerpos, 400, 60, 10, 5, 55 )
		end

		surface.SetDrawColor( 0,0,0,70 )
		surface.DrawRect( VictoriousConfig.XPosition, hungerpos, 400, 60 )				
		surface.SetDrawColor( 245,245,245,255 )
		surface.SetMaterial( Hungry )
		surface.DrawTexturedRect( VictoriousConfig.XPosition + 15, hungerpos + 14, 32, 32 )
		surface.SetDrawColor( 0,0,0,80 )
		surface.DrawRect( VictoriousConfig.XPosition + 60, hungerpos + 42, 320, 2 )		
		surface.SetDrawColor( 255,255,255 )
		surface.DrawRect( VictoriousConfig.XPosition + 60, hungerpos + 42, (320) * Hunger/100, 2 )		
		draw.DrawText( getPhrase("Hunger"), "NumberFont", VictoriousConfig.XPosition + 60, hungerpos + 10, Color( 255,255,255 ), TEXT_ALIGN_LEFT )		
		draw.DrawText( Hunger .." %" , "NumberFont", VictoriousConfig.XPosition + 200, hungerpos + 10, VictoriousConfig.Theme, TEXT_ALIGN_CENTER )		

	end
	
	if VictoriousConfig.DrawBlur then
		drawBlur( VictoriousConfig.XPosition, moneypos, 400, 60, 10, 5, 55 )
	end

	surface.SetDrawColor( 0,0,0,70 )
	surface.DrawRect( VictoriousConfig.XPosition, moneypos, 400, 60 )
	surface.SetDrawColor( 255,255,255,30 )
	surface.DrawRect( VictoriousConfig.XPosition + 20, moneypos + 30, 320, 1 )		
	draw.DrawText( "Crédits", "NumberFont", VictoriousConfig.XPosition + 200, moneypos + 5, Color( 255,255,255 ), TEXT_ALIGN_CENTER )			
	draw.DrawText(LocalPlayer():getDarkRPVar("money"), "NumberFont", VictoriousConfig.XPosition + 200, moneypos + 33, VictoriousConfig.Theme, TEXT_ALIGN_CENTER )

	if VictoriousConfig.DrawBlur then
		drawBlur( VictoriousConfig.XPosition, moneypos - 70, 400, 60, 10, 5, 55 )	
	end

	surface.SetDrawColor( 0,0,0,70 )	
	surface.DrawRect( VictoriousConfig.XPosition, moneypos - 70, 400, 60 )
	surface.SetDrawColor( 255,255,255,30 )
	surface.DrawRect( VictoriousConfig.XPosition + 40, moneypos - 40, 320, 1 )
	draw.DrawText( "Occupation", "NumberFont", VictoriousConfig.XPosition + 200, moneypos - 65, Color( 255,255,255 ), TEXT_ALIGN_CENTER )		
	draw.DrawText( string.upper(LocalPlayer():getDarkRPVar("job")), "NumberFont", VictoriousConfig.XPosition + 200, moneypos - 38, Color( 255,255,255 ), TEXT_ALIGN_CENTER )
	
	
	surface.SetDrawColor( 0,0,0,70 )
	nblicence = table.getn(SelectedChar["licenses"])
	surface.DrawRect( VictoriousConfig.XPosition, moneypos + 70, 400, 60 + (nblicence-1)*40 )
	surface.SetDrawColor( 255,255,255,30 )
	surface.DrawRect( VictoriousConfig.XPosition + 40, moneypos + 70 + 30, 320, 1 )
	draw.DrawText( "Licences", "NumberFont", VictoriousConfig.XPosition + 200, moneypos + 75, Color( 255,255,255 ), TEXT_ALIGN_CENTER )
	for k,v in pairs(SelectedChar["licenses"]) do
		draw.DrawText( v["licenses_name"] , "NumberFont", VictoriousConfig.XPosition + 200,moneypos + 70 + 35 + (k-1)*30, Color( 255,255,255 ), TEXT_ALIGN_CENTER )	
	end

	
	



	
					

	surface.SetDrawColor( 255,255,255,30 )
	surface.DrawRect( VictoriousConfig.XPosition + 100, VictoriousConfig.YPosition - 17, 200, 1 )	
	surface.DrawRect( VictoriousConfig.XPosition - 10, VictoriousConfig.YPosition - 10, 15, 2 )
	surface.DrawRect( VictoriousConfig.XPosition - 10, moneypos + 70, 15, 2 )	
	draw.DrawText( getPhrase("Playermenu"), "PlayerMenu", VictoriousConfig.XPosition + 200, VictoriousConfig.YPosition - 50, Color( 255,255,255 ), TEXT_ALIGN_CENTER )

end

local function VictoriousMain()
	
	lp = LocalPlayer()
    local Armor = LocalPlayer():Armor()	
    local Health = LocalPlayer():Health()

	local HealthTable = VictoriousConfig.MaxHealthClass[team.GetName(LocalPlayer():Team())]
	if HealthTable then
        HealthTeam = HealthTable.Max
   	else
   		HealthTeam = 100
    end

	if Health > HealthTeam then Health = HealthTeam end
	if Health < 0 then Health = 0 end

	HealthLerp = Lerp( FrameTime()* 7, HealthLerp, Health)
	ArmorLerp = Lerp( FrameTime()* 7, ArmorLerp, Armor) 

	local HealthSpeed = 2	

    local Hunger = 0        
    if not DarkRP.disabledDefaults["modules"]["hungermod"] then
       Hunger = math.floor(LocalPlayer():getDarkRPVar("Energy") or 0, 0, 100)
    end

	if VictoriousConfig.HealthBar then	
		drawBlur( x - 220, y, 440, 16, 10, 5, 55 )
		surface.SetDrawColor( 0,0,0,50 ) 
		surface.DrawRect( x - 220, y, 440, 16 )
		surface.SetDrawColor( 250,250,250,190 ) 
		surface.DrawRect( x - 220, y, (441) * HealthLerp / HealthTeam, 16 )	
		surface.SetDrawColor( 250,250,250,20 ) 
		surface.DrawRect( x - 223, y - 3, 446, 1 )
		surface.DrawRect( x - 223, y + 18, 446, 1 )
		surface.DrawRect( x - 90, y - 3, 180, 1 )
		surface.DrawRect( x - 223, y + 22, 150, 2 )
		surface.DrawRect( x + 73, y + 22, 150, 2 )	
		surface.SetDrawColor( 250,250,250,75 ) 
		surface.DrawRect( x - 223, y - 2, 1, 20 )
		surface.DrawRect( x + 222, y - 2, 1, 20 )	
		surface.SetDrawColor( 250,250,250,30 )
		surface.DrawRect( x - 223, y + 22, 65, 4 )
		surface.DrawRect( x + 158, y + 22, 65, 4 )	
	end
	if VictoriousConfig.HealthNumbers then 

		draw.DrawText(( LocalPlayer():Health() ), "NumberFont", x , y - 28, Color(255,255,255), TEXT_ALIGN_CENTER)

		surface.SetDrawColor( 250,250,250,20 ) 
		surface.SetMaterial( AngleL )
		surface.DrawTexturedRect( x - 70, y - 40, 64,64 )		

		surface.SetDrawColor( 250,250,250,20 ) 
		surface.SetMaterial( AngleR )
		surface.DrawTexturedRect( x + 12, y - 40, 64,64 )

	end

    if LocalPlayer():getDarkRPVar("wanted") then      
	
		surface.SetDrawColor( 255,255,255,50 )
		surface.DrawRect( 20, wantedpos + 24, 10, 3 )	
		surface.DrawRect( 40, wantedpos + 24, 180, 1 )
		surface.DrawRect( 40, wantedpos + 25, 1, 4 )
		surface.DrawRect( 219, wantedpos + 25, 1, 4 )
		surface.DrawRect( 229, wantedpos + 24, 10, 3 )				
		drawBlur( 0, wantedpos + 32, 270, 16, 10, 5, 55 )	
		draw.DrawText( getPhrase("Wanted"), "NumberFont", 129, wantedpos + 28, Color( 255,255,255 ), TEXT_ALIGN_CENTER )

		surface.SetDrawColor( 245,245,245,255 )
		surface.SetMaterial( Star )
		surface.DrawTexturedRect( 87, wantedpos - 5, 24, 24 )		
		surface.SetDrawColor( 245,245,245,255 )
		surface.SetMaterial( Star )
		surface.DrawTexturedRect( 117, wantedpos - 5, 24, 24 )	
		surface.SetDrawColor( 245,245,245,255 )
		surface.SetMaterial( Star )
		surface.DrawTexturedRect( 147, wantedpos - 5, 24, 24 )

	end	

	if VictoriousConfig.HealthBar then	

		local ArmorPulse = 0
		local ShieldDegrade = 0
		local PulseAlpha = 50
		
		if Armor > 0 then			

		if Armor < 31 then PulseAlpha = 0 end
		
			if ArmorPulse then 
				ArmorPulse = PulseAlpha * math.sin( CurTime() * 2 )
				ShieldDegrade = 255 * math.sin( CurTime() * 4 )			
			else
				ArmorPulse = math.Clamp( ArmorPulse - 255, 0, 255)
				ShieldDegrade = math.Clamp( ShieldDegrade - 255, 0, 255)			
			end 		

			if Armor < 51 then
				surface.SetDrawColor( 255,255,255,ArmorPulse )
				surface.SetMaterial( Arrow )
				surface.DrawTexturedRect( x - 12, y + 54, 24, 24 )
			end 

			if Armor < 41 then ShieldPercentage = Material("icons/shielddegrade.png") end
			
			if Armor < 31 then
				PulseAlpha = 0		
				ShieldSpeed = 6			
				surface.SetDrawColor( VictoriousConfig.Theme.r,VictoriousConfig.Theme.g,VictoriousConfig.Theme.b, ShieldDegrade  )
				surface.SetMaterial( Arrow )
				surface.DrawTexturedRect( x - 12, y + 54, 24, 24 )				
			end
					
			surface.SetDrawColor( 245,245,245,255 )
			surface.SetMaterial( ShieldPercentage )
			surface.DrawTexturedRect( x - 14, y + 32, 28, 28 )
			
		end
		
	end
	if VictoriousConfig.SetMenuPermenant then
		vPlayerMenu()
	else 
		if input.IsKeyDown( keyfix ) then
			vPlayerMenu()
		end
	end

	local Weapon = LocalPlayer():GetActiveWeapon()
	local ReloadPulse = 0
	local Ammunitionpos = 55
	
	if IsValid(Weapon) then 
		local Magazine = Weapon:GetMaxClip1() or 0
		local Ammunition = Weapon:Clip1() or 0          		 
		
		Magazine = LocalPlayer():GetActiveWeapon():GetMaxClip1()        
	  
		/*local defaultwep = {
		"weapon_crowbar", "weapon_357", "weapon_ar2", "weapon_bugbait", "weapon_crossbow",
		"weapon_pistol", "weapon_rpg", "weapon_shotgun", "weapon_smg1", "weapon_slam", "gmod_tool",
		"gmod_camera", "weapon_stunstick", "weapon_frag", "weapon_physcannon", "weapon_physgun"
		} */
		   
		local AmmunitionType = Weapon:GetPrimaryAmmoType()           
		local Ammunitionx = ScrW() - 220
		AmmunitionLerp = Lerp( FrameTime()* 12, AmmunitionLerp, Ammunition)	
		if Ammunition <= Magazine / 3 and Magazine > 0  then 
			ReloadPulse = 255 * math.sin( CurTime() * 3 )		
		else
			ReloadPulse = math.Clamp( ReloadPulse - 255, 0, 255)		
		end		
		if (AmmunitionType >= 0) then
			if (Ammunition != -1) then   
			
				local WeaponName = Weapon:GetPrintName()		           	 
				local AmmunitionCount = Ammunition; if( string.len( AmmunitionCount ) < 2 ) then AmmunitionCount = "0" .. AmmunitionCount; end
				local AmmunitionExtended = LocalPlayer():GetAmmoCount(AmmunitionType); if( string.len( AmmunitionExtended ) < 2 ) then AmmunitionExtended = "0" .. AmmunitionExtended; end				
				local WeaponNameLength = WeaponName ; if( string.len( Weapon:GetPrintName()) > 10) then Ammunitionx = ScrW() - 205 end 										
					
				surface.SetDrawColor( 245,245,245,ReloadPulse )
				surface.SetMaterial( Clip )
				surface.DrawTexturedRect( x - 22, ScrH() / 2 + 30, 44, 44 )
				if VictoriousConfig.Ammunition then
				
					if VictoriousConfig.Centered then 
						Ammunitionpos = ScrW()/2 - 150
					end
					
					surface.SetDrawColor( 255,255,255,20 )
					surface.DrawRect( Ammunitionpos - 2, ScrH() - 97, 304, 1 )						
					surface.DrawRect( Ammunitionpos - 2, ScrH() - 108, 304, 1 )
					surface.DrawRect( Ammunitionpos - 2, ScrH() - 113, 100, 2 )
					surface.DrawRect( Ammunitionpos - 2, ScrH() - 113, 100, 2 )
					surface.DrawRect( Ammunitionpos + 202, ScrH() - 113, 100, 2 )
					surface.SetDrawColor( 255,255,255,30 )
					surface.DrawRect( Ammunitionpos - 2, ScrH() - 115, 50, 3 )
					surface.DrawRect( Ammunitionpos + 252, ScrH() - 115, 50, 3 )					
					surface.SetDrawColor( 0,0,0,55 )
					surface.DrawRect( Ammunitionpos, ScrH() - 105, 300, 6 )						
					surface.SetDrawColor( 255,255,255 )
					surface.DrawRect( Ammunitionpos, ScrH() - 105, (300)*AmmunitionLerp / Magazine, 6 )	
						
					draw.DrawText( WeaponName, "WeaponFont", Ammunitionpos + 150, ScrH() - 140, Color( 255,255,255 ), TEXT_ALIGN_CENTER )				
					draw.DrawText( Ammunition, "WeaponNumber", Ammunitionpos + 147, ScrH() - 100, VictoriousConfig.Theme, TEXT_ALIGN_RIGHT )
					draw.DrawText( AmmunitionExtended, "WeaponFont", Ammunitionpos + 155, ScrH() - 89, Color( 255,255,255,150 ), TEXT_ALIGN_LEFT )
				end	
			
			end                            
		end	
	end

	if VictoriousConfig.CompassUseKey then 
	
		if input.IsKeyDown( VictoriousConfig.CompassKey ) then
			DrawCompass()
		end	
		
	end
	
	if VictoriousConfig.CompassPermenant then 	
		if IsValid(Weapon) then 	
			local AmmunitionType = Weapon:GetPrimaryAmmoType() 	
			DrawCompass()
			ComPos = ScrH() - 50
			
			if (AmmunitionType >= 0) then
				if (Ammunition != -1) then  
					ComPos = ScrH() - 90
				end
			end		
		end
	end	
	
end
hook.Add("HUDPaint", "VictoriousMainHUD", VictoriousMain)

local function VictoriousAgenda()
 
	local agendaText
    local VicoriousAgendaHook = hook.Call("HUDShouldDraw", GAMEMODE, "VictoriousAgenda")

		if LocalPlayer():getDarkRPVar("wanted") then
			lockdownpos = ScrH()/2 - 175
		else 
			lockdownpos = ScrH()/2 - 250
		end
	
    if VicoriousAgendaHook then 
	
        local agenda = LocalPlayer():getAgendaTable()
        if not agenda then return end
	
		agendaText = agendaText or DarkRP.textWrap((LocalPlayer():getDarkRPVar("agenda") or getPhrase("Agenda")):gsub("//", "\n"):gsub("\\n", "\n"), "DarkRPHUD1", 150)    

		surface.SetDrawColor( 255,255,255,50 )
		surface.DrawRect( 20, agendapos + 24, 10, 3 )			
		surface.DrawRect( 40, agendapos + 24, 180, 1 )	
		surface.DrawRect( 40, agendapos + 25, 1, 4 )			
		surface.DrawRect( 219, agendapos + 25, 1, 4 )	
		surface.DrawRect( 229, agendapos + 24, 10, 3 )						
		drawBlur( 0, agendapos + 32, 270, 16, 10, 5, 55 )	
        draw.DrawNonParsedText( string.upper( agendaText ), "NumberFont", 129, agendapos + 28, Color( 255,255,255 ), TEXT_ALIGN_CENTER )
		draw.DrawText( string.upper( agenda.Title ), "NumberFont", 129, agendapos - 2, VictoriousConfig.Theme, TEXT_ALIGN_CENTER )	
		
    end
end
hook.Add( "HUDPaint", "VictoriousAgenda", VictoriousAgenda )

hook.Add("DarkRPVarChanged", "VictoriousAgenda", function(ply, var, _, new)
 
    if ply ~= LocalPlayer() then return end
    if var == "agenda" and new then
        agendaText = DarkRP.textWrap(new:gsub("//", "\n"):gsub("\\n", "\n"), "DarkRPHUD1", 500)
    else
        agendaText = nil
    end
 
end)  
hook.Add("HUDPaint", "AgendaChange", VictoriousAgendaChange)


local function VictoriousLockdown()

	local VictoriousLockdownHook = hook.Call("HUDShouldDraw", GAMEMODE, "VictoriousLockdown")
	
	if VictoriousLockdownHook then
	   
		if GetGlobalBool("DarkRP_LockDown") then

		
			surface.SetDrawColor( 255,255,255,50 )
			surface.DrawRect( 20, lockdownpos + 24, 10, 3 )			
			surface.DrawRect( 40, lockdownpos + 24, 180, 1 )	
			surface.DrawRect( 40, lockdownpos + 25, 1, 4 )			
			surface.DrawRect( 219, lockdownpos + 25, 1, 4 )	
			surface.DrawRect( 229, lockdownpos + 24, 10, 3 )							
			drawBlur( 0, lockdownpos + 32, 270, 16, 10, 5, 55 )	
			draw.DrawText( getPhrase("Lockdown"), "NumberFont", 129, lockdownpos + 28, Color( 255,255,255 ), TEXT_ALIGN_CENTER )
			
			surface.SetDrawColor( 245,245,245,255 )
			surface.SetMaterial( Lock )
			surface.DrawTexturedRect( 117, lockdownpos - 5, 24, 24 )
	 
		end
	
	end
   
end
hook.Add( "HUDPaint", "VictoriousLockdown", VictoriousLockdown )	

local Disable = {
 
    ["DarkRP_HUD"]              = false,
    ["DarkRP_EntityDisplay"]    = false,
    ["DarkRP_ZombieInfo"]       = false,
    ["DarkRP_LocalPlayerHUD"]   = true,
    ["DarkRP_Hungermod"]        = true,
    ["DarkRP_Agenda"]           = true,
    ["DarkRP_LockdownHUD"]      = true,
    ["CHudHealth"]              = true,
    ["CHudBattery"]             = true,
    ["CHudAmmo"]                = true,
    ["CHudSecondaryAmmo"]       = true,
 
}

local function Disabled( ele )
    if Disable[ ele ] then
        return false
    end
end
hook.Add( "HUDShouldDraw", "DisableHUD", Disabled )