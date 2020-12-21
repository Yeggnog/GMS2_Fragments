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

// wind [DEBUG]
if(wind_spd > 0){
	draw_set_color(c_red);
	var center_x = view_xport[0]+72;
	var center_y = view_yport[0]+96;
	draw_line_width(center_x, center_y, center_x+lengthdir_x(wind_spd, wind_dir), 
		center_y+lengthdir_y(wind_spd,wind_dir),2);
	draw_set_color(c_white);
}

// riptide boost FX
/*if(boost_active){
	if(!surface_exists(boost_surface)){
		boost_surface = surface_create(surface_get_width(application_surface),surface_get_height(application_surface));
	}
	surface_copy(boost_surface,0,0,application_surface);
	shader_set(Riptide);
	draw_surface_ext(boost_surface,camera_get_view_x(view_camera[0]),camera_get_view_y(view_camera[0]),0.25,0.25,0,c_white,1.0);
	shader_reset();
	
	// draw player on top of boost FX
	if(instance_exists(Player) && surface_exists(Player.beyond)){
		// draw surface
		draw_surface(Player.beyond,camera_get_view_x(view_camera[0]),camera_get_view_y(view_camera[0]));
	}
}*/