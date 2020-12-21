if(!paused){

// temps
var x_spd = 0;
var y_spd = 0;

// hit flash
hit_flash = lerp(hit_flash,0,1);

if(!boost_active){
// movement controls
if(HP > 0){
	// AI control
	if(int64(x_knock) == 0 && int64(y_knock) == 0){
		if(AI_wait == 0){
			// pick action (start with range objectives)
			switch(AI_state){
				case 0:
					// moving / adjusting position
					if(place_meeting(AI_targ_x,AI_targ_y,Solid)){
						var ret_dir = point_direction(AI_targ_x,AI_targ_y,x,y);
						//show_debug_message("Target position in a wall, moving to ("+string(AI_targ_x+lengthdir_x(2,ret_dir))+","+string(AI_targ_y+lengthdir_y(2,ret_dir))+")");
						AI_targ_x += lengthdir_x(2,ret_dir);
						AI_targ_y += lengthdir_y(2,ret_dir);
					}
					if(x < AI_targ_x){
						x_spd += min(1,AI_targ_x-x);
					}else if(x > AI_targ_x){
						x_spd -= min(1,x-AI_targ_x);
					}
					if(y < AI_targ_y){
						y_spd += min(1,AI_targ_y-y);
					}else if(y > AI_targ_y){
						y_spd -= min(1,y-AI_targ_y);
					}
					if((x == AI_targ_x && y == AI_targ_y)){
						AI_state = 1;
						AI_wait = 8; //30
						//if(target != noone){
						//show_debug_message("Done moving, at ("+string(x)+","+string(y)+"), radius="+string(distance_to_point(target.x,target.y)));
						//}
					}
				break;
				case 1:
					// standby / idle
					
					// look for player
					if(distance_to_object(Player) <= 64 && Player.HP > 0){
						target = Player;
					}else{
						target = noone;
					}
					
					if(target != noone){
						//var dist = distance_to_object(target);
						var dist = distance_to_point(target.x,target.y);
						// found, move to offensive standby
						if(dist < 32){ // 20
							// player in melee range
							if(slash == noone){
								if(AI_intention == 1){
									// action
									var dir = point_direction(x,y,target.x,target.y);
									slash = instance_create_layer(x+lengthdir_x(18,dir),y+lengthdir_y(18,dir),layer,MeleeAttack);
									slash.owner = id;
									slash.dmg = 1;
									slash.force = 0.5;
									slash.dir = dir;
									slash.rad = 18;
									slash.life = 6;
									slash.sprite_index = Particles_Slash1;
									slash.image_angle = dir;
									AI_wait = 45;
									AI_intention = 0;
								}else{
									// reaction
									AI_wait = 9;
									AI_intention = 1;
								}
							}
						}else if(dist >= 48 && dist <= 56){
							// outside melee range, in standby range
							if(AI_intention == 0){
								var chance = irandom_range(0,1);
								if(chance == 1){
									AI_intention = 1;
									//show_debug_message(string(id)+" got angry, dist="+string(dist));
								}else{
									AI_wait = 8;
								}
							}
							
							var self_angle = point_direction(target.x,target.y,x,y);
							if(AI_intention == 1){
								// move into melee range
								AI_targ_x = target.x+round(lengthdir_x(20,self_angle));
								AI_targ_y = target.y+round(lengthdir_y(20,self_angle));
								AI_state = 0;
								AI_wait = 6;
							}else{
								// spread out
								var others = ds_list_create();
								var n = instance_place_list(x, y, Enemy, others, true);
								var angle_off = 0;
								for(var i=0; i<n; i++){
									var other_angle = point_direction(target.x,target.y,other.x,other.y);
									if(angle_diff(self_angle, other_angle) >= 0){
										angle_off += 20;
									}else if(angle_diff(self_angle, other_angle) < 0){
										angle_off -= 20;
									}
								}
								// move with angle_off
								if(angle_off != 0){
									AI_targ_x = target.x+round(lengthdir_x(dist,self_angle+angle_off));
									AI_targ_y = target.y+round(lengthdir_y(dist,self_angle+angle_off));
									AI_state = 0;
									AI_wait = 6;
								}
							}
						}else{
							// outside melee range and standby range, move to standby range
							var angl = point_direction(target.x,target.y,x,y);
							if(dist < 48){
								if(AI_intention != 1){
									//show_debug_message("out range, moving outwards to ("+string(round(target.x+lengthdir_x(50,angl)))+","+string(round(target.y+lengthdir_y(50,angl)))+"), dist="+string(dist));
									AI_targ_x = target.x+round(lengthdir_x(60,angl)); //48
									AI_targ_y = target.y+round(lengthdir_y(60,angl)); //48
									AI_state = 0;
									AI_wait = 6;
								}else{
									AI_targ_x = target.x+round(lengthdir_x(32,angl));
									AI_targ_y = target.y+round(lengthdir_y(32,angl));
									AI_state = 0;
									AI_wait = 2;
								}
							}else{
								//show_debug_message("out range, moving inwards");
								AI_targ_x = target.x+round(lengthdir_x(56,angl));
								AI_targ_y = target.y+round(lengthdir_y(56,angl));
								AI_state = 0;
								AI_wait = 6;
								if(AI_intention == 1){
									AI_intention = 0;
								}
							}
						}
					}else if(x != origin_x || y != origin_y){
						// not found, go back to post
						AI_targ_x = origin_x;
						AI_targ_y = origin_y;
						AI_intention = 0;
						AI_state = 0;
						AI_wait = 6;
					}
				break;
			}
		}else{
			AI_wait -= 1;
		}
	}
}

// variable updates
x_knock = lerp(x_knock, 0.0, 0.1);
y_knock = lerp(y_knock, 0.0, 0.1);

// collisions
if(place_meeting(x+x_spd+x_knock, y+y_spd+y_knock, Solid)){
	var inst = instance_place(x+x_spd+x_knock, y+y_spd+y_knock, Solid);
	// x bounce
	if(inst.y >= y-6 && inst.y <= y+6){
		x_knock = -x_knock;
	}
	// y bounce
	if(inst.x >= x-6 && inst.x <= x+6){
		y_knock = -y_knock
	}
}
var xsp = x_spd+round(x_knock);
var ysp = y_spd+round(y_knock);
var loops = 0;
while(place_meeting(x+xsp, y+ysp, Solid) && loops < 12){
	if(place_meeting(x+xsp, y, Solid)){
		if(xsp > 0){
			xsp -= 1;
		}else if(xsp < 0){
			xsp += 1;
		}
	}
	if(place_meeting(x, y+ysp, Solid)){
		if(ysp > 0){
			ysp -= 1;
		}else if(ysp < 0){
			ysp += 1;
		}
	}
	loops += 1;
}
x_spd = xsp;
y_spd = ysp;

// move object
x += x_spd;
y += y_spd;

}

// handle overflow
x = max(0,x);
x = min(x,room_width);
y = max(0,y);
y = min(y,room_height);

}