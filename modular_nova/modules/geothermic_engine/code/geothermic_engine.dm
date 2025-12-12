//Will control filter setting, digital readout of the turbine health (think the sm health readout)
/obj/machinery/geothermal_turbine
	icon = 'modular_nova/modules/geothermic_engine/icons/geothermic_engine.dmi'
	icon_state = "core_off"
	name = "turbine core"
	desc = "The rotating turbine housing, where steam is converted to mechanical energy."
	density = TRUE
	resistance_flags = FIRE_PROOF
	can_atmos_pass = ATMOS_PASS_DENSITY
	processing_flags = START_PROCESSING_MANUALLY
	plane = GAME_PLANE
	interaction_flags_atom = INTERACT_ATOM_ATTACK_HAND | INTERACT_ATOM_UI_INTERACT
	armor_type = /datum/armor/unary_thermomachine
	layer = OBJ_LAYER
	move_resist = MOVE_RESIST_DEFAULT
	max_integrity = 600
	///The gas mix going through the turbine
	var/datum/gas_mixture/turbine_gasmix
	///The cooling gas mix
	var/datum/gas_mixture/cooling_gasmix
	///Amount of mechanical stress
	var/stress = 0
	///Maximum stress
	var/max_stress = 1000
	/// current input valve setting in liters per second
	var/input_valve_lps = 0
	///rate of gaz flow, function of (input_valve * (turbine_gasmix pressure - ouptut gasmix pressure)
	var/flow_rate = 0
	///current internal Filter Setting (0: filter not deployed, 100: filter fully deployed)
	var/filter = 0
	///current rpm
	var/rpm = 0
	///current condenser efficiency setting (0: minimum efficiency, 100: maximum efficiency)
	var/condenser_efficiency
	///How much coolant are we injecting into the mix
	var/coolant_flow = 0
	///Housing temperature
	var/housing_temperature = T20C
	///Housing heat capacity, tweak for inertia
	var/housing_heat_capacity = 5000
	/// how many process cycles has the turbine been overstressed for
	var/overstress_ticks = 0
	///ticks between overstressed leaks
	var/leak_interval = 10
	/// Internal radio.
	var/obj/item/radio/stored_radio
	/// The key our internal radio uses
	var/radio_key = /obj/item/encryptionkey/headset_eng
	/// Need null to actually broadcast to common. Stolen from supermatter code.
	///The radio channel where the warnings will be sent.
	var/warning_channel = RADIO_CHANNEL_ENGINEERING
	///ticks before pressing reminder
	var/reminder_interval = 60
	///ticks before final explosion
	var/explosion_interval = 120
	/// Boolean flag set when all parts are correctly assembled
	var/processing = FALSE
	/// References to child parts once assembled
	var/obj/machinery/atmospherics/components/unary/geothermal_turbine_inlet/inlet_port
	/// References to child parts once assembled
	var/obj/machinery/atmospherics/components/unary/geothermal_turbine_cooling_manifold/cool_manifold
	/// References to child parts once assembled
	var/obj/machinery/power/geothermal_turbine_generator/gen_module
	/// References to child parts once assembled
	var/obj/machinery/atmospherics/components/unary/geothermal_turbine_outlet/outlet_port
	/// Boolean flag set when coolant gas flow becomes unstable (high flow at low pressure), reducing cooling efficiency and adding stress.
	var/flow_instability = FALSE
	/// For how long have we been in a state of flow instability, to avoid radio spamming about it.
	var/flow_instability_ticks = 0


//Will contain settings for input_valve_lps, turny dial thing
/obj/machinery/atmospherics/components/unary/geothermal_turbine_inlet
	name = "turbine inlet port"
	desc = "Connects the turbine to an atmos pipe for intake."
	icon = 'modular_nova/modules/geothermic_engine/icons/geothermic_engine.dmi'
	icon_state = "inlet"
	pipe_color = COLOR_RED
	density = TRUE
	resistance_flags = FIRE_PROOF
	can_atmos_pass = ATMOS_PASS_DENSITY
	processing_flags = START_PROCESSING_MANUALLY
	plane = GAME_PLANE
	interaction_flags_atom = INTERACT_ATOM_ATTACK_HAND | INTERACT_ATOM_UI_INTERACT
	armor_type = /datum/armor/unary_thermomachine
	layer = OBJ_LAYER
	move_resist = MOVE_RESIST_DEFAULT
	vent_movement = NONE
	pipe_flags = PIPING_ONE_PER_TURF
	///The turbine this is connected to.
	var/obj/machinery/geothermal_turbine/parent_turbine

