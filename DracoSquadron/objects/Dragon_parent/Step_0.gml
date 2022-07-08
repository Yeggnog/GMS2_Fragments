/// @description Move and fire
if(!game_paused){
	
/*if(saved_lead != flight_lead){
	show_debug_message("flight_lead changed to "+string(flight_lead));
	saved_lead = flight_lead;
}*/

// control handling

// screenshake test
if(keyboard_check_pressed(ord("Q"))){
	Camera_parent.shake_duration += 15;
}

var x_spd = 0;
var y_spd = 0;
var vw = camera_get_view_width(view_camera[0]);
var vh = camera_get_view_height(view_camera[0]);

if(flight_lead == id){
	
	//show_debug_message("-");
	
	// updates
	if(trans_prog == 0){
		form_targ_x = x;
		form_targ_y = y;
		trans_dist = 0;
		trans_angle = 0;
	}
	
	// control the wing
	if(control_binds[0] == "Mouse"){
		// mouse movement
		if(distance_to_point(mouse_x, mouse_y) > move_speed){
			// home in
			x_spd = lengthdir_x(move_speed, point_direction(x, y, mouse_x, mouse_y));
			y_spd = lengthdir_y(move_speed, point_direction(x, y, mouse_x, mouse_y)) * vert_speed_distort;
		}else{
			// warp
			x_spd = mouse_x - x;
			y_spd = mouse_y - y;
		}
	}else{
		// key / axis movement
		if(control_input("move_left", "check") == 1){
			x_spd -= move_speed;
		}
		if(control_input("move_right", "check") == 1){
			x_spd += move_speed;
		}
		if(control_input("move_up", "check") == 1){
			y_spd -= move_speed * vert_speed_distort;
		}
		if(control_input("move_down", "check") == 1){
			y_spd += move_speed * vert_speed_distort;
		}
	}
	
	// swap formation
	var stored_form = form_id;
	
	if(control_input("form1", "pressed") == 1){
		form_id = 0;
	}else if(control_input("form2", "pressed") == 1){
		form_id = 1;
	}else if(control_input("form3", "pressed") == 1){
		form_id = 2;
	}else if(control_input("form4", "pressed") == 1){
		form_id = 3;
	}
	
	// update
	if(form_id != stored_form){
		for(var i=1; i<4; i++){
			Game_control.dragon_inst_ids[i].form_update = true;
		}
	}
	
	// rotate flight lead
	if(control_input("rot_left", "pressed") == 1 && trans_prog == 0){
		//
		show_debug_message("rotated left");
		
		// rotate flight positions
		// assign new flight lead
		// start transition
		
		//show_debug_message("flight lead is "+string(flight_lead));
		//game_set_speed(6, gamespeed_fps);
		
		var old_lead = id;
		for(var i=0; i<4; i++){
			if(Game_control.dragon_inst_ids[i].flight_pos == 1){
				flight_lead = Game_control.dragon_inst_ids[i];
				//show_debug_message("set flight_lead to ");
			}
		}
		for(var i=0; i<4; i++){
			Game_control.dragon_inst_ids[i].flight_lead = flight_lead;
			
			if(Game_control.dragon_inst_ids[i].flight_pos > 0){
				Game_control.dragon_inst_ids[i].flight_pos -= 1;
			}else{
				Game_control.dragon_inst_ids[i].flight_pos = 3;
			}
			
			Game_control.dragon_inst_ids[i].form_update = true;
			Game_control.dragon_inst_ids[i].trans_prog = 10;
		}
		for(var i=0; i<3; i++){
			flight_lead.trail_pos[i] = old_lead.trail_pos[i];
		}
		
		// get transition for new flight lead
		flight_lead.trans_dist = sqrt(power((old_lead.x - flight_lead.x), 2) + power((old_lead.y - flight_lead.y), 2));
		flight_lead.trans_angle = point_direction(old_lead.x, old_lead.y, flight_lead.x, flight_lead.y);
		flight_lead.form_targ_x = old_lead.x;
		flight_lead.form_targ_y = old_lead.y;
		//show_debug_message("set trans_dist to "+string(trans_dist)+" and trans_dir to "+string(trans_angle));
		//flight_lead.trans_prog = 10;
		flight_lead.form_id = old_lead.form_id;
		
		/*
		// set transition vars
		switch(flight_lead.form_id){
			case 0:
				// snake
				form_targ_x = flight_lead.trail_pos[flight_pos-1][0];
				form_targ_y = flight_lead.trail_pos[flight_pos-1][1];
			break;
			case 1:
				// line	
				offsets = [0, -48, 48, 96];
				form_targ_x = flight_lead.form_targ_x + offsets[flight_pos];
				form_targ_y = flight_lead.form_targ_y;
			break;
			case 2:
				// square
				offsets = [[0, 0], [0, 48], [48, 0], [48, 48]]; // finish adding rotation
				form_targ_x = flight_lead.form_targ_x + offsets[flight_pos][0];
				form_targ_y = flight_lead.form_targ_y + offsets[flight_pos][1];
			break;
			case 3:
				// diamond
				offsets = [[0, 0], [-48, 48], [0, 96], [48, 48]];
				form_targ_x = flight_lead.form_targ_x + offsets[flight_pos][0];
				form_targ_y = flight_lead.form_targ_y + offsets[flight_pos][1];
			break;
		}
		
		trans_angle = point_direction(form_targ_x, form_targ_y, x, y);
		trans_dist = sqrt(power((form_targ_x-x),2) + power((form_targ_y-y),2));
		trans_prog = 10;
		*/
		
		
	}else if(control_input("rot_right", "pressed") == 1 && trans_prog == 0){
		//
		show_debug_message("rotated right(does nothing for now)");
		
		var old_lead = id;
		for(var i=0; i<4; i++){
			if(Game_control.dragon_inst_ids[i].flight_pos == 3){
				flight_lead = Game_control.dragon_inst_ids[i];
			}
		}
		for(var i=0; i<4; i++){
			Game_control.dragon_inst_ids[i].flight_lead = flight_lead;
			
			if(Game_control.dragon_inst_ids[i].flight_pos < 3){
				Game_control.dragon_inst_ids[i].flight_pos += 1;
			}else{
				Game_control.dragon_inst_ids[i].flight_pos = 0;
			}
			
			Game_control.dragon_inst_ids[i].form_update = true;
			Game_control.dragon_inst_ids[i].trans_prog = 10;
		}
		for(var i=0; i<3; i++){
			flight_lead.trail_pos[i] = old_lead.trail_pos[i];
		}
		
		// get transition for new flight lead
		flight_lead.trans_dist = sqrt(power((old_lead.x - flight_lead.x), 2) + power((old_lead.y - flight_lead.y), 2));
		flight_lead.trans_angle = point_direction(old_lead.x, old_lead.y, flight_lead.x, flight_lead.y);
		flight_lead.form_targ_x = old_lead.x;
		flight_lead.form_targ_y = old_lead.y;
		flight_lead.form_id = old_lead.form_id;
	}
	
}else if(flight_lead != noone){
	// move into formation
	
	//show_debug_message(string(id)+" is aux dragon and not flight lead");
	
	// get position from formation
	switch(flight_lead.form_id){
		case 0:
			// snake
			form_targ_x = flight_lead.trail_pos[flight_pos-1][0];
			form_targ_y = flight_lead.trail_pos[flight_pos-1][1];
		break;
		case 1:
			// line	
			offsets = [0, -48, 48, 96];
			form_targ_x = flight_lead.form_targ_x + offsets[flight_pos];
			form_targ_y = flight_lead.form_targ_y;
		break;
		case 2:
			// square
			offsets = [[0, 0], [0, 48], [48, 0], [48, 48]]; // finish adding rotation
			form_targ_x = flight_lead.form_targ_x + offsets[flight_pos][0];
			form_targ_y = flight_lead.form_targ_y + offsets[flight_pos][1];
		break;
		case 3:
			// diamond
			offsets = [[0, 0], [-48, 48], [0, 96], [48, 48]];
			form_targ_x = flight_lead.form_targ_x + offsets[flight_pos][0];
			form_targ_y = flight_lead.form_targ_y + offsets[flight_pos][1];
		break;
	}
	
	// set transition vars
	if(form_update){
		form_update = false;
		trans_angle = point_direction(form_targ_x, form_targ_y, x, y);
		trans_dist = sqrt(power((form_targ_x-x),2) + power((form_targ_y-y),2));
		trans_prog = 10;
	}
}

// move to target
if(trans_prog > 0){
	trans_prog -= 1;
	//show_debug_message(string(id)+" has target pos ("+string(form_targ_x)+", "+string(form_targ_y)+")");
	//x_spd = form_targ_x + (lengthdir_x(trans_dist, trans_angle) * (1 - (trans_prog/10)) ) - x;
	x_spd = form_targ_x + (lengthdir_x(trans_dist, trans_angle) * (trans_prog/10) ) - x;
	y_spd = form_targ_y + (lengthdir_y(trans_dist, trans_angle) * (trans_prog/10) ) - y;
	//y_spd = (form_targ_y + lengthdir_y(trans_dist * (trans_prog/10), trans_angle)) - y;
}else if(form_targ_x != x || form_targ_y != y){
	// homing like usual
	if(distance_to_point(form_targ_x, form_targ_y) > move_speed){
		// home in
		x_spd = lengthdir_x(move_speed, point_direction(x, y, form_targ_x, form_targ_y));
		y_spd = lengthdir_y(move_speed, point_direction(x, y, form_targ_x, form_targ_y));
	}else{
		// warp
		x_spd = form_targ_x - x;
		y_spd = form_targ_y - y;
	}
}

// fire
if(flight_lead.shot_type == "homing"){
	// charge up
	if(control_input("fire", "check") == 1 && fire_timer < 20){
		fire_timer += 1;
		show_debug_message("charging barrage, "+string(fire_timer)+"/20");
	}
	if(control_input("fire", "check") == 0){
		var num_shots = floor(fire_timer / 5) - 1;
		fire_timer = 0;
		if(num_shots > 0){
			show_debug_message("got a barrage of "+string(num_shots)+" shots");		
		}
		// select target (closest on x axis, has to be onscreen)
		var target = noone;
		for(var i=0; i<instance_number(Entity_parent); i++){
			var cand = instance_find(Entity_parent, i);
			if(cand != noone && cand.team != team 
			&& cand.x >= Camera_parent.x-(vw/2)+16 && cand.x <= Camera_parent.x+(vw/2)-16 
			&& cand.y >= Camera_parent.y-(vh/2)+16 && cand.y <= Camera_parent.y+(vh/2)-16){
				if(target == noone){
					target = cand;
				}else if(abs(cand.x-x) < abs(target.x-x)){
					target = cand;
				}
			}
		}
		// fire
		for(var i=0; i<num_shots; i++){
			//show_debug_message("firing barrage, shot "+string(i));
			var bullet = instance_create_layer(x, y-16, layer, Bullet_parent);
			bullet.dmg = 4;
			bullet.team = team;
			bullet.homing = true;
			bullet.homing_targ = target;
			bullet.move_angle = 135 - ((90/num_shots)*i);
			bullet.move_accel = 1;
			bullet.move_speed = 6;
		}
	}
}else{
	// fire normally
	if(fire_timer > 0){
		fire_timer -= 1;
	}else if(control_input("fire", "check") == 1){
		var bullet = instance_create_layer(x, y-16, layer, Bullet_parent);
		bullet.team = team;
		if(flight_lead.shot_type == "rapid"){
			bullet.sprite_index = Sprite3;
			bullet.dmg = 1;
			fire_timer = round(fire_delay/2);
		}else{
			bullet.dmg = dmg;
			fire_timer = fire_delay;
		}
	}
}

// move
var stored_pos = [x,y];
if(trans_prog > 0){
	stored_pos = [form_targ_x,form_targ_y];
}
x += x_spd;
y += y_spd;

// clamp position
x = max(x, Camera_parent.x-(vw/2)+16);
x = min(x, Camera_parent.x+(vw/2)-16);
y = max(y, Camera_parent.y-(vh/2)+16);
y = min(y, Camera_parent.y+(vh/2)-16);

// -- inherit from parent --

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
				i_frames = 8; // default 8, increase for dragons
			}
			// destroy shots
			with(inst){
				instance_destroy();
			}
		}
	}
	ds_list_destroy(collided);
}

if(hp == 0){
	instance_destroy(); // change for player
}

// -- end inherit --

// trail tracking
if(flight_lead == id && sqrt(power((stored_pos[0] - trail_pos[0][0]),2) + power((stored_pos[1] - trail_pos[0][1]),2)) >= trail_store_dist){
	// store position in array
	for(var i=array_length(trail_pos)-1; i>0; i--){
		trail_pos[i] = trail_pos[i-1];
	}
	trail_pos[0] = stored_pos;
}

}
