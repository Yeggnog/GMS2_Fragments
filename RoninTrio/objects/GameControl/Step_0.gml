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