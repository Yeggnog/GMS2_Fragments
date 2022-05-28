/// @description Scroll and shake

// scroll screen
if(state == 0 && !game_paused){
	// scroll until we hit the end of the room
	if(y > 384){
		y -= scroll_speed;
	}
}

// shake screen
if(shake_duration > 0){
	shake_duration -= 1;
	
	// offset from existing
	shake_offset_x = random_range(-31, 31);
	shake_offset_y = random_range(-31, 31);
	//show_debug_message("Got new offsets "+string(shake_offset_x)+" and "+string(shake_offset_y));
	/*
	var shake_dist = sqrt( power(shake_offset_x, 2) + power(shake_offset_y, 2) );
	if(shake_dist > 32){
		var shake_ang = point_direction(0, 0, shake_offset_x, shake_offset_y);
		shake_offset_x = lengthdir_x(32, shake_ang);
		shake_offset_y = lengthdir_y(32, shake_ang);
	}
	*/
}else{
	// reset
	shake_offset_x = 0;
	shake_offset_y = 0;
}
// actual reposition
follower.x = x + shake_offset_x;
follower.y = y + shake_offset_y;
if(shake_duration > 0){
	show_debug_message("Set y to ("+string(y)+") + ("+string(shake_offset_y)+") = ("+string(y+shake_offset_y)+")");
	show_debug_message("Result value "+string(follower.y));
}

