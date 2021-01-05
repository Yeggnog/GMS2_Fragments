if(place_meeting(x,y,ProjectileAttack) || place_meeting(x,y,MeleeAttack)){
	if(!flag){
		goal_state = !(goal_state);
		if(linked != noone){
			linked.goal_state = !(linked.goal_state);
		}
		flag = true;
	}
}else{
	flag = false;
}

if(curr_state != goal_state){
	if(curr_state == true){
		if(sprite_index != Switch_deactiv){
			sprite_index = Switch_deactiv;
			image_speed = spd;
			image_index = 0;
		}
	}else{
		if(sprite_index != Switch_activate){
			sprite_index = Switch_activate;
			image_speed = spd;
			image_index = 0;
		}
	}
}