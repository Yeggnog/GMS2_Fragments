// key inputs for weather FX

// wind
if(keyboard_check_pressed(ord("1"))){
	if(wind_dir == 0){
		wind_dir = random_range(0,360);
	}
	wind_spd = random_range(1.6,4);
	weather_timers[0] = 240;
}

// updates

// wind
if(weather_timers[0] > 0){
	weather_timers[0] -= 1;
}else{
	// cp
	if(wind_spd > 0){
		wind_spd = lerp(wind_spd, 0, 0.2);
	}else{
		wind_dir = 0;
	}
	// cp
}

// pause / unpause
if(pause_wait == 0){
	if(paused){
		paused = false;
	}else{
		paused = true;
	}
	pause_wait = -1;
}else if(pause_wait > 0){
	pause_wait -= 1;
}

// pause control
if(keyboard_check_pressed(vk_escape) && pause_wait == -1){
	// pause
	pause_wait = 12;
}

// cursor offset
if(curs_offset_x > 0){
	curs_offset_x -= 2;
}else if(curs_offset_x < 0){
	curs_offset_x += 2;
}
if(curs_offset_y > 0){
	curs_offset_y -= 10;
}else if(curs_offset_y < 0){
	curs_offset_y += 10;
}

// menu controls
if(paused){
	if(curs_wait > 0){
		curs_wait -= 1;
	}else{
		if(keyboard_check(ord("W"))){
			// up
			if(curs_y > 0){
				curs_y -= 1;
				curs_offset_x -= 4;
				curs_offset_y += 20;
			}else{
				curs_y = 4;
				curs_offset_x += 20;
				curs_offset_y -= 80;
			}
			curs_wait = 6;
		}
		if(keyboard_check(ord("S"))){
			// down
			if(curs_y < 4){
				curs_y += 1;
				curs_offset_x += 4;
				curs_offset_y -= 20;
			}else{
				curs_y = 0;
				curs_offset_x -= 20;
				curs_offset_y += 80;
			}
			curs_wait = 6;
		}
	}
}