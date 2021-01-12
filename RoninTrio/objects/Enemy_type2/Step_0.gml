if(!paused){

// temps
var x_spd = 0;
var y_spd = 0;

// hit flash
if(hit_flash > 0){
	hit_flash -= 1;
}

if(!boost_active){
// movement controls
if(HP > 0){
	// crossbow dir
	var dir = point_direction(x,y,Player.x,Player.y);
	if(dir > aim_dir && (dir-aim_dir) > 12){
		aim_dir += min(2,(dir-aim_dir));
	}else if(dir < aim_dir && (aim_dir-dir) > 12){
		aim_dir -= min(2,(aim_dir-dir));
	}
	
	// AI control
	if(int64(x_knock) == 0 && int64(y_knock) == 0){
		if(AI_wait == 0){
			// pick action (start with range objectives)
			switch(AI_state){
				case 0:
					// moving / adjusting position
					if(place_meeting(AI_targ_x,AI_targ_y,Solid)){
						// target position is in a wall
						var ret_dir = point_direction(AI_targ_x,AI_targ_y,x,y);
						AI_targ_x += lengthdir_x(2,ret_dir);
						AI_targ_y += lengthdir_y(2,ret_dir);
					}
					// re-examine move destination
					//var dist1 = distance_to_point(AI_targ_x,AI_targ_y);
					var dist2 = distance_to_point(Player.x,Player.y);
					if(dist2 < 50){ //32
						/*var mov_dir = point_direction(x,y,AI_targ_x,AI_targ_y);
						var collision = false;
						for(var i=1; i<4; i++){
							var chk_x = x+lengthdir_x(i*(dist1/4),mov_dir);
							var chk_y = y+lengthdir_y(i*(dist1/4),mov_dir);
							collision = (collision || place_meeting(chk_x,chk_y,Solid));
						}*/
						var ret_dir = point_direction(Player.x,Player.y,x,y);
						AI_targ_x = Player.x+round(lengthdir_x(20,ret_dir));
						AI_targ_y = Player.y+round(lengthdir_y(20,ret_dir));
					}
					// move
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
					// stop if we've arrived
					if((x == AI_targ_x && y == AI_targ_y)){
						AI_state = 1;
						AI_wait = 8;
					}
				break;
				case 1:
					// standby / idle
					
					// look for player
					if(distance_to_object(Player) <= 80 && Player.HP > 0){ //64
						target = Player;
					}else{
						target = noone;
					}
					
					if(target != noone){
						var dist = distance_to_point(target.x,target.y);
						// found, move to offensive standby
						if(dist < 32){
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
									image_speed = 1;
									if(appear == 0){ // M
									switch(facing){
										case 0: if(sprite_index != E1M_slash1_DR){ sprite_index = E1M_slash1_DR; } break;
										case 1: if(sprite_index != E1M_slash1_DL){ sprite_index = E1M_slash1_DL; } break;
										case 2: if(sprite_index != E1M_slash1_UR){ sprite_index = E1M_slash1_UR; } break;
										case 3: if(sprite_index != E1M_slash1_UL){ sprite_index = E1M_slash1_UL; } break;
									}
									}else{ // F
									switch(facing){
										case 0: if(sprite_index != E1F_slash1_DR){ sprite_index = E1F_slash1_DR; } break;
										case 1: if(sprite_index != E1F_slash1_DL){ sprite_index = E1F_slash1_DL; } break;
										case 2: if(sprite_index != E1F_slash1_UR){ sprite_index = E1F_slash1_UR; } break;
										case 3: if(sprite_index != E1F_slash1_UL){ sprite_index = E1F_slash1_UL; } break;
									}
									}
								}else{
									// reaction
									AI_wait = 9;
									AI_intention = 1;
								}
							}
						}else if(dist >= 56 && dist <= 64){ //48-56
							// outside melee range, in standby range
							var self_angle = point_direction(target.x,target.y,x,y);
							if(AI_intention == 1){
								// shoot at the target
								var dir = point_direction(x,y,target.x,target.y);
								var shot = instance_create_layer(x+lengthdir_x(18,dir),y+lengthdir_y(18,dir),layer,ProjectileAttack);
								shot.owner = id;
								shot.dmg = 1;
								shot.force = 0.5;
								shot.dir = dir;
								shot.sprite_index = Crossbow_Bolt;
								shot.spd = 4;
								shot.life = 5;
								AI_wait = 105; //45
								image_speed = 1;
								if(appear == 0){ // M
								switch(facing){
									case 0: if(sprite_index != E2M_stow_DR){ sprite_index = E2M_stow_DR; } break;
									case 1: if(sprite_index != E2M_stow_DL){ sprite_index = E2M_stow_DL; } break;
									case 2: if(sprite_index != E2M_stow_UR){ sprite_index = E2M_stow_UR; } break;
									case 3: if(sprite_index != E2M_stow_UL){ sprite_index = E2M_stow_UL; } break;
								}
								}else{ // F
								switch(facing){
									case 0: if(sprite_index != E2F_stow_DR){ sprite_index = E2F_stow_DR; } break;
									case 1: if(sprite_index != E2F_stow_DL){ sprite_index = E2F_stow_DL; } break;
									case 2: if(sprite_index != E2F_stow_UR){ sprite_index = E2F_stow_UR; } break;
									case 3: if(sprite_index != E2F_stow_UL){ sprite_index = E2F_stow_UL; } break;
								}
								}
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
							
							if(AI_intention == 0){
								var chance = irandom_range(0,1);
								if(chance == 1){
									AI_intention = 1;
									AI_wait = 45; //24
									image_speed = 1;
									if(appear == 0){ // M
									switch(facing){
										case 0: if(sprite_index != E2M_draw_DR){ sprite_index = E2M_draw_DR; } break;
										case 1: if(sprite_index != E2M_draw_DL){ sprite_index = E2M_draw_DL; } break;
										case 2: if(sprite_index != E2M_draw_UR){ sprite_index = E2M_draw_UR; } break;
										case 3: if(sprite_index != E2M_draw_UL){ sprite_index = E2M_draw_UL; } break;
									}
									}else{ // F
									switch(facing){
										case 0: if(sprite_index != E2F_draw_DR){ sprite_index = E2F_draw_DR; } break;
										case 1: if(sprite_index != E2F_draw_DL){ sprite_index = E2F_draw_DL; } break;
										case 2: if(sprite_index != E2F_draw_UR){ sprite_index = E2F_draw_UR; } break;
										case 3: if(sprite_index != E2F_draw_UL){ sprite_index = E2F_draw_UL; } break;
									}
									}
									//show_debug_message(string(id)+" got angry, dist="+string(dist));
								}else{
									AI_wait = 8;
								}
							}
						}else{
							// outside melee range and standby range, move to standby range
							var angl = point_direction(target.x,target.y,x,y);
							if(dist < 56){ // 48
								if(AI_intention != 1){
									//show_debug_message("out range, moving outwards to ("+string(round(target.x+lengthdir_x(50,angl)))+","+string(round(target.y+lengthdir_y(50,angl)))+"), dist="+string(dist));
									AI_targ_x = target.x+round(lengthdir_x(70,angl)); //60
									AI_targ_y = target.y+round(lengthdir_y(70,angl)); //60
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
								AI_targ_x = target.x+round(lengthdir_x(64,angl)); //56
								AI_targ_y = target.y+round(lengthdir_y(64,angl)); //56
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
		
		if(x_spd != 0 || y_spd != 0){
			// sprite update
			image_speed = 1;
			if(appear == 0){ // M
			switch(facing){
				case 0: if(sprite_index != E1M_run_DR){ sprite_index = E1M_run_DR; step_wait = 10; } break;
				case 1: if(sprite_index != E1M_run_DL){ sprite_index = E1M_run_DL; step_wait = 10; } break;
				case 2: if(sprite_index != E1M_run_UR){ sprite_index = E1M_run_UR; step_wait = 10; } break;
				case 3: if(sprite_index != E1M_run_UL){ sprite_index = E1M_run_UL; step_wait = 10; } break;
			}
			}else{ // F
			switch(facing){
				case 0: if(sprite_index != E1F_run_DR){ sprite_index = E1F_run_DR; step_wait = 10; } break;
				case 1: if(sprite_index != E1F_run_DL){ sprite_index = E1F_run_DL; step_wait = 10; } break;
				case 2: if(sprite_index != E1F_run_UR){ sprite_index = E1F_run_UR; step_wait = 10; } break;
				case 3: if(sprite_index != E1F_run_UL){ sprite_index = E1F_run_UL; step_wait = 10; } break;
			}
			}
			// particle
			if(step_wait > 0){
				step_wait -= 1;
			}
			if(place_meeting(x,y,Lake) && step_wait == 0 && (GameControl.snow_lvl == 0 || 
				(GameControl.snow_lvl == 1 && GameControl.weather_timers[1] > 120))){
				// splash
				part_particles_create(part_sys,x,y+8,part_types[| 5],1);
				step_wait = 10;
			}else if(!place_meeting(x,y,Lake) && step_wait == 0 && ((GameControl.snow_lvl == 1 && 
				GameControl.weather_timers[1] <= 120) || GameControl.snow_lvl == 2)){
				// footprint
				part_particles_create(part_sys,x,y+8,part_types[| 6],1);
				step_wait = 10;
			}
		}else if((AI_state != 1 || slash == noone) && AI_intention != 1){
			image_speed = 1;
			if(appear == 0){ // M
			switch(facing){
				case 0: if(sprite_index != E1M_idle_DR){ sprite_index = E1M_idle_DR; } break;
				case 1: if(sprite_index != E1M_idle_DL){ sprite_index = E1M_idle_DL; } break;
				case 2: if(sprite_index != E1M_idle_UR){ sprite_index = E1M_idle_UR; } break;
				case 3: if(sprite_index != E1M_idle_UL){ sprite_index = E1M_idle_UL; } break;
			}
			}else{ // F
			switch(facing){
				case 0: if(sprite_index != E1F_idle_DR){ sprite_index = E1F_idle_DR; } break;
				case 1: if(sprite_index != E1F_idle_DL){ sprite_index = E1F_idle_DL; } break;
				case 2: if(sprite_index != E1F_idle_UR){ sprite_index = E1F_idle_UR; } break;
				case 3: if(sprite_index != E1F_idle_UL){ sprite_index = E1F_idle_UL; } break;
			}
			}
		}
		
		// get angle
		var angle = 300;
		if(AI_state == 0){
			angle = point_direction(0,0,x_spd,y_spd);
		}else if(target != noone){
			angle = point_direction(x,y,target.x,target.y);
		}
		// get facing from angle
		if(angle >= 270 && angle < 360){
			facing = 0;
		}else if(angle >= 180 && angle < 270){
			facing = 1;
		}else if(angle >= 0 && angle < 90){
			facing = 2;
		}else if(angle >= 90 && angle < 180){
			facing = 3;
		}
	}
}else{
	if(appear == 0){ // M
		switch(facing){
			case 0: if(sprite_index != E1M_die_R){ sprite_index = E1M_die_R; } break;
			case 1: if(sprite_index != E1M_die_L){ sprite_index = E1M_die_L; } break;
			case 2: if(sprite_index != E1M_die_R){ sprite_index = E1M_die_R; } break;
			case 3: if(sprite_index != E1M_die_L){ sprite_index = E1M_die_L; } break;
		}
		}else{ // F
		switch(facing){
			case 0: if(sprite_index != E1F_die_R){ sprite_index = E1F_die_R; } break;
			case 1: if(sprite_index != E1F_die_L){ sprite_index = E1F_die_L; } break;
			case 2: if(sprite_index != E1F_die_R){ sprite_index = E1F_die_R; } break;
			case 3: if(sprite_index != E1F_die_L){ sprite_index = E1F_die_L; } break;
		}
		}
}

// knockback footprint sliding
if(!place_meeting(x,y,Lake) && (int64(x_knock) != 0 || int64(y_knock) != 0) && HP > 0 && 
	((GameControl.snow_lvl == 1 && GameControl.weather_timers[1] <= 120) || GameControl.snow_lvl == 2)){
	// footprint
	part_particles_create(part_sys,x-3,y+8,part_types[| 6],1);
	part_particles_create(part_sys,x+3,y+8,part_types[| 6],1);
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
x = max(8,x);
x = min(x,room_width-8);
y = max(8,y);
y = min(y,room_height-8);

}