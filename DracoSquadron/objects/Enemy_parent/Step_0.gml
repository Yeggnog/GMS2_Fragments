/// @description Insert description here
// You can write your code in this editor

if(!game_paused){

var vw = camera_get_view_width(view_camera[0]);
var vh = camera_get_view_height(view_camera[0]);

if(AI_active){
	
time += 1;

// i-frames
if(i_frames > 0){
	i_frames -= 1;
}

// collisions
if(place_meeting(x, y, Bullet_parent)){
	var collided = ds_list_create();
	if(instance_place_list(x, y, Bullet_parent, collided, false)){
		for(var i=0; i<ds_list_size(collided); i++){
			var inst = collided[|i];
			if(i_frames == 0 && inst.team != team){
				hp -= inst.dmg;
				hp = max(hp, 0);
				if(AI_type == "heater"){
					dmg += 1;
					i_frames = 2;
				}else{
					i_frames = 8; // default 8, increase for dragons
				}
				with(inst){
					// put particle here
					instance_destroy();
				}
			}
		}
	}
	ds_list_destroy(collided);
}

if(hp == 0 && AI_type != "heater"){
	// fill gauge for aux dragons
	var fill = round(value/3);
	for(var i=0; i<4; i++){
		var drg = Game_control.dragon_inst_ids[i];
		if(drg != noone && drg != drg.flight_lead){
			drg.sp_meter += fill;
		}
	}
	// don't break AI
	if(AI_type == "sweep" && flight_lead == id){
		// pass off flight lead
		var best_pos = 42;
		var best_inst = noone;
		for(var i=0; i<instance_number(Enemy_parent); i++){
			var inst = instance_find(Enemy_parent, i);
			if(inst != noone && inst.AI_type == "sweep" && inst.flight_lead == id){
				if(inst.flight_pos < best_pos){
					best_pos = flight_pos;
					best_inst = inst;
				}
			}
		}
		for(var i=0; i<instance_number(Enemy_parent); i++){
			var inst = instance_find(Enemy_parent, i);
			if(inst != noone && inst.AI_type == "sweep"){
				inst.flight_lead = best_inst;
				inst.flight_pos -= 1;
			}
		}
	}else if(AI_type == "blaster" && flight_lead == id){
		// continue firing
		for(var i=0; i<instance_number(Enemy_parent); i++){
			var inst = instance_find(Enemy_parent, i);
			if(inst != noone && inst.AI_type == "blaster" && inst.flight_pos == flight_pos+1){
				inst.flight_lead = inst;
				inst.shot_delay += shot_delay;
			}
		}
	}
	instance_destroy();
}

// AI behavior
if(AI_type == "sweep"){
	// sine sweep
	if(flight_lead == id){
		// leader
		
		// save position
		if(sqrt(power(x-saved_pos[0][0], 2) + power(y-saved_pos[0][1], 2)) >= save_pos_dist){
				for(var i=4; i>0; i--){
					saved_pos[i] = saved_pos[i-1];
				}
				saved_pos[0] = [x,y];
		}
		
		// move
		x = start_x + (sin(time/220) * (room_width/2));
		y = start_y - (cos(time/220) * (room_width/2));
	}else if(instance_find(flight_lead,0) != noone){
		// follower
		x = flight_lead.saved_pos[flight_pos-1][0];
		y = flight_lead.saved_pos[flight_pos-1][1];
	}else{
		// dummy
		y += 2;
	}
	
	// fire shot
	if(shot_delay > 0){
		shot_delay -= 1;
	}else{
		var bullet = instance_create_layer(x, y+16, layer, Bullet_parent);
		bullet.dmg = dmg;
		bullet.move_angle = 270;
		bullet.team = team;
		bullet.move_speed = 4;
		shot_delay = 60;
	}
}else if(AI_type == "heater"){
	// death
	if(dmg >= 20){
		var fill = round(value/3);
		for(var i=0; i<4; i++){
			var drg = Game_control.dragon_inst_ids[i];
			if(drg != noone && drg != drg.flight_lead){
				drg.sp_meter += fill;
			}
		}
		instance_destroy();
	}
	
	// heating / regen
	if(shot_delay > 0){
		shot_delay -= 1;
	}else{
		shot_delay = 10;
		if(dmg > 0){
			dmg -= 1;
		}
	}
}else if(AI_type == "shriek"){
	if(instance_number(Dragon_parent) > 0){
		// get charge target
		var targ_x = 0;
		var targ_y = 0;
		for(var i=0; i<instance_number(Dragon_parent); i++){
			var drg = instance_find(Dragon_parent, i);
			if(drg != noone){
				targ_x += drg.x;
				targ_y += drg.y;
			}
		}
		targ_x /= instance_number(Dragon_parent);
		targ_y /= instance_number(Dragon_parent);
		
		// charge in homing arc
		var best_angle = point_direction(x, y, targ_x, targ_y);
		// get alt angle
		var alt_best1 = best_angle - 360;
		var alt_best2 = best_angle + 360;
	
		if(abs(alt_best1 - move_angle) < abs(best_angle - move_angle)){
			// alt 1 better, rotate right
			move_angle -= 2;
		}else if(abs(alt_best2 - move_angle) < abs(best_angle - move_angle)){
			// alt 2 better, rotate left
			move_angle += 2;
		}else{
			// rotate normally
			if(best_angle > move_angle){
				move_angle += 2;
			}else if(best_angle < move_angle){
				move_angle -= 2;
			}
		}
	
		// corrections
		if(move_angle > 360){
			move_angle -= 360;
		}
		if(move_angle < 0){
			move_angle += 360;
		}
		
	}
	
	// move
	x += lengthdir_x(6, move_angle);
	y += lengthdir_y(6, move_angle);
}else{
	// move
	if(y >= Camera_parent.y-(vh/2)+42 && instance_exists(Camera_parent)){
		y -= Camera_parent.scroll_speed;
	}
	
	if(id == flight_lead){
		// up for firing
		if(shot_delay > 0){
			shot_delay -= 1;
		}else if(shot_delay == 0){
			// fire
			var laser = instance_create_layer(x, y+16, layer, Laser); // change
			laser.offset = [0,16];
			laser.dmg = dmg;
			laser.parent = id;
			laser.team = team;
			shot_delay = -1;
			// pass off to others
			for(var i=0; i<array_length(flight); i++){
				if(instance_find(flight[i],1) != noone && flight[i].flight_pos == flight_pos+1){
					flight[i].flight_lead = flight[i];
				}
			}
		}
	}
}

// destroy if offscreen
if(x >= Camera_parent.x+(vw/2)-32 && x <= Camera_parent.x+(vw/2)-32 
&& y >= Camera_parent.y+(vh/2)-32 && y <= Camera_parent.y+(vh/2)-32){
	show_debug_message("destroyed self for being offscreen");
	instance_destroy();
}

}else{
	// only activate when barely offscreen
	if(x >= Camera_parent.x-(vw/2)-16 && x <= Camera_parent.x+(vw/2)+16 
	&& y >= Camera_parent.y-(vh/2)-16 && y <= Camera_parent.y+(vh/2)+16){
		AI_active = true;
		if(AI_type == "sweep"){
			shot_delay = 60;
		}else if(AI_type = "heater"){
			dmg = 0;
		}else if(AI_type == "blaster"){
			shot_delay = 40;
		}
		show_debug_message("activated");
	}
}

}
