/// @description Set up basic vars

// -- inherit from parent --

// tracking
hp = 3;
i_frames = 0;
dmg = 1;
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
shot_type = "Normal";
// get attributes based on id

// formations
flight_lead = self;
flight_pos = 0;
trail_store_dist = 32;
trail_pos = [[-1,-1], [-1,-1], [-1,-1]];

form_id = 3; // 0 -> snake, 1 -> line, 2 -> square, 3 -> diamond
form_update = false;
form_targ_x = self.x;
form_targ_y = self.y;

trans_dist = 0;
trans_angle = 0;
trans_prog = 0;
