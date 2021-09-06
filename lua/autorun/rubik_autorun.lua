-- Made By RpdeathFR 
print("Rubik Autorun launched") 
AddCSLuaFile("rubikrp_code/client/cl_rubik.lua")
AddCSLuaFile("rubikrp_code/client/cl_font.lua")
AddCSLuaFile("rubikrp_code/client/cl_rubik_panel_charselection.lua")
AddCSLuaFile("rubikrp_code/client/cl_rubik_hud.lua")
AddCSLuaFile("rubikrp_code/client/cl_rubik_network.lua")
AddCSLuaFile("rubikrp_code/shared/sh_config.lua")
AddCSLuaFile("rubikrp_code/shared/sh_lang.lua")
 

include("rubikrp_code/shared/sh_config.lua")
include("rubikrp_code/shared/sh_lang.lua") 

if CLIENT then
    include("rubikrp_code/client/cl_rubik.lua")
    include("rubikrp_code/client/cl_font.lua")
    include("rubikrp_code/client/cl_rubik_network.lua")
    include("rubikrp_code/client/cl_rubik_panel_charselection.lua")
    include("rubikrp_code/client/cl_rubik_hud.lua")
    print("Rubik Client Loaded")
end


if SERVER then
    include("rubikrp_code/server/sv_rubik.lua")
    print("Rubik Server Loaded")
end
  
           