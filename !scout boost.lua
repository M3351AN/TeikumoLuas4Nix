local ffi = require 'ffi'
client.notify("Scout boost by Teikumo")
ffi.cdef[[
    typedef uintptr_t (__thiscall* GetClientEntity_4242425_t)(void*, int);
]]

local ENTITY_LIST_POINTER = ffi.cast("void***", se.create_interface("client.dll", "VClientEntityList003")) or error("Failed to find VClientEntityList003!")
local GET_CLIENT_ENTITY_FN = ffi.cast("GetClientEntity_4242425_t", ENTITY_LIST_POINTER[0][3])

local ffi_helpers = {
    get_animstate_offset = function()
        return 14612
    end,

    get_entity_address = function(entity_index)
        local addr = GET_CLIENT_ENTITY_FN(ENTITY_LIST_POINTER, entity_index)
        return addr
    end
}

local function on_create_move(cmd) 
	local localplayer = entitylist.get_local_player()
	if not localplayer then return end
    ffi.cast("float*", ffi_helpers.get_entity_address(localplayer:get_index()) + 10100)[0] = 0
    --print('ya')
end

function scout_boost(cmd)  
    if switch then
        switch = false
    else
         switch = true
    end

    if switch then
        local antiaim_active_movement_type = ui.get_slider_int("rage_scout_hitchance"):set_value(min)
    else
        local antiaim_active_movement_type = ui.get_slider_int("rage_scout_hitchance"):set_value(74)
    end
end

local velocity = nil
local m_vecVelocity = {
    [0] = se.get_netvar("DT_BasePlayer", "m_vecVelocity[0]"),
    [1] = se.get_netvar("DT_BasePlayer", "m_vecVelocity[1]")
}

local function low_speed()
    local player = entitylist.get_entity_by_index(engine.get_local_player())
    
    if player then
        velocity = math.sqrt(player:get_prop_float(m_vecVelocity[0]) ^ 2 + player:get_prop_float(m_vecVelocity[1]) ^ 2)
    end

    if velocity ~= nil then
        if velocity > 15 then
	min=60
        else
	min=49
        end
    end
end

client.register_callback("paint", low_speed)
client.register_callback("create_move", on_create_move)
client.register_callback("create_move", scout_boost)


