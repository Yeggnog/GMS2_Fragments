// handle weather conditions

// wind
if(GameControl.wind_spd > 1){
	// windy
	var num_parts = irandom_range(-80,1/*ceil(GameControl.wind_spd/2)*/);
	for(var i=0; i<num_parts; i++){
		// make particle
		part_type_direction(part_types[| 0],GameControl.wind_dir-random_range(0,30),
			GameControl.wind_dir+random_range(0,30),random_range(-2,2),10);
		part_particles_create(part_sys,x+random_range(0,32),y+random_range(0,32),
			part_types[| 0],1);
	}
}

// rain (none)

// snow
if(GameControl.snow_lvl > 1){
	// deep snow
}else if(GameControl.snow_lvl > 0){
	// light snow
}