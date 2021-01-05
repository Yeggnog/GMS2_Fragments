if(curr_state != goal_state){
	if(curr_state == true){
		if(sprite_index != Gate1_close){
			sprite_index = Gate1_close;
			image_speed = spd;
			image_index = 0;
		}
	}else{
		if(sprite_index != Gate1_open){
			sprite_index = Gate1_open;
			image_speed = spd;
			image_index = 0;
		}
	}
}