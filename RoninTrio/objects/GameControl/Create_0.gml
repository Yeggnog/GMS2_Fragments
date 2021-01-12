// set up the control system

// randomize RNG
randomize();

// control inputs (DEFAULT)
// ( 0 -> keyboard, 1 -> mouse, 2 -> gamepad button, 3 -> gamepad stick )
// ( 0 -> constant check, 1 -> press check )
// ( 0 -> not a stick input, 1 -> stick pos., 2 -> stick neg. )
control_mode = 0;
axis_sens = 5;

globalvar inputs;
inputs[0,0] = 0; inputs[0,1] = ord("A"); inputs[0,2] = 0; inputs[0,3] = 0; inputs[0,4] = 0; // left
inputs[1,0] = 0; inputs[1,1] = ord("D"); inputs[1,2] = 0; inputs[1,3] = 0; inputs[1,4] = 0; // right
inputs[2,0] = 0; inputs[2,1] = ord("W"); inputs[2,2] = 0; inputs[2,3] = 0; inputs[2,4] = 0; // up
inputs[3,0] = 0; inputs[3,1] = ord("S"); inputs[3,2] = 0; inputs[3,3] = 0; inputs[3,4] = 0; // down

inputs[4,0] = 0; inputs[4,1] = ord("A"); inputs[4,2] = 0; inputs[4,3] = 1; inputs[4,4] = 0; // left(press)
inputs[5,0] = 0; inputs[5,1] = ord("D"); inputs[5,2] = 0; inputs[5,3] = 1; inputs[5,4] = 0; // right(press)
inputs[6,0] = 0; inputs[6,1] = ord("W"); inputs[6,2] = 0; inputs[6,3] = 1; inputs[6,4] = 0; // up(press)
inputs[7,0] = 0; inputs[7,1] = ord("S"); inputs[7,2] = 0; inputs[7,3] = 1; inputs[7,4] = 0; // down(press)

inputs[8,0] = 0; inputs[8,1] = mb_left; inputs[8,2] = 1; inputs[8,3] = 1; inputs[8,4] = 0; // attack / confirm
inputs[9,0] = 0; inputs[9,1] = ord("E"); inputs[9,2] = 0; inputs[9,3] = 1; inputs[9,4] = 0; // boost
inputs[10,0] = 0; inputs[10,1] = vk_escape; inputs[10,2] = 0; inputs[10,3] = 1; inputs[10,4] = 0; // pause
inputs[11,0] = 0; inputs[11,1] = mb_right; inputs[11,2] = 1; inputs[11,3] = 1; inputs[11,4] = 0; // projectile[DEBUG] / cancel
inputs[12,0] = 0; inputs[12,1] = mb_none; inputs[12,2] = 1; inputs[12,3] = 0; inputs[12,4] = 0; // look angle input
inputs[13,1] = mb_left; inputs[13,2] = 1; inputs[13,3] = 1; inputs[13,4] = 0; // confirm
inputs[14,1] = mb_right; inputs[14,2] = 1; inputs[14,3] = 1; inputs[14,4] = 0; // cancel

// control inputs (GAMEPAD DEFAULT)

