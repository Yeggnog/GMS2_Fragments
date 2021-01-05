if(!paused){
// handle weather conditions

// time
if(sec < room_speed){
	sec += (2.0/room_speed);
}else{
	sec = 0;
	off = random_range(-1.5,-0.5);
}

// wind
if(GameControl.wind_spd > 1){
	// windy
}

// rain
if(GameControl.precip == true){
	// raining
}

// snow
if(GameControl.snow_lvl > 1){
	// deep snow
}else if(GameControl.snow_lvl > 0){
	// light snow
}

}