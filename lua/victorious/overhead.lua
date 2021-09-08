VictoriousConfig = {}
include("config.lua")

local PlayerRanks = VictoriousConfig.Ranks
 
local HPPulse = 0
local FadeLerp = 0
local plyMeta = FindMetaTable("Player")
local HealthsTeam = 100

PlayerInServerList = PlayerInServerList or {}
Skins = Skins or {}

plyMeta.drawPlayerInfo = function(self)  
    if not IsValid(self) then return end
	local pos = self:EyePos()	
	if(self:GetPos():Distance(LocalPlayer():GetPos()) <= 150) then	

		pos.z = pos.z + 1
		pos = pos:ToScreen()
		NamePos = pos.y - 65
		License = pos.y - 40
		
		if not self:getDarkRPVar("wanted") then      
			pos.y = pos.y - 1
		end

		local HealthsTable = VictoriousConfig.MaxHealthClass[team.GetName(self:Team())]
		if HealthsTable then
	        HealthsTeam = HealthsTable.Max
	   	else
	   		HealthsTeam = 100
	    end	

		local Health = self:Health()

		if Health > HealthsTeam then Health = HealthsTeam end
		if Health < 0 then Health = 0 end

		if Health < 16 then	
			HPPulse = 255 * math.sin( CurTime() * 4 )
		else
			HPPulse = math.Clamp( HPPulse - 255, 255, 255) 											
		end 				
			
		if GAMEMODE.Config.showname then
			displayname = self:getDarkRPVar("rpname")
			local nick = displayname
			local Ranked = PlayerRanks[self:GetNWString("usergroup", "")]

			// surface.SetDrawColor( 0, 0, 0, 40 * FadeLerp ) 
			// surface.DrawRect( pos.x - 70, pos.y - 70, 140, 4 )
			// surface.SetDrawColor( 200, 200, 200, FadeLerp* HPPulse ) 
			// surface.DrawRect( pos.x - 70, pos.y - 70, 140 * Health / HealthsTeam, 4 )				
			// surface.SetDrawColor( 255, 255, 255, 35 * FadeLerp ) 
			// surface.DrawRect( pos.x - 72, pos.y - 72, 1, 8 )	
			// surface.DrawRect( pos.x - 72, pos.y - 72, 143, 1 )			
			// surface.DrawRect( pos.x - 72, pos.y - 65, 143, 1 )					
			// surface.DrawRect( pos.x + 71, pos.y - 72, 1, 8 )					
			// surface.DrawRect( pos.x - 72, pos.y - 63, 45, 2 )
			// surface.DrawRect( pos.x - 72, pos.y - 63, 20, 3 )			
			// surface.DrawRect( pos.x + 27, pos.y - 63, 45, 2 )	
			// surface.DrawRect( pos.x + 52, pos.y - 63, 20, 3 )				
					
			
			if (self:GetPos():Distance(LocalPlayer():GetPos()) <= 500) then

				// print(self:GetBonePosition(self:LookupBone( "ValveBiped.Bip01_Head1" )))
			
				// Name Display
			draw.DrawText( string.upper(self:Nick()), "NumberFont", pos.x + 100, pos.y - 130, Color( 255, 255, 255, FadeLerp* 255 ), TEXT_ALIGN_CENTER)	
			surface.SetDrawColor( 200, 200, 200, 90  ) 	
			surface.DrawLine(pos.x, pos.y, pos.x + 100, pos.y - 100)	
			
			// Model Display
			ModelOnPlayer  = "Apparence Inconnu"
			if (next(Skins) != nil) then
				for k,v in pairs(Skins) do
					if self:GetModel() == v["skins_model"] then
						ModelOnPlayer  = v["skins_name"]
					end
				end
			end

			draw.DrawText( ModelOnPlayer, "NumberFont", pos.x + 200, pos.y + 30, Color( 255, 255, 255, FadeLerp* 255 ), TEXT_ALIGN_CENTER)	
			surface.SetDrawColor( 200, 200, 200, 90  ) 	
			surface.DrawLine(pos.x, pos.y + 70, pos.x + 200, pos.y + 60)
			
			
			

			// if PlayerRanks[self:GetNWString("usergroup", "")] then
			// 	NamePos = pos.y + 100			
			// 	draw.DrawText( Ranked, "NumberFont", pos.x, pos.y - 63, Color( 255, 155, 0, FadeLerp* 255 ), TEXT_ALIGN_CENTER )		
			// end					
				
			if GAMEMODE.Config.showjob then
				local teamname = self:getDarkRPVar("job") or team.GetName(self:Team())
					// draw.DrawText( string.upper(teamname),"NumberFont", pos.x, NamePos, Color( 200, 200, 200, FadeLerp* 255 ), TEXT_ALIGN_CENTER)      
				end		
			end			
			
			if (self:GetPos():Distance(LocalPlayer():GetPos()) <= 500) then
				FadeLerp = Lerp( FrameTime()* 10, FadeLerp, 1)		
			else
				FadeLerp = Lerp( FrameTime()* 10, FadeLerp, 0)	
			end	
			
			
		end
	end

end

plyMeta.drawWantedInfo = plyMeta.drawWantedInfo or function(self)
	if not self:Alive() then return end
    if(self:GetPos():Distance(LocalPlayer():GetPos()) <= 300) then
		local pos = self:EyePos()
		pos.z = pos.z + 1
		pos = pos:ToScreen()
		draw.DrawText( "WANTED", "NumberFont", pos.x, pos.y - 43, Color( 255, 255, 255, 255 ), TEXT_ALIGN_CENTER)	
		
	end
end