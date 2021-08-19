client.notify("Pingspike on key by Teikumo")
local bindp = ui.add_key_bind("ping spike", "pkey", 0, 1)
local function main()
if bindp:is_active() then
       	
	ui.get_slider_int("misc_ping_spike_amount"):set_value(179)
	else
	ui.get_slider_int("misc_ping_spike_amount"):set_value(0)	
	end
end
client.register_callback("paint", main)

