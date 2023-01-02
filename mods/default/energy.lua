-- default/energy.lua

-- Support for game translation
local S = default.get_translator

-- Register battery node
local function register_cable(nodetype)
    local name = ""
    local drop = ""
    local description = ""
    local tiles = {}
    local recipe = {}
    local groups = {energy = 1, cable = 1, cracky = 2, oddly_breakable_by_hand = 3}
    local sounds = default.node_sound_metal_defaults()
    local on_construct = function(pos)
                                  local timer = engine.get_node_timer(pos)
                                  timer:start(1)
    end
    local on_timer = function(pos, elapsed)
                              default.on_node_step(pos, elapsed, "cable", 1)
    end
    if (nodetype ~= nil) then
        local l_nodetype = string.lower(nodetype)
        name = "default:" .. l_nodetype .. "_" .. "cable"
        drop = name
        description = nodetype .. " Cable"
        tiles = { "default" .. "_" .. l_nodetype .. "_" .. "block.png" }
        local recipe_name = "default:" .. l_nodetype .. "_" .. "ingot"
        local x = recipe_name
        recipe = { {x, x, x}, }
    end
    local parameters = { description = description, tiles = tiles, groups = groups,
                         drop = drop, sounds = sounds, on_construct = on_construct,
                         on_timer = on_timer, recipe = recipe }
    local c_parameters = { output = name, recipe = recipe }
    engine.register_node(name, parameters)
    engine.register_craft(c_parameters)
end

-- Register battery node
local function register_battery(nodetype)
    local name = ""
    local drop = ""
    local description = ""
    local tiles = {}
    local recipe = {}
    local groups = {energy = 1, battery = 1, choppy = 2, oddly_breakable_by_hand = 2}
    local sounds = default.node_sound_wood_defaults()
    local on_construct = function(pos)
                                  local timer = engine.get_node_timer(pos)
                                  timer:start(1)
    end
    local on_timer = function(pos, elapsed)
                              default.on_node_step(pos, elapsed, "battery", 1)
    end
    if (nodetype ~= nil) then
        local l_nodetype = string.lower(nodetype)
        name = "default:" .. l_nodetype .. "_" .. "battery"
        drop = name
        description = nodetype .. " Battery"
        tiles = { l_nodetype .. "_" .. "battery_top.png",
                  l_nodetype .. "_" .. "battery_bottom.png",
                  l_nodetype .. "_" .. "battery_side.png" }
        local recipe_name = "default:" .. l_nodetype .. "_" .. "wood"
        local x = recipe_name
        recipe = { {x, "", x},
                   {x, "", x},
                {   x, x, x}, }
    else
        name = "default:battery"
        description = "Battery"
        tiles = { "battery_top.png",
                  "battery_bottom.png",
                  "battery_side.png" }
        local recipe_name = "default:wood"
        local x = recipe_name
        local i = "default:iron_ingot"
        local e = "default:mese_crystal"
        recipe = { {x, i, x},
                   {x, e, x},
                   {x, i, x}, }
    end
    local parameters = { description = description, tiles = tiles, groups = groups,
                         drop = drop, sounds = sounds, on_construct = on_construct,
                         on_timer = on_timer, recipe = recipe }
    local c_parameters = { output = name, recipe = recipe }
    local f_parameters = { type = "fuel", recipe = name, burntime = 4 }
    engine.register_node(name, parameters)
    engine.register_craft(c_parameters)
    engine.register_craft(f_parameters)
end

-- Register diode node
local function register_diode(nodetype)
    local name = ""
    local drop = ""
    local description = ""
    local tiles = {}
    local recipe = {}
    local groups = {energy = 1, diode = 1, oddly_breakable_by_hand = 3}
    local sounds = default.node_sound_defaults()
    local on_construct = function(pos)
                                  local timer = engine.get_node_timer(pos)
                                  timer:start(1)
    end
    local on_timer = function(pos, elapsed)
                              default.on_node_step(pos, elapsed, "diode", 1)
    end
    local on_place = engine.rotate_node
    local paramtype2 = "facedir"
	-- local is_ground_content = false
    name = "default:diode"
    description = "Diode"
    tiles = { "diode_top.png", "diode_bottom.png", "diode_side_inverted.png",
                "diode_side.png", "diode_back.png", "diode_front.png" }
    local x = "wool:black"
    local i = "default:iron_ingot"
    local c = "default:coal_lump"
    recipe = { {x, i, x},
               {x, c, x},
               {x, i, x}, }
    local parameters = { description = description, tiles = tiles, groups = groups,
                         drop = drop, sounds = sounds, on_construct = on_construct,
                         on_timer = on_timer, on_place = on_place, recipe = recipe,
                         paramtype2 = paramtype2 }
    local c_parameters = { output = name, recipe = recipe }
    local f_parameters = { type = "fuel", recipe = name, burntime = 4 }
    engine.register_node(name, parameters)
    engine.register_craft(c_parameters)
    engine.register_craft(f_parameters)
end

--
-- Register energy nodes
--

-- Cables
register_cable("Tin")
register_cable("Iron")
register_cable("Copper")
register_cable("Gold")
register_cable("Diamond")

-- Batteries
register_battery()
register_battery("Acacia")
register_battery("Aspen")
register_battery("Jungle")
register_battery("Pine")

-- Diode
register_diode()