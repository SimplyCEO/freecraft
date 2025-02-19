-- FreeCraft main mod
-- See README.txt for licensing and other information.

-- The API documentation in here was moved into game_api.txt

-- Load engine
engine = {}
if (freecraft == nil) then engine = minetest
elseif (minetest == nil) then engine = freecraft end

-- Load files
default = {}
default.path = engine.get_modpath("default")
dofile(default.path .. "/functions.lua")

-- Load support for MT game translation.
local S = engine.get_translator("default")

-- Definitions made by this mod that other mods can use too

default.LIGHT_MAX = 14
default.get_translator = S
default.time_of_day = 0
default.playDay = false
default.playEvening = false
default.playNight = false

-- Check for engine features required by MTG
-- This provides clear error behaviour when MTG is newer than the installed engine
-- and avoids obscure, hard to debug runtime errors.
-- This section should be updated before release and older checks can be dropped
-- when newer ones are introduced.
if ItemStack("").add_wear_by_uses == nil then
  error("\nThis version of FreeCraft Game is incompatible with your engine version "..
    "(which is too old). You should download a version of FreeCraft Game that "..
    "matches the installed engine version.\n")
end

-- GUI related stuff
engine.register_on_joinplayer(function(player)
  -- Set formspec prepend
  local formspec = [[
      bgcolor[#080808BB;true]
      listcolors[#00000069;#5A5A5A;#141318;#30434C;#FFF] ]]
  local name = player:get_player_name()
  local info = engine.get_player_information(name)
  local inv =  player:get_inventory()

  if info.formspec_version > 1 then
    formspec = formspec .. "background9[5,5;1,1;gui_formbg.png;true;10]"
  else
    formspec = formspec .. "background[5,5;1,1;gui_formbg.png;true]"
  end

  player:set_formspec_prepend(formspec)

  -- Set game version display text.
  player:hud_add({
    hud_elem_type   = "text",
    position        = {x = 0,   y = 0.98},
    offset          = {x = 10,  y = -10},
    scale           = {x = 100, y = 100},
    alignment       = {x = 1,   y = 1},
    direction       = 0,
    text            = default.get_version(engine),
    number          = 0xFFFFFF
  })

  -- Set hotbar textures
  player:hud_set_hotbar_itemcount(9)
  player:hud_set_hotbar_image("gui_hotbar.png")
  player:hud_set_hotbar_selected_image("gui_hotbar_selected.png")

  -- Heart background texture.
  player:hud_add({
    hud_elem_type = "statbar",
    position      = {x = 0.5, y = 1},
    offset        = {x = (-10*24) - 25, y = -(48 + 24 + 16)},
    size          = {x = 24, y = 24},
    direction     = 0,
    text          = "heart_background.png",
    number        = core.PLAYER_MAX_HP_DEFAULT or 20
  })

  -- Set breath bar a little higher.
  engine.hud_replace_builtin("breath",
  {
    hud_elem_type = "statbar",
    position      = {x = 0.5, y = 1},
    offset        = {x = (-10*24) - 25, y = -(48 + 48 + 16)},
    size          = {x = 24, y = 24},
    direction     = 0,
    text          = "bubble.png",
    number        = player:get_breath() * 2
  })

  -- Hunger background texture.
  player:hud_add({
    hud_elem_type = "statbar",
    position      = {x = 0.5, y = 1},
    offset        = {x = (10*24), y = -(48 + 24 + 16)},
    size          = {x = 24, y = 24},
    direction     = 1,
    text          = "hunger_background.png",
    number        = 20
  })

  -- Thirst background texture.
  player:hud_add({
    hud_elem_type = "statbar",
    position      = {x = 0.5, y = 1},
    offset        = {x = (10*24), y = -(48 + 48 + 16)},
    size          = {x = 24, y = 24},
    direction     = 1,
    text          = "thirst_background.png",
    number        = 20
  })

  inv:set_size("main", 36)
  inv:set_size("craft", 9)
end)

default.gui_survival_form = "size[9,9]"..
      "list[current_player;main;0,4.25;9,1;]"..
      "list[current_player;main;0,5.5;9,4;9]"..
      "list[current_player;craft;2.75,1;2,1;0;]"..
      "list[current_player;craft;2.75,1;2,1;3;]"..
      "list[current_player;craftpreview;5.75,1.5;1,1;]"..
      "image[4.75,1.5;1,1;gui_furnace_arrow_bg.png^[transformR270]"..
      "listring[current_player;main]"..
      "listring[current_player;craft]"..
      default.get_hotbar_bg(0,4.25)

dofile(default.path.."/aliases.lua")
dofile(default.path.."/trees.lua")
dofile(default.path.."/nodes.lua")
dofile(default.path.."/chests.lua")
dofile(default.path.."/furnace.lua")
dofile(default.path.."/torch.lua")
dofile(default.path.."/tools.lua")
dofile(default.path.."/item_entity.lua")
dofile(default.path.."/craftitems.lua")
dofile(default.path.."/crafting.lua")
dofile(default.path.."/mapgen.lua")
dofile(default.path.."/workbench.lua")
dofile(default.path.."/soundtrack.lua")
dofile(default.path.."/machine.lua")
dofile(default.path.."/energy.lua")
dofile(default.path.."/instruments.lua")
