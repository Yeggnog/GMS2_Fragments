// draw objects (depth-based)
/*if(ds_exists(obj_list,ds_type_list) && ds_list_size(obj_list) > 0){
	var temp = ds_list_create();
	ds_list_copy(temp,obj_list);
	var ref_y = 0;
	
	while(ds_list_size(temp) > 0){
		
	}
	
	ds_list_destroy(temp);
}*/

// draw weather effects

/*
// wind [DEBUG]
if(wind_spd > 0){
	draw_set_color(c_red);
	var center_x = view_xport[0]+72;
	var center_y = view_yport[0]+96;
	draw_line_width(center_x, center_y, center_x+lengthdir_x(wind_spd, wind_dir), 
		center_y+lengthdir_y(wind_spd,wind_dir),2);
	draw_set_color(c_white);
}
*/

if(menu_index != 0 && menu_index != 1 && menu_index != 2){
// rain overlay
var alph = 0.0;
if(weather_timers[2] >= 0){
	if(precip){
		alph = ((weather_timers[2]/240)*0.5);
	}else{
		alph = ((1-weather_timers[2]/240)*0.5);
	}
}else if(precip){
	alph = 0.5;
}
if(alph > 0.0){
	draw_set_alpha(alph);
	if(rain_light > 0){
		draw_sprite_tiled(Weather_RainLight,rain_img,0,rain_off);
	}else{
		draw_sprite_tiled(Weather_Rain,rain_img,0,rain_off);
	}
	draw_set_alpha(1.0);
}
}