//will contain setting for condenser_efficiency, turny dial thing
/obj/machinery/atmospherics/components/unary/geothermal_turbine_outlet
	name = "turbine exhaust port"
	desc = "Connects the turbine to an atmos pipe for exhaust."
	icon = 'modular_nova/modules/geothermic_engine/icons/geothermic_engine.dmi'
	icon_state = "output"
	pipe_color = COLOR_BROWN
	density = TRUE
	resistance_flags = FIRE_PROOF
	can_atmos_pass = ATMOS_PASS_DENSITY
	processing_flags = START_PROCESSING_MANUALLY
	plane = GAME_PLANE
	interaction_flags_atom = INTERACT_ATOM_ATTACK_HAND | INTERACT_ATOM_UI_INTERACT
	armor_type = /datum/armor/unary_thermomachine
	layer = OBJ_LAYER
	move_resist = MOVE_RESIST_DEFAULT
	vent_movement = NONE
	pipe_flags = PIPING_ONE_PER_TURF
	///The turbine this is connected to.
	var/obj/machinery/geothermal_turbine/parent_turbine

/obj/machinery/atmospherics/components/unary/geothermal_turbine_inlet/Initialize()
	. = ..()
	if(dir == SOUTH)
		initialize_directions = EAST
	else if(dir == NORTH)
		initialize_directions = WEST
	else if(dir == EAST)
		initialize_directions = NORTH
	else if(dir == WEST)
		initialize_directions = SOUTH
	update_icon()


/obj/machinery/atmospherics/components/unary/geothermal_turbine_outlet/Initialize()
	. = ..()
	if(dir == SOUTH)
		initialize_directions = EAST
	else if(dir == NORTH)
		initialize_directions = WEST
	else if(dir == EAST)
		initialize_directions = NORTH
	else if(dir == WEST)
		initialize_directions = SOUTH
	update_icon()

//will output power (cable under it)
/obj/machinery/power/geothermal_turbine_generator
	name = "generator module"
	desc = "Converts turbine RPM into electrical power."
	icon = 'modular_nova/modules/geothermic_engine/icons/geothermic_engine.dmi'
	icon_state = "generator"
	density = TRUE
	resistance_flags = FIRE_PROOF
	can_atmos_pass = ATMOS_PASS_DENSITY
	processing_flags = START_PROCESSING_MANUALLY
	plane = GAME_PLANE
	interaction_flags_atom = INTERACT_ATOM_ATTACK_HAND | INTERACT_ATOM_UI_INTERACT
	armor_type = /datum/armor/unary_thermomachine
	layer = OBJ_LAYER
	move_resist = MOVE_RESIST_DEFAULT
	///The turbine this is connected to.
	var/obj/machinery/geothermal_turbine/parent_turbine
	///How much W per RPM this produces
	var/watt_per_rpm = 10

//will have the coolant_flow setting, turny dial thing.
/obj/machinery/atmospherics/components/unary/geothermal_turbine_cooling_manifold
	name = "Coolant Manifold"
	desc = "A dedicated manifold that regulates coolant circulation through the turbine housing. Engineers can adjust flow here to balance heat removal and prevent overheating. Its gauges display coolant temperature and pressure, making it the primary interface for thermal management."
	icon = 'modular_nova/modules/geothermic_engine/icons/geothermic_engine.dmi'
	icon_state = "cooling"
	pipe_color = COLOR_CYAN
	density = TRUE
	resistance_flags = FIRE_PROOF
	can_atmos_pass = ATMOS_PASS_DENSITY
	processing_flags = START_PROCESSING_MANUALLY
	plane = GAME_PLANE
	interaction_flags_atom = INTERACT_ATOM_ATTACK_HAND | INTERACT_ATOM_UI_INTERACT
	armor_type = /datum/armor/unary_thermomachine
	layer = OBJ_LAYER
	move_resist = MOVE_RESIST_DEFAULT
	vent_movement = NONE
	pipe_flags = PIPING_ONE_PER_TURF
	///The turbine this is connected to.
	var/obj/machinery/geothermal_turbine/parent_turbine

/obj/machinery/atmospherics/components/unary/geothermal_turbine_cooling_manifold/Initialize()
	. = ..()
	initialize_directions = dir
	update_icon()

