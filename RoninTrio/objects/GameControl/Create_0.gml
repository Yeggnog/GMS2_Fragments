// set up the control system

// particle system
globalvar part_sys_weather;
part_sys_weather = part_system_create();
globalvar part_types_weather;
part_types_weather = ds_list_create();
ds_list_add(part_types_weather,part_type_create());
// type 0: leaf
part_type_life(part_types_weather[| 0],50,70);
part_type_orientation(part_types_weather[| 0],0,360,2,6,false);
part_type_speed(part_types_weather[| 0],0.5,1,-0.01,0.2);
part_type_sprite(part_types_weather[| 0],Particles_Leaves,false,false,true);
part_type_alpha2(part_types_weather[| 0],1.0,0);

// set up the world

// objects
obj_list = ds_list_create();

// weather FX
weather_timers[0] = 0;
wind_spd = 0;
wind_dir = 0;
snow_lvl = 0;
precip = false;