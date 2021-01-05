// knockback / movement
x_knock = 0;
y_knock = 0;
mass = 1;
HP = 10;

// other
hit_flash = 0;
slash = noone;
step_wait = 10;
appear = irandom_range(0,1);
if(appear == 0){
	sprite_index = E1M_idle_DR;
}else{
	sprite_index = E1F_idle_DR;
}
facing = 0;
xscale = 1;
yscale = 1;

// AI vars
AI_state = 1;
AI_wait = 0;
AI_intention = 0;
AI_targ_x = x;
AI_targ_y = y;
origin_x = x;
origin_y = y;
target = noone;
aim_dir = 0;

/*
vision_range = 64;
aggro_range = 64;
standby_range = (40,56)
melee_range = (24,32) / 20
*/