/obj/machinery/geothermal_turbine/Initialize(mapload, gas_theoretical_volume)
	. = ..()

	turbine_gasmix = new
	turbine_gasmix.volume = gas_theoretical_volume
	cooling_gasmix = new
	cooling_gasmix.volume = gas_theoretical_volume

/obj/machinery/geothermal_turbine/process()
	if(!processing)
		return PROCESS_KILL

	// 1) Transfer gas from input pipe via inlet_port
	if(inlet_port && inlet_port.airs)
		var/datum/gas_mixture/input_mix = inlet_port.airs
		var/total_moles = input_mix.total_moles()
		if(total_moles > 0)
			var/moles_to_pull = input_valve_lps
			var/fraction = min(moles_to_pull / total_moles, 1)
			var/datum/gas_mixture/pulled_mix = input_mix.remove_ratio(fraction)
			turbine_gasmix.merge(pulled_mix)


  	  // 2) Filter mineral impurities
	if(turbine_gasmix)
		for(var/datum/gas/current_gas in turbine_gasmix.gases)
			if(istype(current_gas, /datum/gas/water_vapor/mineral_impurities))
				var/moles = turbine_gasmix.gases[current_gas]
				var/filter_fraction = clamp(filter / 100, 0, 1)
				turbine_gasmix.gases[current_gas] = moles * (1 - filter_fraction)

	// 3) Stress from non-water vapor gases
	for(var/datum/gas/current_gas in turbine_gasmix.gases)
		if(!istype(current_gas, /datum/gas/water_vapor))
			stress += round(turbine_gasmix.gases[current_gas] * 0.1)

	// 4) Calculate rpm from pressure delta
	var/input_pressure = turbine_gasmix?.return_pressure() || 0
	var/datum/gas_mixture/output_gasmix = outlet_port.return_air()
	var/output_pressure = output_gasmix.return_pressure()
	var/pressure_delta = max(input_pressure - output_pressure, 0)
	flow_rate = input_valve_lps * pressure_delta

	// Efficiency tradeoff: higher condenser efficiency cools exhaust more, reducing usable pressure
	var/efficiency_factor = clamp((100 - condenser_efficiency) / 100, 0.1, 1)
	// At 100% efficiency, rpm is reduced; at 0% efficiency, rpm is max
	rpm = flow_rate * efficiency_factor


	// 4b) Update icon depending on if the turbine is running or not
	var/new_state = (rpm > 0) ? "core_on" : "core_off"

	if(icon_state != new_state)
		icon_state = new_state
		update_icon()

	// 5) Stress from backpressure
	if(output_pressure > input_pressure)
		stress += round((output_pressure - input_pressure) * 0.5)

	// 6) Heat exchange: turbine gasmix <-> housing
	if(turbine_gasmix)
		var/gas_heat_capacity = turbine_gasmix.heat_capacity()
		if(gas_heat_capacity > 0)
			var/equilibrium = (housing_temperature * housing_heat_capacity + turbine_gasmix.temperature * gas_heat_capacity) / (housing_heat_capacity + gas_heat_capacity)
			housing_temperature = housing_temperature + 0.1 * (equilibrium - housing_temperature)
			turbine_gasmix.temperature = turbine_gasmix.temperature + 0.1 * (equilibrium - turbine_gasmix.temperature)

	// 7) Heat exchange: housing <-> coolant
	if(cooling_gasmix)
		var/coolant_heat_capacity = cooling_gasmix.heat_capacity()
		if(coolant_heat_capacity > 0)
			var/equilibrium = (housing_temperature * housing_heat_capacity + cooling_gasmix.temperature * coolant_heat_capacity) / (housing_heat_capacity + coolant_heat_capacity)
			housing_temperature = housing_temperature + 0.2 * (equilibrium - housing_temperature)
			cooling_gasmix.temperature = cooling_gasmix.temperature + 0.2 * (equilibrium - cooling_gasmix.temperature)

			// Consume coolant proportional to flow setting
			var/moles_to_consume = coolant_flow * 0.1
			var/total_moles = cooling_gasmix.total_moles()
			if(total_moles > 0)
				var/fraction = min(moles_to_consume / total_moles, 1)
				var/datum/gas_mixture/consumed = cooling_gasmix.remove_ratio(fraction)

				// Option: dump consumed coolant into exhaust stream
				turbine_gasmix.merge(consumed)


	// 8) Heat exchange: housing <-> turf environment
	var/turf/env = get_turf(src)
	if(env)
		var/env_heat_capacity = env.GetHeatCapacity()
		var/env_temp = env.GetTemperature()
		if(env_heat_capacity > 0)
			var/equilibrium = (housing_temperature * housing_heat_capacity + env_temp * env_heat_capacity) / (housing_heat_capacity + env_heat_capacity)
			var/temp_change = 0.05 * (equilibrium - housing_temperature)
			housing_temperature += temp_change
			env.TakeTemperature(-temp_change) // push opposite into turf

	// 9) Stress from housing temperature
	if(housing_temperature > 373.15)
		stress += round((housing_temperature - 373.15) * 0.2)

	// 10) Exhaust turbine_gasmix
	if(turbine_gasmix)
		if(outlet_port && outlet_port.airs)
			// Normal case: exhaust piped into outlet
			outlet_port.airs[1].merge(turbine_gasmix)
		else
			// No pipe: dump gasmix into turf atmosphere
			var/turf/exhaust_turf = get_step(src, turn(dir, -90))
			if(exhaust_turf)
				// Merge the gas mixture into the turf’s atmosphere
				exhaust_turf.assume_air(turbine_gasmix.copy())
		// Reset turbine gasmix
		turbine_gasmix = new /datum/gas_mixture()

	// 11) flow_instability check
	if(coolant_flow > 80 && input_pressure < 50)
		flow_instability = TRUE
		flow_instability_ticks++
		stress += 20
		if(flow_instability_ticks == 1)
			stored_radio.talk_into(src, "Warning: Coolant turbulence detected — flow efficiency compromised!", warning_channel)
	else if(flow_instability_ticks > 0)
		flow_instability_ticks = 0

	// Failure escalation
	if(stress > max_stress)
		overstress_ticks++

		// First time we cross threshold: announce on engineering radio
		if(overstress_ticks == 1)
			stored_radio.talk_into(src,"Warning: Geothermal turbine overstressed. Immediate intervention required!", warning_channel)

		// Leak gas every leak_interval ticks
		if(overstress_ticks % leak_interval == 0)
			leak_gasmix()

		// Pressing reminder after reminder_interval ticks
		if(overstress_ticks == reminder_interval)
			stored_radio.talk_into(src, "Critical: Geothermal turbine will fail catastrophically if not stabilized!", warning_channel)

		// Explosion after explosion_interval ticks
		if(overstress_ticks >= explosion_interval)
			explode()
			return
	else if(overstress_ticks > 0)
		// Reset escalation if stress drops back under threshold
		overstress_ticks = 0

