if(place_meeting(origin_x,y+4,Player) || place_meeting(origin_x,y-4,Player)){
	goal_state = true;
}else{
	goal_state = false;
}

if(curr_state != goal_state){
	if(curr_state == true){
		if(sprite_index != Gate2_close){
			sprite_index = Gate2_close;
			image_speed = spd;
			image_index = 0;
		}
	}else{
		if(sprite_index != Gate2_open){
			sprite_index = Gate2_open;
			image_speed = spd;
			image_index = 0;
		}
	}
}