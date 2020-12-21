// get vars for sanity
var vw = camera_get_view_width(view_camera[0]);
var vh = camera_get_view_height(view_camera[0]);
var vx = camera_get_view_x(view_camera[0]);
var vy = camera_get_view_y(view_camera[0]);

// [DEBUG]
//draw_ellipse((4*vx)-3,(4*vy)-3,(4*vx)+3,(4*vy)+3,false);


// riptide boost FX
if(boost_active){
	// generate normal map for boost
	if(surface_exists(boost_nmap)){
		surface_free(boost_nmap);
	}
	boost_nmap = surface_create(surface_get_width(application_surface),surface_get_height(application_surface));
	surface_set_target(boost_nmap);
	draw_set_color(make_color_rgb(128,128,255));
	draw_rectangle(0,0,surface_get_width(application_surface),surface_get_height(application_surface),false);
	draw_set_color(c_white);
	if(boost_ring_age > 0){
		var scale = (12*(1-(boost_ring_age/20)));
		draw_set_alpha(boost_ring_age/20);
		draw_sprite_ext(Circle_Normal,1,4*(boost_ring_x-vx),4*(boost_ring_y-vy),scale,scale,0,c_white,1.0);
		draw_set_alpha(1.0);
	}
	surface_reset_target();

	// copy application surface
	if(!surface_exists(boost_surface)){
		boost_surface = surface_create(surface_get_width(application_surface),surface_get_height(application_surface));
	}
	surface_copy(boost_surface,0,0,application_surface);
	
	// combine into riptide shader
	shader_set(Riptide);
	var mag = shader_get_uniform(Riptide,"f_magnitude");
	var normal = shader_get_sampler_index(Riptide,"s_NormalSampler");
	var normalmap = surface_get_texture(boost_nmap);
	var color = shader_get_sampler_index(Riptide, "s_ColorSampler");
	var colormap = surface_get_texture(boost_surface);
	shader_set_uniform_f(mag, 1);
	texture_set_stage(normal, normalmap);
	texture_set_stage(color, colormap);
	draw_surface(boost_surface,0,0);
	shader_reset();
	
	//draw_surface(boost_nmap,0,0);
	surface_free(boost_nmap);
	
	// draw player on top of boost FX
	if(instance_exists(Player) && surface_exists(Player.beyond)){
		draw_surface_ext(Player.beyond, 0, 0, 1.0, 1.0, 0, c_white, 1.0);
	}
}


// draw HUD
draw_set_color(c_white);

var UI_scale = 4.0;
var UI_surf = surface_create(vw,vh);
surface_set_target(UI_surf);

// [ everything in here is properly scaled ]

// boost meter
/*draw_sprite(UI_Boost,0,2,2);
draw_rectangle(17,5,67,13,false);
draw_set_color(c_black);
draw_rectangle(18,6,66,12,false);
draw_set_color(make_color_rgb(0,191,243));
draw_rectangle(18,6,18+((Player.boost/Player.boost_max)*48),12,false);*/
draw_sprite(UI_Health,0,2,2);
draw_sprite_part(UI_Health,1,7,3,(24*(Player.HP/10)),4,9,5);
draw_sprite_part(UI_Health,2,7,5,(21*(Player.boost/Player.boost_max)),2,9,7);

draw_set_color(c_white);

// draw menu

// cursor offset
var curs_off_x = (8-(4*curs_y)+curs_offset_x);
var curs_off_y = (-40+(20*curs_y)+curs_offset_y);
	
// sword / menu cursor
if(pause_wait != -1){
	var offset_x = 0;
	var offset_y = 0;
	var offset_a = point_direction(0, 0, 6, 1);
	if(paused){
		// ease out (0->max)
		offset_x = lengthdir_x(2-(pause_wait/6), offset_a);
		offset_y = lengthdir_y(2-(pause_wait/6), offset_a);
	}else{
		// ease in (max->0)
		offset_x = lengthdir_x((pause_wait/6), offset_a);
		offset_y = lengthdir_y((pause_wait/6), offset_a);
	}
	draw_sprite(UI_Sword, 0, 71+(71*offset_x)+curs_off_x, 93-(68*offset_y)+curs_off_y);
	draw_sprite(UI_Sword, 1, 71-(71*offset_x)+curs_off_x, 93+(68*offset_y)+curs_off_y);
}else if(paused){
	draw_sprite(UI_Sword, 0, 71+curs_off_x, 93+curs_off_y);//96
	draw_sprite(UI_Sword, 1, 71+curs_off_x, 93+curs_off_y);
}

// menu text
draw_set_alpha(0.0);
if(pause_wait > -1){
	if(!paused){
		draw_set_alpha((1.0-(pause_wait/12)));
	}else{
		draw_set_alpha((pause_wait/12));
	}
}else if(paused){
	draw_set_alpha(1.0);
}
for(var i=0; i<5; i++){
	//draw_sprite(UI_pause_text,i,72+8-(4*i),100-40+(20*i));
	draw_sprite(UI_pause_text,i,71+8-(4*i),99-40+(20*i));//96
}
draw_set_alpha(1.0);

// [ end of proper scaling ]

surface_reset_target();

draw_surface_ext(UI_surf,0,0,UI_scale,UI_scale,0,c_white,1.0);

surface_free(UI_surf);
