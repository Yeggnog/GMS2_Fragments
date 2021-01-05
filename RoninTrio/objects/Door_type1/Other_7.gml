if(sprite_index == Gate1_open){
	curr_state = true;
	image_index = 5;
	image_speed = 0;
	x = (origin_x+16);
}
if(sprite_index == Gate1_close){
	curr_state = false;
	image_index = 5;
	image_speed = 0;
	x = origin_x;
}