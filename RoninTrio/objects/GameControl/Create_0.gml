// set up the control system

// control inputs (DEFAULT)
// ( 0 -> keyboard, 1 -> mouse, 2 -> gamepad button, 3 -> gamepad stick )
// ( 0 -> constant check, 1 -> press check )
globalvar inputs;
inputs[0,0] = 0; inputs[0,1] = ord("A"); inputs[0,2] = 0; inputs[0,3] = 0; // left
inputs[1,0] = 0; inputs[1,1] = ord("D"); inputs[1,2] = 0; inputs[1,3] = 0; // right
inputs[2,0] = 0; inputs[2,1] = ord("W"); inputs[2,2] = 0; inputs[2,3] = 0; // up
inputs[3,0] = 0; inputs[3,1] = ord("S"); inputs[3,2] = 0; inputs[3,3] = 0; // down

inputs[4,0] = 0; inputs[4,1] = ord("A"); inputs[4,2] = 0; inputs[4,3] = 1; // left(press)
inputs[5,0] = 0; inputs[5,1] = ord("D"); inputs[5,2] = 0; inputs[5,3] = 1; // right(press)
inputs[6,0] = 0; inputs[6,1] = ord("W"); inputs[6,2] = 0; inputs[6,3] = 1; // up(press)
inputs[7,0] = 0; inputs[7,1] = ord("S"); inputs[7,2] = 0; inputs[7,3] = 1; // down(press)

inputs[8,0] = 0; inputs[8,1] = mb_left; inputs[8,2] = 1; inputs[8,3] = 1; // attack / cancel
inputs[9,0] = 0; inputs[9,1] = ord("E"); inputs[9,2] = 0; inputs[9,3] = 1; // boost / confirm
inputs[10,0] = 0; inputs[10,1] = vk_escape; inputs[10,2] = 0; inputs[10,3] = 1; // pause
inputs[11,0] = 0; inputs[11,1] = mb_right; inputs[11,2] = 1; inputs[11,3] = 1; // projectile [DEBUG]

// particle system
globalvar part_sys;
part_sys = part_system_create();
globalvar part_types;
part_types = ds_list_create();
// particle types
ds_list_add(part_types,part_type_create());
ds_list_add(part_types,part_type_create());
ds_list_add(part_types,part_type_create());
ds_list_add(part_types,part_type_create());
ds_list_add(part_types,part_type_create());
// type 0: leaf
part_type_life(part_types[| 0],50,70);
part_type_orientation(part_types[| 0],0,360,2,6,false);
part_type_speed(part_types[| 0],0.5,1,-0.01,0.2);
part_type_sprite(part_types[| 0],Particles_Leaves,false,false,true);
part_type_alpha2(part_types[| 0],1.0,0);
// type 1: splash
// type 2: footprint
// type 3: kill slash
part_type_sprite(part_types[| 1],Particles_KillSlash,true,true,false);
part_type_life(part_types[| 1],6,6);
// type 4: hit
part_type_sprite(part_types[| 2],Particles_Hurt,true,true,false);
part_type_life(part_types[| 2],6,6);
// type 5: deflect
part_type_sprite(part_types[| 3],Particles_Deflect,true,true,false);
part_type_life(part_types[| 3],6,6);
// type 6: sword clash
part_type_sprite(part_types[| 4],Particles_Clash,true,true,false);
part_type_life(part_types[| 4],6,6);

// set up the world

// objects
obj_list = ds_list_create();

// pausing / menus
globalvar paused;
paused = false;
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