/*
inputs[0,0] = 0; inputs[0,1] = gp_axislh; inputs[0,2] = 3; inputs[0,3] = 0; inputs[0,4] = 2; // left
inputs[1,0] = 0; inputs[1,1] = gp_axislh; inputs[1,2] = 3; inputs[1,3] = 0; inputs[1,4] = 1; // right
inputs[2,0] = 0; inputs[2,1] = gp_axislv; inputs[2,2] = 3; inputs[2,3] = 0; inputs[2,4] = 2; // up
inputs[3,0] = 0; inputs[3,1] = gp_axislv; inputs[3,2] = 3; inputs[3,3] = 0; inputs[3,4] = 1; // down

inputs[4,0] = 0; inputs[4,1] = gp_axislh; inputs[4,2] = 3; inputs[4,3] = 1; inputs[4,4] = 2; // left(press)
inputs[5,0] = 0; inputs[5,1] = gp_axislh; inputs[5,2] = 3; inputs[5,3] = 1; inputs[5,4] = 1; // right(press)
inputs[6,0] = 0; inputs[6,1] = gp_axislv; inputs[6,2] = 3; inputs[6,3] = 1; inputs[6,4] = 2; // up(press)
inputs[7,0] = 0; inputs[7,1] = gp_axislv; inputs[7,2] = 3; inputs[7,3] = 1; inputs[7,4] = 1; // down(press)

inputs[8,0] = 0; inputs[8,1] = gp_shoulderrb; inputs[8,2] = 2; inputs[8,3] = 1; inputs[8,4] = 0; // attack / confirm
inputs[9,0] = 0; inputs[9,1] = gp_shoulderlb; inputs[9,2] = 2; inputs[9,3] = 1; inputs[9,4] = 0; // boost
inputs[10,0] = 0; inputs[10,1] = gp_start; inputs[10,2] = 2; inputs[10,3] = 1; inputs[10,4] = 0; // pause
inputs[11,0] = 0; inputs[11,1] = gp_shoulderl; inputs[11,2] = 2; inputs[11,3] = 1; inputs[11,4] = 0; // projectile[DEBUG] / cancel
inputs[12,0] = 0; inputs[12,1] = gp_axisrh; inputs[12,2] = 3; inputs[12,3] = gp_axisrv; inputs[12,4] = 0; // look angle input
*/

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
ds_list_add(part_types,part_type_create());
ds_list_add(part_types,part_type_create());
// type 0: leaf
part_type_life(part_types[| 0],50,70);
part_type_orientation(part_types[| 0],0,360,2,6,false);
part_type_speed(part_types[| 0],0.5,1,-0.01,0.2);
part_type_sprite(part_types[| 0],Particles_Leaves,false,false,true);
part_type_alpha2(part_types[| 0],1.0,0);
// type 1: kill slash
part_type_sprite(part_types[| 1],Particles_KillSlash,true,true,false);
part_type_life(part_types[| 1],6,6);
// type 2: hit
part_type_sprite(part_types[| 2],Particles_Hurt,true,true,false);
part_type_life(part_types[| 2],6,6);
// type 3: deflect
part_type_sprite(part_types[| 3],Particles_Deflect,true,true,false);
part_type_life(part_types[| 3],6,6);
// type 4: sword clash
part_type_sprite(part_types[| 4],Particles_Clash,true,true,false);
part_type_life(part_types[| 4],6,6);
// type 5: splash
part_type_sprite(part_types[| 5],Particles_Splash,true,true,false);
part_type_life(part_types[| 5],8,8);
// type 6: footprint
part_type_sprite(part_types[| 6],Particles_Snow,true,true,false);
part_type_alpha2(part_types[| 6],1.0,0.0);
part_type_life(part_types[| 6],16,24);

// set up the world

// objects
obj_list = ds_list_create();

// pausing / menus
globalvar paused;
paused = true; //false
pause_wait = -1;
curs_wait = 0;
curs_y = 0;
curs_x = 0;
curs_offset_x = 0;
curs_offset_y = 0;
menu_index = 0;
/*
-1: None
0: Title Menu
1: Title | Save Data
2: Title | Options
3: Pause Menu
4: Pause | Items
5: Pause | Options
6: Pause | Quit Y/N
*/
menu_delay = 0;

// riptide boost FX
globalvar boost_active;
boost_active = false;
boost_ring_age = 0;
//boost_ring_scale = 1.0;
boost_ring_x = 0;
boost_ring_y = 0;
boost_surface = surface_create(surface_get_width(application_surface),surface_get_height(application_surface));
boost_nmap = surface_create(surface_get_width(application_surface),surface_get_height(application_surface));

// weather FX
weather_timers[0] = 0;
weather_timers[1] = -1;
weather_timers[2] = 240; //-1
wind_spd = 0;
wind_dir = 0;
snow_lvl = 0;
rain_img = 0;
rain_img_timer = 3;
rain_light = 0;
rain_off = 0;
precip = false;

// save data
saves[0,0] = false;			// save validity
saves[0,1] = "Missingno.";	// save name
saves[0,2] = 0;				// area index
saves[0,3] = 0;				// completion percentage?
saves[0,4] = 0;				// beast 1 status (pegasus)
saves[0,5] = 0;				// beast 2 status (dragon)
saves[0,6] = 0;				// beast 3 status (phoenix)

/*
saves[0,0] = true;			// save validity
saves[0,1] = "RONIN";		// save name
saves[0,2] = Stage_0;		// area index
saves[0,3] = 42;			// completion percentage?
saves[0,4] = 1;				// beast 1 status (pegasus)
saves[0,5] = 1;				// beast 2 status (dragon)
saves[0,6] = 1;				// beast 3 status (phoenix)
*/

saves[1,0] = false;			// save validity
saves[1,1] = "Missingno.";	// save name
saves[1,2] = 0;				// area index
saves[1,3] = 0;				// completion percentage?
saves[1,4] = 0;				// beast 1 status (pegasus)
saves[1,5] = 0;				// beast 2 status (dragon)
saves[1,6] = 0;				// beast 3 status (phoenix)

saves[2,0] = false;			// save validity
saves[2,1] = "Missingno.";	// save name
saves[2,2] = 0;				// area index
saves[2,3] = 0;				// completion percentage?
saves[2,4] = 0;				// beast 1 status (pegasus)
saves[2,5] = 0;				// beast 2 status (dragon)
saves[2,6] = 0;				// beast 3 status (phoenix)