/obj/machinery/geothermal_turbine/proc/leak_gasmix()
	if(turbine_gasmix && turbine_gasmix.total_moles() > 0)
		var/turf/leak_turf = get_turf(src)
		var/datum/gas_mixture/leak_mix = turbine_gasmix.remove_ratio(0.05) // 5% leak
		leak_turf.assume_air(leak_mix)

/obj/machinery/geothermal_turbine/proc/explode()
	// Announce final failure
	stored_radio.talk_into(src, "Geothermal turbine has exploded in [get_area(src)]!", RADIO_CHANNEL_COMMON)

	// Create explosion effect (not SM delam level, but significant)
	explosion(src, 2, 4, 6, 0) // adjust devastation/heavy/light ranges
	qdel(src)


///This Proc will check that the turbine is setup correctly.
/obj/machinery/geothermal_turbine/proc/check_multiblock()
	var/turf/core_tile = get_turf(src)
	var/current_direction = dir

	// Relative directions
	var/right_dir = turn(current_direction, -90)
	var/left_dir  = turn(current_direction, 90)

	// Layout:
	// [inlet] is to the right of core
	// [manifold] → [generator] → [outlet] go to the left chain

	var/turf/inlet_tile     = get_step(core_tile, right_dir)
	var/turf/manifold_tile  = get_step(core_tile, left_dir)
	var/turf/generator_tile = get_step(manifold_tile, left_dir)
	var/turf/outlet_tile    = get_step(generator_tile, left_dir)

	// Check each tile for correct part, anchored, same dir
	var/obj/machinery/atmospherics/components/unary/geothermal_turbine_inlet/inlet_port_found = locate() in inlet_tile
	var/obj/machinery/geothermal_turbine/core_machine_found = locate() in core_tile
	var/obj/machinery/atmospherics/components/unary/geothermal_turbine_cooling_manifold/cooling_manifold_found = locate() in manifold_tile
	var/obj/machinery/power/geothermal_turbine_generator/generator_module_found = locate() in generator_tile
	var/obj/machinery/atmospherics/components/unary/geothermal_turbine_outlet/outlet_port_found = locate() in outlet_tile

	if(inlet_port_found && core_machine_found && cooling_manifold_found && generator_module_found && outlet_port_found)
		if(inlet_port_found.anchored && core_machine_found.anchored && cooling_manifold_found.anchored && generator_module_found.anchored && outlet_port_found.anchored)
			if(inlet_port_found.dir == current_direction && core_machine_found.dir == current_direction && cooling_manifold_found.dir == current_direction && generator_module_found.dir == current_direction && outlet_port_found.dir == current_direction)
				// Link children to core
				inlet_port_found.parent_turbine = core_machine_found
				cooling_manifold_found.parent_turbine = core_machine_found
				generator_module_found.parent_turbine = core_machine_found
				outlet_port_found.parent_turbine = core_machine_found

				// Save references on core
				core_machine_found.inlet_port = inlet_port_found
				core_machine_found.cool_manifold = cooling_manifold_found
				core_machine_found.gen_module = generator_module_found
				core_machine_found.outlet_port = outlet_port_found

				// Mark ready
				core_machine_found.processing = TRUE
				START_PROCESSING(src, src)

