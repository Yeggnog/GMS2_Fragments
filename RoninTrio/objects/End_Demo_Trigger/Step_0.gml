if(place_meeting(x,y,Player)){
	collided = true;
}
if(inputs[13,0] > 0 && collided){
	// quit game
	collided = false;
	GameControl.menu_index = 0;
	paused = true;
	GameControl.curs_x = 0;
	GameControl.curs_y = 0;
	GameControl.menu_delay = 4;
	room_goto(Title);
}