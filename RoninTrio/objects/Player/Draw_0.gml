// -- draw self --

// scaling (cap at 4)
var xscale = 1.0//+(abs(x_knock)/4);
var yscale = 1.0//+(abs(y_knock)/4);
var knock_dir = point_direction(0,0,x_knock,y_knock);
if((knock_dir > 45 && knock_dir <= 135) || (knock_dir > 225 && knock_dir <= 315)){
	yscale = 1+(abs(y_knock)/4);
}else{
	xscale = 1+(abs(x_knock)/4);
}

// color / hit flash
if(hit_flash > 0){
	draw_set_color(c_white);
}else if(HP > 0){
	draw_set_color(c_lime);
}else{
	draw_set_color(c_green);
}

if(boost_active){
	// draw to surface beyond the time
	if(surface_exists(beyond)){
		surface_free(beyond);
	}
	beyond = surface_create(surface_get_width(application_surface),surface_get_height(application_surface));
	surface_set_target(beyond);
	var col = draw_get_color();
	var vx = camera_get_view_x(view_camera[0]);
	var vy = camera_get_view_y(view_camera[0]);
	// afterimages
	for(var i=5; i>=0; i--){
		draw_set_color(merge_color(make_color_rgb(0,191,243),c_black,(i/6)));
		draw_rectangle((4.0)*(afterimg[i,0]-(sprite_width/2)-vx),(4.0)*(afterimg[i,1]-(sprite_height/2)-vy),
			(4.0)*(afterimg[i,0]+(sprite_width/2)-vx),(4.0)*(afterimg[i,1]+(sprite_height/2)-vy),false);
	}
	draw_set_color(col);
	// slash / sprite
	if(slash != noone && slash.y > y){
		draw_sprite_ext(slash.sprite_index,slash.image_index,(4.0)*(slash.x-vx),(4.0)*(slash.y-vy),4.0,4.0,slash.image_angle,c_white,1.0);
	}
	draw_rectangle((4.0)*(x-((xscale/2)*sprite_width)-vx),(4.0)*(y-((yscale/2)*sprite_height)-vy),
		(4.0)*(x+((xscale/2)*sprite_width)-vx),(4.0)*(y+((yscale/2)*sprite_height)-vy),false);
	if(slash != noone && slash.y <= y){
		draw_sprite_ext(slash.sprite_index,slash.image_index,(4.0)*(slash.x-vx),(4.0)*(slash.y-vy),4.0,4.0,slash.image_angle,c_white,1.0);
	}
	surface_reset_target();
}else{
	// draw normally
	draw_rectangle(x-((xscale/2)*sprite_width),y-((yscale/2)*sprite_height),
		x+((xscale/2)*sprite_width)-1,y+((yscale/2)*sprite_height)-1,false);
}

// debug

// reset
draw_set_color(c_white);