/obj/machinery/power/geothermal_turbine_generator/process()
	// Kill processing if turbine isn’t assembled
	if(!parent_turbine || !parent_turbine.processing)
		return PROCESS_KILL

	// Pull RPM from parent turbine
	var/current_rpm = parent_turbine.rpm

	// Convert RPM into wattage (scaling factor tweakable for balance)
	var/power_output = round(current_rpm * watt_per_rpm) // 10 W per RPM, adjust as needed

	// Add power to the connected powernet
	add_load(power_output)


/obj/machinery/atmospherics/components/unary/geothermal_turbine_inlet/interact(mob/user)
	. = ..()
	open_valve_gui(user)

///Opens the gui that lets you adjust the geothermal engine's input.
/obj/machinery/atmospherics/components/unary/geothermal_turbine_inlet/proc/open_valve_gui(mob/user)
	if(!parent_turbine)
		to_chat(user, "This inlet is not connected to a turbine core.")
		return

	var/datum/browser/gui = new(user, "turbine_inlet", "Turbine Inlet Control", 450, 350)

	var/pressure = parent_turbine.turbine_gasmix?.return_pressure() || 0
	var/valve_setting = parent_turbine.input_valve_lps

	// Arbitrary max values for display only (tweak later once you know real ranges)
	var/max_pressure = 1000   // kPa
	var/max_valve = 100       // L/s

	// Percentages for progress bars
	var/pressure_pct = clamp((pressure / max_pressure) * 100, 0, 100)
	var/valve_pct = clamp((valve_setting / max_valve) * 100, 0, 100)

	var/html = "<center>"
	html += "<h2>Turbine Inlet Control</h2>"

	// Pressure bar
	html += "<p><b>Pressure:</b> [round(pressure,0.1)] kPa</p>"
	html += "<div style='width:80%;border:1px solid #000;height:16px;margin:auto;'>"
	html += "<div style='width:[pressure_pct]%;height:100%;background:[parent_turbine.get_bar_color(pressure_pct)];'></div></div>"

	// Valve setting bar
	html += "<p><b>Valve setting:</b> [valve_setting] L/s</p>"
	html += "<div style='width:80%;border:1px solid #000;height:16px;margin:auto;'>"
	html += "<div style='width:[valve_pct]%;height:100%;background:[parent_turbine.get_bar_color(valve_pct)];'></div></div>"

	// Adjust valve section
	html += "<p><b>Adjust Valve:</b></p>"
	html += "<div>"
	html += "<a href='?src=\ref[src];adjust=-10'>-10</a> "
	html += "<a href='?src=\ref[src];adjust=-5'>-5</a> "
	html += "<a href='?src=\ref[src];adjust=-1'>-1</a> "
	html += "<a href='?src=\ref[src];adjust=+1'>+1</a> "
	html += "<a href='?src=\ref[src];adjust=+5'>+5</a> "
	html += "<a href='?src=\ref[src];adjust=+10'>+10</a>"
	html += "</div>"

	html += "</center>"

	gui.set_content(html)
	gui.open()

