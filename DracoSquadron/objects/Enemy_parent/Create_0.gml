/// vars

// Inherit the parent event
event_inherited();

// tracking
hp = 3;
i_frames = 0;
dmg = 1;
team = 0;
value = 3; // to build meter when destroyed

// AI vars
AI_type = "sweep";
AI_state = "idle";
save_pos_dist = 36;
saved_pos = [[x,y], [x,y], [x,y], [x,y], [x,y]];
flight_lead = noone;
shot_delay = 0;
