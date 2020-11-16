// riptide boost FX
if(boost_active){
	if(!surface_exists(boost_surface)){
		boost_surface = surface_create(surface_get_width(application_surface),surface_get_height(application_surface));
	}
	surface_copy(boost_surface,0,0,application_surface);
	shader_set(Riptide);
	draw_surface(boost_surface,0,0);
	shader_reset();
}

// draw HUD
draw_set_color(c_white);

// boost meter
draw_sprite(UI_Boost,0,32,32);
draw_set_color(c_black);
draw_rectangle(50,38,98,42,false);
draw_set_color(make_color_rgb(0,191,243));
draw_rectangle(50,38,50+((Player.boost/100)*48),42,false);

draw_set_color(c_white);