/obj/machinery/atmospherics/components/unary/geothermal_turbine_inlet/Topic(href, href_list)
	..()
	if(href_list["adjust"])
		var/adjustment = text2num(href_list["adjust"])
		if(parent_turbine)
			parent_turbine.input_valve_lps = clamp(parent_turbine.input_valve_lps + adjustment, 0, 100)
			// Refresh GUI after adjustment
			open_valve_gui(usr)

/obj/machinery/atmospherics/components/unary/geothermal_turbine_outlet/interact(mob/user)
	. = ..()
	open_condenser_gui(user)

///Opens the GUI letting you adjust the parent's condenser efficiency.
/obj/machinery/atmospherics/components/unary/geothermal_turbine_outlet/proc/open_condenser_gui(mob/user)
	if(!parent_turbine)
		to_chat(user, "This outlet is not connected to a turbine core.")
		return

	var/datum/browser/gui = new(user, "turbine_outlet", "Turbine Outlet Control", 450, 350)

	// Gather values
	var/condenser_setting = parent_turbine.condenser_efficiency
	var/pipe_temp = airs[1]?.temperature || T20C
	var/core_temp = parent_turbine.turbine_gasmix?.temperature || T20C

	// Arbitrary max values for display only (tweak later)
	var/max_efficiency = 100
	var/max_pipe_temp = 600
	var/max_core_temp = 1000

	// Percentages for progress bars
	var/eff_pct = clamp((condenser_setting / max_efficiency) * 100, 0, 100)
	var/pipe_pct = clamp((pipe_temp / max_pipe_temp) * 100, 0, 100)
	var/core_pct = clamp((core_temp / max_core_temp) * 100, 0, 100)

	var/html = "<center>"
	html += "<h2>Turbine Outlet Control</h2>"

	// Pipe temp bar
	html += "<p><b>Pipe temperature:</b> [round(pipe_temp,0.1)] K</p>"
	html += "<div style='width:80%;border:1px solid #000;height:16px;margin:auto;'>"
	html += "<div style='width:[pipe_pct]%;height:100%;background:[parent_turbine.get_bar_color(pipe_pct)];'></div></div>"

	// Core gasmix temp bar
	html += "<p><b>Core gasmix temperature:</b> [round(core_temp,0.1)] K</p>"
	html += "<div style='width:80%;border:1px solid #000;height:16px;margin:auto;'>"
	html += "<div style='width:[core_pct]%;height:100%;background:[parent_turbine.get_bar_color(core_pct)];'></div></div>"

	// Condenser efficiency bar
	html += "<p><b>Condenser efficiency:</b> [condenser_setting]%</p>"
	html += "<div style='width:80%;border:1px solid #000;height:16px;margin:auto;'>"
	html += "<div style='width:[eff_pct]%;height:100%;background:[parent_turbine.get_bar_color(eff_pct)];'></div></div>"

	// Adjust efficiency section
	html += "<p><b>Adjust Efficiency:</b></p>"
	html += "<div>"
	html += "<a href='?src=\ref[src];adjust=-10'>-10</a> "
	html += "<a href='?src=\ref[src];adjust=-5'>-5</a> "
	html += "<a href='?src=\ref[src];adjust=-1'>-1</a> "
	html += "<a href='?src=\ref[src];adjust=+1'>+1</a> "
	html += "<a href='?src=\ref[src];adjust=+5'>+5</a> "
	html += "<a href='?src=\ref[src];adjust=+10'>+10</a>"
	html += "</div>"

	html += "</center>"

	gui.set_content(html)
	gui.open()

/obj/machinery/atmospherics/components/unary/geothermal_turbine_outlet/Topic(href, href_list)
	..()
	if(href_list["adjust"])
		var/adjustment = text2num(href_list["adjust"])
		if(parent_turbine)
			parent_turbine.condenser_efficiency = clamp(parent_turbine.condenser_efficiency + adjustment, 0, 100)
			// Refresh GUI after adjustment
			open_condenser_gui(usr)
/obj/machinery/geothermal_turbine/interact(mob/user)
	. = ..()
	open_core_gui(user)

