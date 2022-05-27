/// @description Move and fire
if(!game_paused){

// control handling
var x_spd = 0;
var y_spd = 0;
if(flight_lead == self){
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
	if(control_input("form1", "pressed") == 1){
		form_id = 0;
	}else if(control_input("form2", "pressed") == 1){
		form_id = 1;
	}else if(control_input("form3", "pressed") == 1){
		form_id = 2;
	}else if(control_input("form4", "pressed") == 1){
		form_id = 3;
	}
	
}else if(flight_lead != noone){
	// move into formation
	
	// get position from formation
	switch(flight_lead.form_id){
		case 0:
			// snake
			form_targ_x = flight_lead.trail_pos[flight_pos-1][0];
			form_targ_y = flight_lead.trail_pos[flight_pos-1][1];
		break;
		case 1:
			// line	
			offsets = [-48, 48, 96];
			form_targ_x = flight_lead.x + offsets[flight_pos-1];
			form_targ_y = flight_lead.y;
		break;
		case 2:
			// square
			offsets = [[0, 48], [48, 0], [48, 48]];
			form_targ_x = flight_lead.x + offsets[flight_pos-1][0];
			form_targ_y = flight_lead.y + offsets[flight_pos-1][1];
		break;
		case 3:
			// diamond
			offsets = [[-48, 48], [0, 96], [48, 48]];
			form_targ_x = flight_lead.x + offsets[flight_pos-1][0];
			form_targ_y = flight_lead.y + offsets[flight_pos-1][1];
		break;
	}
	
	// set transition vars
	if(form_update){
		form_update = false;
		trans_angle = point_direction(form_targ_x, form_targ_y, x, y);
		trans_dist = sqrt(power((x-form_targ_x),2) + power((y-form_targ_y),2));
		if(trans_prog == 0){ // change?
			trans_prog = 10;
		}
	}
	
	// move to target
	if(trans_prog > 0){
		trans_prog -= 1;
		x_spd = (form_targ_x + lengthdir_x(trans_dist * (trans_prog/10), trans_angle)) - x;
		y_spd = (form_targ_y + lengthdir_y(trans_dist * (trans_prog/10), trans_angle)) - y;
	}else{
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
}

// fire
if(fire_timer > 0){
	fire_timer -= 1;
}else if(control_input("fire", "check") == 1){
	fire_timer = fire_delay;
	var bullet = instance_create_layer(x, y-16, layer, Bullet_parent);
	bullet.dmg = dmg;
	bullet.team = team;
}

// move
var stored_pos = [x,y];
x += x_spd;
y += y_spd;

// clamp position
x = max(x, 8);
x = min(x, room_width-8);
y = max(y, 8);
y = min(y, room_height-8);

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
		}
	}
	ds_list_destroy(collided);
}

if(hp == 0){
	instance_destroy(); // change for player
}

// -- end inherit --

// trail tracking
if(flight_lead == self && sqrt(power((stored_pos[0] - trail_pos[0][0]),2) + power((stored_pos[1] - trail_pos[0][1]),2)) >= trail_store_dist){
	// store position in array
	//show_debug_message("Trying to add in position ("+string(stored_pos[0])+", "+string(stored_pos[1])+")");
	for(var i=array_length(trail_pos)-1; i>0; i--){
		trail_pos[i] = trail_pos[i-1];
		//show_debug_message("");
	}
	trail_pos[0] = stored_pos;
}

}
