// update key inputs
for(var i=0; i<array_length(inputs); i++){
	if(inputs[i,0] > 0){
		inputs[i,0] -= 1;
	}
	if(inputs[i,3] == 1){
		// press check
		var flag = false;
		switch(inputs[i,2]){
			case 0: flag = (flag || keyboard_check_pressed(inputs[i,1])) break;
			case 1: flag = (flag || mouse_check_button_pressed(inputs[i,1])) break;
			case 2: 
			// gamepad button
			for(var dev=0; dev<gamepad_get_device_count(); dev++){
				if(gamepad_is_connected(dev)){
					flag = (flag || gamepad_button_check_pressed(dev,inputs[i,1]));
				}
			}
			break;
			case 3: 
			// gamepad axis
			for(var dev=0; dev<gamepad_get_device_count(); dev++){
				if(gamepad_is_connected(dev)){
					flag = (flag || abs(gamepad_axis_value(dev,inputs[i,1])) >= gamepad_get_axis_deadzone(dev));
				}
			}
			break;
		}
		if(flag){
			inputs[i,0] = 4;
		}
	}else{
		// constant check
		var flag = false;
		switch(inputs[i,2]){
			case 0: flag = (flag || keyboard_check(inputs[i,1])) break;
			case 1: flag = (flag || mouse_check_button(inputs[i,1])) break;
			case 2: 
			// gamepad button
			for(var dev=0; dev<gamepad_get_device_count(); dev++){
				if(gamepad_is_connected(dev)){
					flag = (flag || gamepad_button_check(dev,inputs[i,1]));
				}
			}
			break;
			case 3: 
			// gamepad axis
			for(var dev=0; dev<gamepad_get_device_count(); dev++){
				if(gamepad_is_connected(dev)){
					flag = (flag || abs(gamepad_axis_value(dev,inputs[i,1])) >= gamepad_get_axis_deadzone(dev));
				}
			}
			break;
		}
		if(flag){
			inputs[i,0] = 1;
		}
	}
}

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

// boost ring
if(boost_ring_age > 0){
	boost_ring_age -= 1;
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
if(inputs[10,0] > 0 && pause_wait == -1){
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
		if(inputs[2,0] > 0){
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
		if(inputs[3,0] > 0){
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
		if(inputs[8,0] > 0){
			// confirm
			if(curs_y == 0 && pause_wait == -1){
				// resume
				pause_wait = 12;
			}else if(curs_y == 3 && pause_wait == -1){
				// restart room [DEBUG]
				pause_wait = 12;
				room_restart();
				curs_y = 0;
				boost_active = false;
			}
		}
	}
}