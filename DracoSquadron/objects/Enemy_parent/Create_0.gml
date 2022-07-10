/// vars

// Inherit the parent event
event_inherited();

// tracking
hp = 3;
i_frames = 0;
dmg = 1;
team = 0;
value = 3; // to build meter when destroyed
start_x = x;
start_y = y;
time = 0;
move_angle = 270;

// AI vars
AI_type = "sweep";
AI_active = false;
save_pos_dist = 36;
saved_pos = [[x,y], [x,y], [x,y], [x,y], [x,y]];
flight_lead = noone;
flight_pos = 1;
flight = [];
shot_delay = 10;
