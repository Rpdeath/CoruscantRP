VictoriousConfig.Languages = {}
include("languages.lua")//loading languages

// ANY HELP NEEDED PLEASE CREATE A SUPPORT TICKET AND CONTACT ADMIRATION!
// true = yes false = no

// Theme color
VictoriousConfig.Theme = Color( 0,160,255 )

// Draw blur? ( blur may cause some frame rate drop, if you plan on removing the press key function it is advised to set this to false ) 
VictoriousConfig.DrawBlur = false

// Language selection
VictoriousConfig.Language = "english"
-- Easily add your own language in languages.lua

// Set side menu permenant
VictoriousConfig.SetMenuPermenant = false

// Compass is permenantly on screen?
VictoriousConfig.CompassPermenant = false

/*      PERMANENT MENU  
REMOVE LINE 347 "if input.IsKeyDown( VictoriousConfig.ProfileKey ) then" & LINE 576(5) "end"  TO MAKE THE MENU PERMANENT 
*/

// HEALTH BAR AT TOP?
VictoriousConfig.HealthBar = true

// Position of the menu
VictoriousConfig.XPosition = ScrW() - 420
VictoriousConfig.YPosition = 150

--		Position Guides 
-- XPosition = Left or Right 
-- YPosition = Up or Down
-- If you want the menu on the lower part of screen use YPosition = ScrH() - XXX 
-- Below are some pre made values for your desired location

// Max Health

VictoriousConfig.MaxHealthClass = {}
VictoriousConfig.MaxHealthClass["Citizen"] = { Max = 100 }
VictoriousConfig.MaxHealthClass["Test"] = { Max = 300 }
-- Copy the above code to enter your custom maxhealth value for your classname example "Citizen"
-- VictoriousConfig.MaxHealthClass["classname"] = { Max = 600 }

/*
			RIGHT SIDE
Top Right Values( Original values )
VictoriousConfig.XPosition = ScrW() - 420
VictoriousConfig.YPosition = 150

Bottom Right Values 
VictoriousConfig.XPosition = ScrW() - 420
VictoriousConfig.YPosition = ScrH() - 360 

-----------------------------------
			LEFT SIDE
Top Left Values 
VictoriousConfig.XPosition = 20
VictoriousConfig.YPosition = 150 

Bottom Left Values 
VictoriousConfig.XPosition = 20
VictoriousConfig.YPosition = ScrH() - 360 

*/

// Requires key "G" to open compass -- IMPORTANT -- // Set VictoriousConfig.CompassPermenant to false if you want to use key to open compass!! //
VictoriousConfig.CompassUseKey = true 
VictoriousConfig.CompassKey = KEY_G
-- For other keys: http://wiki.garrysmod.com/page/Enums/KEY

// Key used to open player menu. 
VictoriousConfig.ProfileKey = KEY_LALT
-- For other keys: http://wiki.garrysmod.com/page/Enums/KEY

// Show health amount above health bar?
VictoriousConfig.HealthNumbers = false

// Using level system?
VictoriousConfig.LevelSystem = false
VictoriousConfig.ShowExperiencePercent = false
-- Free level addon already supported: https://github.com/vrondakis/Leveling-System
-- If you need your own level system supported create a ticket.

// Show salary next to money?
VictoriousConfig.ShowSalary = true

// Show ammunition hud
VictoriousConfig.Ammunition = true
VictoriousConfig.Centered = true -- Ammunition hud is centered?

// Add custom ranks using the following template. VictoriousConfig.Ranks["ACTUAL RANK"] = "RANK NAME SHOWN!"
VictoriousConfig.Ranks = {}
VictoriousConfig.Ranks["Owner"] = "OWNER"
VictoriousConfig.Ranks["superadmin"] = "SUPER ADMIN"
VictoriousConfig.Ranks["HeadAdmin"] = "HEAD ADMIN"
VictoriousConfig.Ranks["Admin"] = "ADMIN"
VictoriousConfig.Ranks["Moderator"] = "MODERATOR"
VictoriousConfig.Ranks["Mod"] = "MOD"
VictoriousConfig.Ranks["TMod"] = "TRIAL MOD"
VictoriousConfig.Ranks["VIP"] = "ROYALTY"
