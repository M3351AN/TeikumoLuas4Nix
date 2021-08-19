client.notify("Slowwalk breaker by Teikumo")
local a1 = 0
local a2 = 0
local speed = " "

function set_speed()

if engine.is_in_game() then
speed = {
	64,
	88,
	72,
	91
        }
        if a1 < globalvars.get_tick_count() then     
            a2 = a2 + 1
            if a2 > 4 then
                a2 = 0
            end
            ui.get_slider_int("antihit_extra_slowwalk_speed"):set_value(speed[a2])
            a1 = globalvars.get_tick_count() + 20
        end
    end
end


client.register_callback("paint", set_speed)