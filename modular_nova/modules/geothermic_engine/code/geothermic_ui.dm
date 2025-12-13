/// Shared geothermic UI helper.
/obj/machinery/proc/open_turbine_ui(mob/user, datum/tgui/ui, ui_key, ui_name, missing_msg)
    if(!parent_turbine)
        to_chat(user, missing_msg)
        return
    ui = new(user, src, ui_key, ui_name)
    ui.open()

/obj/machinery/proc/adjust_setting(varname, amount, min, max)
    var/current = vars[varname]
    vars[varname] = clamp(current + amount, min, max)

/obj/machinery/geothermal_turbine/ui_interact(mob/user, datum/tgui/ui)
    return open_turbine_ui(user, ui, "turbine_core", "GeoTurbineCore", "Error, Turbine missing parts.")

/obj/machinery/geothermal_turbine/ui_data(mob/user)
    return list(
        "rpm" = rpm,
        "stress" = stress,
        "housing_temp" = housing_temp,
        "flow_rate" = flow_rate,
        "filter" = filter_setting,
        "max_rpm" = 5000,
        "max_stress" = 100,
        "max_temp" = 2000,
        "max_flow" = 200,
        "max_filter" = 100,
    )

/obj/machinery/atmospherics/components/unary/geothermal_turbine_inlet/ui_interact(mob/user, datum/tgui/ui)
    return open_turbine_ui(user, ui, "turbine_inlet", "GeoTurbineInlet", "This inlet is not connected to a turbine core.")

/obj/machinery/atmospherics/components/unary/geothermal_turbine_inlet/ui_data(mob/user)
    return list(
        "pressure_kpa" = parent_turbine.turbine_gasmix?.return_pressure() || 0,
        "valve_lps" = parent_turbine.input_valve_lps,
        "max_pressure_kpa" = 1000,
        "max_valve_lps" = 100,
    )

/obj/machinery/atmospherics/components/unary/geothermal_turbine_inlet/ui_act(action, list/params, mob/user)
    if(action == "adjust_valve")
        var/amount = text2num(params["amount"])
        if(isnum(amount))
            parent_turbine.adjust_setting("input_valve_lps", amount, 0, 100)
            return TRUE
    return ..()

/obj/machinery/power/geothermal_turbine_generator/ui_interact(mob/user, datum/tgui/ui)
    return open_turbine_ui(user, ui, "turbine_generator", "GeoTurbineGenerator", "This generator is not connected to a turbine core.")

/obj/machinery/power/geothermal_turbine_generator/ui_data(mob/user)
    return list(
        "rpm" = parent_turbine.rpm,
        "output_kw" = output_kw,
        "max_rpm" = 5000,
        "max_output_kw" = 2000,
    )
