
if SERVER then
	resource.AddFile( "icons/bullet.png" )	
	resource.AddFile( "icons/arrow.png" )
	resource.AddFile( "icons/hunger.png" )
	resource.AddFile( "icons/health.png" )
	resource.AddFile( "icons/rank.png" )
	resource.AddFile( "icons/clip.png" )
	resource.AddFile( "icons/shield.png" )
	resource.AddFile( "icons/shielddegrade.png" )
	resource.AddFile( "icons/angle.png" )
	resource.AddFile( "icons/angler.png" )
	resource.AddFile( "icons/handcuffs.png" )	
	resource.AddFile( "icons/lock.png" )

	resource.AddWorkshop( "1242083101" )	

	AddCSLuaFile("victorious/victorious.lua")
	AddCSLuaFile("victorious/config.lua")
	AddCSLuaFile("victorious/overhead.lua")
	AddCSLuaFile("victorious/languages.lua")	
else
	include("victorious/victorious.lua")
end