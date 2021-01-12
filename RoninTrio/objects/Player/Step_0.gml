if(!paused){
	
// temps
var x_spd = 0;
var y_spd = 0;

// hit flash
if(hit_flash > 0){
	hit_flash -= 1;
}

// facing
if(inputs[12,2] == 1){
	// mouse position
	angle = point_direction(x,y,mouse_x,mouse_y);
}else if(inputs[12,2] == 3){
	// gamepad stick
	var num = gamepad_get_device_count();
	for(var dev=0; dev<num; dev++){
		if(gamepad_is_connected(dev) && (gamepad_axis_value(dev,inputs[12,1]) != 0.0 || gamepad_axis_value(dev,inputs[12,3]) != 0.0)){
			angle = point_direction(0, 0, gamepad_axis_value(dev,inputs[12,1]), gamepad_axis_value(dev,inputs[12,3]));
		}
	}
}else{
	// base on planned movement
	var x_comp = 0;
	var y_comp = 0;
	if(inputs[0,0] > 0){
		// left
		x_comp += -2;
	}
	if(inputs[1,0] > 0){
		// right
		x_comp += 2;
	}
	if(inputs[2,0] > 0){
		// up
		y_comp += -2;
	}
	if(inputs[3,0] > 0){
		// down
		y_comp += 2;
	}
	if(x_comp != 0 || y_comp != 0){
		angle = point_direction(0,0,x_comp,y_comp);
	}
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

// boost level
if(instance_exists(GameControl)){
	if(boost_active){
		if(boost == 0){
			// cinematic finish
			if(kill_list_wait == 0){
				if(ds_list_size(kill_list) > 0){
					if(cinematic_finish == false){
						cinematic_finish = true;
					}
					var inst = kill_list[| 0];
					// particle
					part_particles_create(part_sys,inst.x,inst.y,part_types[| 1],1);
					kill_list_wait = 6;
					ds_list_delete(kill_list, 0);
				}else{
					boost_active = false;
					cinematic_finish = false;
				}
			}else{
				kill_list_wait -= 1;
			}
		}else if(boost > 0){
			boost -= 1;
		}
	}else if(boost < boost_max){
		boost += 1;
	}
}

// afterimages
if(afterimg_lag > 0){
	afterimg_lag -= 1;
}else{
	for(var i=5; i>0; i--){
		afterimg[i,0] = afterimg[i-1,0];
		afterimg[i,1] = afterimg[i-1,1];
		afterimg[i,2] = afterimg[i-1,2];
		afterimg[i,3] = afterimg[i-1,3];
		afterimg[i,4] = afterimg[i-1,4];
		afterimg[i,5] = afterimg[i-1,5];
	}
	// scaling (cap at 4)
	var xscale = 1.0;
	var yscale = 1.0;
	var knock_dir = point_direction(0,0,x_knock,y_knock);
	if((knock_dir > 45 && knock_dir <= 135) || (knock_dir > 225 && knock_dir <= 315)){
		yscale = 1+(abs(y_knock)/4);
	}else{
		xscale = 1+(abs(x_knock)/4);
	}
	afterimg[0,0] = x;
	afterimg[0,1] = y;
	afterimg[0,2] = sprite_index;
	afterimg[0,3] = image_index;
	afterimg[0,4] = xscale;
	afterimg[0,5] = yscale;
	afterimg_lag = 1;
}

// animation wait
if(anim_wait > 0){
	anim_wait -= 1;
}

// movement controls
if(int64(x_knock) == 0 && int64(y_knock) == 0 && HP > 0 && cinematic_finish == false && anim_wait == 0){
	if(inputs[0,0] > 0){
		// left
		x_spd += -2;
	}
	if(inputs[1,0] > 0){
		// right
		x_spd += 2;
	}
	if(inputs[2,0] > 0){
		// up
		y_spd += -2;
	}
	if(inputs[3,0] > 0){
		// down
		y_spd += 2;
	}
	if(x_spd != 0 || y_spd != 0){
		// sprite update
		switch(facing){
			case 0: if(sprite_index != Player_run_DR){ sprite_index = Player_run_DR; step_wait = 10; } break;
			case 1: if(sprite_index != Player_run_DL){ sprite_index = Player_run_DL; step_wait = 10; } break;
			case 2: if(sprite_index != Player_run_UR){ sprite_index = Player_run_UR; step_wait = 10; } break;
			case 3: if(sprite_index != Player_run_UL){ sprite_index = Player_run_UL; step_wait = 10; } break;
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
	}else{
		// sprite update
		switch(facing){
			case 0: if(sprite_index != Player_idle_DR){ sprite_index = Player_idle_DR; } break;
			case 1: if(sprite_index != Player_idle_DL){ sprite_index = Player_idle_DL; } break;
			case 2: if(sprite_index != Player_idle_UR){ sprite_index = Player_idle_UR; } break;
			case 3: if(sprite_index != Player_idle_UL){ sprite_index = Player_idle_UL; } break;
		}
	}
	if(inputs[9,0] > 0 && boost > 0 && instance_exists(GameControl) && !boost_active){
		// riptide boost
		boost_active = true;
		GameControl.boost_ring_age = 20;
		GameControl.boost_ring_x = x;
		GameControl.boost_ring_y = y;
	}
	/*
	if(inputs[11,0] > 0){
		// projectile [DEBUG]
		var shot = instance_create_layer(x+lengthdir_x(18,angle),y+lengthdir_y(18,angle),layer,ProjectileAttack);
		shot.dmg = 3;
		shot.force = 0.75;
		shot.dir = angle;
		shot.spd = 4;
		shot.life = 5;
		shot.sprite_index = Crossbow_Bolt;
		anim_wait = 4;
	}
	*/
	if(inputs[8,0] > 0 && slash == noone){
		// slash
		slash = instance_create_layer(x+lengthdir_x(18,angle),y+lengthdir_y(18,angle),layer,MeleeAttack);
		slash.owner = id;
		slash.dmg = 2; //12
		slash.force = 0.75;
		slash.dir = angle;
		slash.rad = 18;
		slash.life = 6;
		slash.image_angle = angle;
		// sprite change
		switch(facing){
			case 0: if(sprite_index != Player_slash1_DR){ sprite_index = Player_slash1_DR; } break;
			case 1: if(sprite_index != Player_slash1_DL){ sprite_index = Player_slash1_DL; } break;
			case 2: if(sprite_index != Player_slash1_UR){ sprite_index = Player_slash1_UR; } break;
			case 3: if(sprite_index != Player_slash1_UL){ sprite_index = Player_slash1_UL; } break;
		}
		slash.sprite_index = Particles_Slash1;
		anim_wait = 7; //4
	}
}
if(HP <= 0){
	switch(facing){
		case 0: if(sprite_index != Player_die_R){ sprite_index = Player_die_R; } break;
		case 1: if(sprite_index != Player_die_L){ sprite_index = Player_die_L; } break;
		case 2: if(sprite_index != Player_die_R){ sprite_index = Player_die_R; } break;
		case 3: if(sprite_index != Player_die_L){ sprite_index = Player_die_L; } break;
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

// handle overflow
x = max(8,x);
x = min(x,room_width-8);
y = max(8,y);
y = min(y,room_height-8);

}