/obj/machinery/geothermal_turbine/proc/open_core_gui(mob/user)
	if(!processing)
		check_multiblock()
		if(!processing)
			to_chat(user, "The turbine is not fully assembled.")
			return

	var/datum/browser/gui = new(user, "turbine_core", "Turbine Core Control", 500, 450)

	// Gather values
	var/current_rpm = rpm
	var/current_stress = stress
	var/current_temp = housing_temperature
	var/current_flow = flow_rate
	var/current_filter = filter

	// Arbitrary max values for display only (tweak later)
	var/max_rpm = 5000
	var/max_stress_val = max_stress
	var/max_temp = 1000
	var/max_flow = 1000
	var/max_filter = 100

	// Percentages for progress bars
	var/rpm_pct = clamp((current_rpm / max_rpm) * 100, 0, 100)
	var/stress_pct = clamp((current_stress / max_stress_val) * 100, 0, 100)
	var/temp_pct = clamp((current_temp / max_temp) * 100, 0, 100)
	var/flow_pct = clamp((current_flow / max_flow) * 100, 0, 100)
	var/filter_pct = clamp((current_filter / max_filter) * 100, 0, 100)

	var/html = "<center>"
	html += "<h2>Turbine Core Control</h2>"

	// RPM bar
	html += "<p><b>RPM:</b> [current_rpm]</p>"
	html += "<div style='width:80%;border:1px solid #000;height:16px;margin:auto;'>"
	html += "<div style='width:[rpm_pct]%;height:100%;background:[get_bar_color(rpm_pct)];'></div></div>"

	// Stress bar
	html += "<p><b>Stress:</b> [current_stress]/[max_stress_val]</p>"
	html += "<div style='width:80%;border:1px solid #000;height:16px;margin:auto;'>"
	html += "<div style='width:[stress_pct]%;height:100%;background:[get_bar_color(stress_pct)];'></div></div>"

	// Housing temp bar
	html += "<p><b>Housing Temp:</b> [round(current_temp,0.1)] K</p>"
	html += "<div style='width:80%;border:1px solid #000;height:16px;margin:auto;'>"
	html += "<div style='width:[temp_pct]%;height:100%;background:[get_bar_color(temp_pct)];'></div></div>"

	// Flow rate bar
	html += "<p><b>Flow Rate:</b> [round(current_flow,0.1)]</p>"
	html += "<div style='width:80%;border:1px solid #000;height:16px;margin:auto;'>"
	html += "<div style='width:[flow_pct]%;height:100%;background:[get_bar_color(flow_pct)];'></div></div>"

	// Filter bar + adjustment buttons
	html += "<p><b>Filter Setting:</b> [current_filter]%</p>"
	html += "<div style='width:80%;border:1px solid #000;height:16px;margin:auto;'>"
	html += "<div style='width:[filter_pct]%;height:100%;background:[get_bar_color(filter_pct)];'></div></div>"

	html += "<p><b>Adjust Filter:</b></p>"
	html += "<div>"
	html += "<a href='?src=\ref[src];filter=-10'>-10</a> "
	html += "<a href='?src=\ref[src];filter=-5'>-5</a> "
	html += "<a href='?src=\ref[src];filter=-1'>-1</a> "
	html += "<a href='?src=\ref[src];filter=+1'>+1</a> "
	html += "<a href='?src=\ref[src];filter=+5'>+5</a> "
	html += "<a href='?src=\ref[src];filter=+10'>+10</a>"
	html += "</div>"

	html += "</center>"

	gui.set_content(html)
	gui.open()

/obj/machinery/geothermal_turbine/Topic(href, href_list)
	..()
	if(href_list["filter"])
		var/adjustment = text2num(href_list["filter"])
		filter = clamp(filter + adjustment, 0, 100)
		// Refresh GUI after adjustment
		open_core_gui(usr)

/obj/machinery/power/geothermal_turbine_generator/interact(mob/user)
	. = ..()
	open_generator_gui(user)

/obj/machinery/power/geothermal_turbine_generator/proc/open_generator_gui(mob/user)
	if(!parent_turbine || !parent_turbine.processing)
		to_chat(user, "The generator is not connected to a running turbine.")
		return

	var/current_rpm = parent_turbine.rpm
	var/current_output = round(current_rpm * watt_per_rpm)

	// Arbitrary max values for display only (tweak later)
	var/max_rpm = 5000
	var/max_output = 50000 // watts

	// Percentages for progress bars
	var/rpm_pct = clamp((current_rpm / max_rpm) * 100, 0, 100)
	var/output_pct = clamp((current_output / max_output) * 100, 0, 100)

	var/datum/browser/gui = new(user, "turbine_generator", "Generator Output", 400, 250)

	var/html = "<center>"
	html += "<h2>Generator Module</h2>"

	// RPM bar
	html += "<p><b>RPM:</b> [current_rpm]</p>"
	html += "<div style='width:80%;border:1px solid #000;height:16px;margin:auto;'>"
	html += "<div style='width:[rpm_pct]%;height:100%;background:[parent_turbine.get_bar_color(rpm_pct)];'></div></div>"

	// Output bar
	html += "<p><b>Current Output:</b> [current_output] W</p>"
	html += "<div style='width:80%;border:1px solid #000;height:16px;margin:auto;'>"
	html += "<div style='width:[output_pct]%;height:100%;background:[parent_turbine.get_bar_color(output_pct)];'></div></div>"

	html += "</center>"

	gui.set_content(html)
	gui.open()

