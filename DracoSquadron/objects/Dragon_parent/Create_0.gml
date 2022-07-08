/// @description Set up basic vars

// -- inherit from parent --

// tracking
hp = 3;
i_frames = 0;
//dmg = 1;
team = 1;

// -- end inherit --

// debug
show_debug_message("Created at position ("+string(x)+", "+string(y)+") on layer "+string(layer));

// movement
move_speed = 5;
vert_speed_distort = 0.6;

// combat
dragon_id = 0; // dictates attributes and name
fire_delay = 12;
fire_timer = 0;
shot_type = "normal";
dmg = 2;
sp_meter = 0;

// formations
flight_lead = id;
//saved_lead = flight_lead; // debug
flight_pos = 0;
trail_store_dist = 32;
trail_pos = [[x, y+32], [x, y+64], [x, y+96]];

form_id = 0; // 0 -> snake, 1 -> line, 2 -> square, 3 -> diamond
form_update = false;
form_targ_x = x;
form_targ_y = y;

trans_dist = 0;
trans_angle = 0;
trans_prog = 0;

show_debug_message("flight lead at creation end is "+string(flight_lead));
