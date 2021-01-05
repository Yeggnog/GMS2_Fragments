// update key binds
if(control_mode == 1){
	// gamepad binds
	inputs[0,1] = gp_axislh; inputs[0,2] = 3; inputs[0,3] = 0; inputs[0,4] = 2; // left
	inputs[1,1] = gp_axislh; inputs[1,2] = 3; inputs[1,3] = 0; inputs[1,4] = 1; // right
	inputs[2,1] = gp_axislv; inputs[2,2] = 3; inputs[2,3] = 0; inputs[2,4] = 2; // up
	inputs[3,1] = gp_axislv; inputs[3,2] = 3; inputs[3,3] = 0; inputs[3,4] = 1; // down

	inputs[4,1] = gp_axislh; inputs[4,2] = 3; inputs[4,3] = 1; inputs[4,4] = 2; // left(press)
	inputs[5,1] = gp_axislh; inputs[5,2] = 3; inputs[5,3] = 1; inputs[5,4] = 1; // right(press)
	inputs[6,1] = gp_axislv; inputs[6,2] = 3; inputs[6,3] = 1; inputs[6,4] = 2; // up(press)
	inputs[7,1] = gp_axislv; inputs[7,2] = 3; inputs[7,3] = 1; inputs[7,4] = 1; // down(press)

	inputs[8,1] = gp_shoulderrb; inputs[8,2] = 2; inputs[8,3] = 1; inputs[8,4] = 0; // attack / confirm
	inputs[9,1] = gp_shoulderlb; inputs[9,2] = 2; inputs[9,3] = 1; inputs[9,4] = 0; // boost
	inputs[10,1] = gp_start; inputs[10,2] = 2; inputs[10,3] = 1; inputs[10,4] = 0; // pause
	inputs[11,1] = gp_shoulderl; inputs[11,2] = 2; inputs[11,3] = 1; inputs[11,4] = 0; // projectile[DEBUG] / cancel
	inputs[12,1] = gp_axisrh; inputs[12,2] = 3; inputs[12,3] = gp_axisrv; inputs[12,4] = 0; // look angle input
}else{
	// keyboard binds
	inputs[0,1] = ord("A"); inputs[0,2] = 0; inputs[0,3] = 0; inputs[0,4] = 0; // left
	inputs[1,1] = ord("D"); inputs[1,2] = 0; inputs[1,3] = 0; inputs[1,4] = 0; // right
	inputs[2,1] = ord("W"); inputs[2,2] = 0; inputs[2,3] = 0; inputs[2,4] = 0; // up
	inputs[3,1] = ord("S"); inputs[3,2] = 0; inputs[3,3] = 0; inputs[3,4] = 0; // down

	inputs[4,1] = ord("A"); inputs[4,2] = 0; inputs[4,3] = 1; inputs[4,4] = 0; // left(press)
	inputs[5,1] = ord("D"); inputs[5,2] = 0; inputs[5,3] = 1; inputs[5,4] = 0; // right(press)
	inputs[6,1] = ord("W"); inputs[6,2] = 0; inputs[6,3] = 1; inputs[6,4] = 0; // up(press)
	inputs[7,1] = ord("S"); inputs[7,2] = 0; inputs[7,3] = 1; inputs[7,4] = 0; // down(press)

	inputs[8,1] = mb_left; inputs[8,2] = 1; inputs[8,3] = 1; inputs[8,4] = 0; // attack / confirm
	inputs[9,1] = ord("E"); inputs[9,2] = 0; inputs[9,3] = 1; inputs[9,4] = 0; // boost
	inputs[10,1] = vk_escape; inputs[10,2] = 0; inputs[10,3] = 1; inputs[10,4] = 0; // pause
	inputs[11,1] = mb_right; inputs[11,2] = 1; inputs[11,3] = 1; inputs[11,4] = 0; // projectile[DEBUG] / cancel
	inputs[12,1] = mb_none; inputs[12,2] = 1; inputs[12,3] = 0; inputs[12,4] = 0; // look angle input
}

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
					if(inputs[i,4] == 1){
						flag = (flag || gamepad_axis_value(dev,inputs[i,1]) >= gamepad_get_axis_deadzone(dev));
						//show_debug_message("set flag to "+string(flag || gamepad_axis_value(dev,inputs[i,1]) >= gamepad_get_axis_deadzone(dev)));
					}else if(inputs[i,4] == 2){
						flag = (flag || gamepad_axis_value(dev,inputs[i,1]) <= (-1*gamepad_get_axis_deadzone(dev)));
						//show_debug_message("set flag to "+string(flag || gamepad_axis_value(dev,inputs[i,1]) <= (-1*gamepad_get_axis_deadzone(dev))));
					}
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
					gamepad_set_axis_deadzone(dev,0.5);
					if(inputs[i,4] == 1){
						flag = (flag || gamepad_axis_value(dev,inputs[i,1]) >= gamepad_get_axis_deadzone(dev));
					}else if(inputs[i,4] == 2){
						flag = (flag || gamepad_axis_value(dev,inputs[i,1]) <= (-1*gamepad_get_axis_deadzone(dev)));
					}
				}
			}
			break;
		}
		if(flag){
			inputs[i,0] = 1;
		}
	}
}

// control style
if(keyboard_check_pressed(ord("0")) && paused){
	if(control_mode == 0){
		control_mode = 1;
	}else{
		control_mode = 0;
	}
}

if(!paused){

// key inputs for weather FX

// wind
if(keyboard_check_pressed(ord("1"))){
	if(wind_dir == 0){
		wind_dir = random_range(0,360);
	}
	wind_spd = random_range(1.6,4);
	weather_timers[0] = 240;
}
// snow
if(keyboard_check_pressed(ord("2")) && weather_timers[1] <= 0){
	if(snow_lvl == 0){
		weather_timers[1] = 240;
	}else if(snow_lvl == 2){
		weather_timers[1] = -1;
		snow_lvl = 0;
	}
}
// rain
if(keyboard_check_pressed(ord("3")) && weather_timers[2] <= 0){
	weather_timers[2] = 240;
}

// doors
if(keyboard_check_pressed(ord("4"))){
	Door_type1.goal_state = (!Door_type1.goal_state);
}

// updates

if(!boost_active){
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
	// snow
	if(weather_timers[1] > 0){
		weather_timers[1] -= 1;
	}else if(weather_timers[1] == 0){
		if(snow_lvl < 2){
			snow_lvl += 1;
			weather_timers[1] = 240;
		}else{
			weather_timers[1] = -1;
		}
	}
	// rain
	if(rain_light > 0){
		rain_light -= 1;
	}
	if(rain_img_timer > 0){
		rain_img_timer -= 1;
	}else{
		rain_img_timer = 3;
		if(rain_img < 3){
			rain_img += 1;
		}else{
			rain_img = 0;
		}
		if(rain_light == 0 && (random_range(0,1) > 0.9)){
			rain_light = 3;
		}
		if(random_range(0,1) > 0.6){
			rain_off = floor(-8 * random_range(0,3));
		}else{
			rain_off = 0;
		}
	}
	// transition
	if(weather_timers[2] > 0){
		weather_timers[2] -= 1;
	}else if(weather_timers[2] == 0){
		if(!precip){
			precip = true;
			weather_timers[2] = -1;
		}else{
			precip = false;
			weather_timers[2] = -1;
		}
	}
}

// boost ring
if(boost_ring_age > 0){
	boost_ring_age -= 1;
}

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