/obj/machinery/atmospherics/components/unary/geothermal_turbine_cooling_manifold/interact(mob/user)
	. = ..()
	open_cooling_gui(user)

/obj/machinery/atmospherics/components/unary/geothermal_turbine_cooling_manifold/proc/open_cooling_gui(mob/user)
	if(!parent_turbine)
		to_chat(user, "This manifold is not connected to a turbine core.")
		return

	var/datum/browser/gui = new(user, "turbine_cooling", "Cooling Manifold Control", 500, 400)

	var/coolant_temp = air_contents?.temperature || T20C
	var/housing_temp = parent_turbine.temperature
	var/current_flow = parent_turbine.coolant_flow

	// Arbitrary max values for display only (tweak later)
	var/max_coolant_temp = 600   // K
	var/max_housing_temp = 1000  // K
	var/max_flow = 100           // L/s

	// Percentages for progress bars
	var/coolant_pct = clamp((coolant_temp / max_coolant_temp) * 100, 0, 100)
	var/housing_pct = clamp((housing_temp / max_housing_temp) * 100, 0, 100)
	var/flow_pct = clamp((current_flow / max_flow) * 100, 0, 100)

	var/html = "<center>"
	html += "<h2>Cooling Manifold</h2>"

	// Warning banner if flow instability is active
	if(parent_turbine.flow_instability)
		html += "<p style='color:red;font-weight:bold;'>⚠ Flow instability detected! Cooling efficiency compromised.</p>"

	// Coolant temp bar
	html += "<p><b>Coolant Loop Temp:</b> [round(coolant_temp,0.1)] K</p>"
	html += "<div style='width:80%;border:1px solid #000;height:16px;margin:auto;'>"
	html += "<div style='width:[coolant_pct]%;height:100%;background:[get_bar_color(coolant_pct)];'></div></div>"

	// Housing temp bar
	html += "<p><b>Housing Temp:</b> [round(housing_temp,0.1)] K</p>"
	html += "<div style='width:80%;border:1px solid #000;height:16px;margin:auto;'>"
	html += "<div style='width:[housing_pct]%;height:100%;background:[get_bar_color(housing_pct)];'></div></div>"

	// Flow bar
	html += "<p><b>Coolant Flow:</b> [current_flow] L/s</p>"
	html += "<div style='width:80%;border:1px solid #000;height:16px;margin:auto;'>"
	html += "<div style='width:[flow_pct]%;height:100%;background:[get_bar_color(flow_pct)];'></div></div>"

	// Adjust flow section
	html += "<p><b>Adjust Flow:</b></p>"
	html += "<div>"
	html += "<a href='?src=\ref[src];flow=-10'>&lt;--10&lt;-</a> "
	html += "<a href='?src=\ref[src];flow=-5'>&lt;--5&lt;-</a> "
	html += "<a href='?src=\ref[src];flow=-1'>&lt;- -1&lt;-</a> "
	html += "<a href='?src=\ref[src];flow=+1'>-&gt; +1 -&gt;</a> "
	html += "<a href='?src=\ref[src];flow=+5'>-&gt; +5 -&gt;</a> "
	html += "<a href='?src=\ref[src];flow=+10'>-&gt; +10 -&gt;</a>"
	html += "</div>"

	html += "</center>"

	gui.set_content(html)
	gui.open()

/obj/machinery/atmospherics/components/unary/geothermal_turbine_cooling_manifold/Topic(href, href_list)
	..()
	if(href_list["flow"])
		var/adjustment = text2num(href_list["flow"])
		if(parent_turbine)
			parent_turbine.coolant_flow = clamp(parent_turbine.coolant_flow + adjustment, 0, 100)
			// Refresh GUI after adjustment
			open_cooling_gui(usr)

/obj/machinery/geothermal_turbine/proc/get_bar_color(pct)
	if(pct < 50) return "#4CAF50"	// green
	if(pct < 80) return "#FFC107"	// amber
	return "#F44336"				// red
