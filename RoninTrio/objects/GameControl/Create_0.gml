// set up the control system

// particle system
globalvar part_sys_weather;
part_sys_weather = part_system_create();
globalvar part_types_weather;
part_types_weather = ds_list_create();
// particle types
ds_list_add(part_types_weather,part_type_create());
ds_list_add(part_types_weather,part_type_create());
ds_list_add(part_types_weather,part_type_create());
ds_list_add(part_types_weather,part_type_create());
ds_list_add(part_types_weather,part_type_create());
// type 0: leaf
part_type_life(part_types_weather[| 0],50,70);
part_type_orientation(part_types_weather[| 0],0,360,2,6,false);
part_type_speed(part_types_weather[| 0],0.5,1,-0.01,0.2);
part_type_sprite(part_types_weather[| 0],Particles_Leaves,false,false,true);
part_type_alpha2(part_types_weather[| 0],1.0,0);
// type 1: splash
// type 2: footprint
// [ TODO: un-differentiate particle systems]
// type 3: kill slash
part_type_sprite(part_types_weather[| 1],Particles_KillSlash,true,true,false);
part_type_life(part_types_weather[| 1],6,6);
// type 4: hit
part_type_sprite(part_types_weather[| 2],Particles_Hurt,true,true,false);
part_type_life(part_types_weather[| 2],6,6);
// type 5: deflect
part_type_sprite(part_types_weather[| 3],Particles_Deflect,true,true,false);
part_type_life(part_types_weather[| 3],6,6);
// type 6: sword clash
part_type_sprite(part_types_weather[| 4],Particles_Clash,true,true,false);
part_type_life(part_types_weather[| 4],6,6);

// set up the world

// objects
obj_list = ds_list_create();

// pausing / menus
globalvar paused;
paused = false;
//sword_offset = 0;
pause_wait = -1;
curs_wait = 0;
curs_y = 0;
curs_offset_x = 0;
curs_offset_y = 0;

// riptide boost FX
globalvar boost_active;
boost_active = false;
//boost_ring_age = 0;
//boost_ring_scale = 1.0;
boost_surface = surface_create(surface_get_width(application_surface),surface_get_height(application_surface));

// weather FX
weather_timers[0] = 0;
wind_spd = 0;
wind_dir = 0;
snow_lvl = 0;
precip = false;