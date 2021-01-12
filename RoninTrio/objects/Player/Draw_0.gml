// -- draw self --

// scaling (cap at 4)
xscale = 1.0
yscale = 1.0
var knock_dir = point_direction(0,0,x_knock,y_knock);
if((knock_dir > 45 && knock_dir <= 135) || (knock_dir > 225 && knock_dir <= 315)){
	xscale = (1-(abs(y_knock)/4)); //
	yscale = 1+(abs(y_knock)/4);
}else{
	xscale = 1+(abs(x_knock)/4);
	yscale = (1-(abs(x_knock)/4)); //
}

// color / hit flash
/*var player_color = make_color_rgb(0,255,0);
if(hit_flash > 0){
	player_color = make_color_rgb(255,255,255);
}else if(HP > 0){
	player_color = make_color_rgb(0,255,0);
}else{
	player_color = make_color_rgb(64,64,64);
}*/

if(boost_active){
	// draw to surface beyond the time
	if(surface_exists(beyond)){
		surface_free(beyond);
	}
	beyond = surface_create(surface_get_width(application_surface),surface_get_height(application_surface));
	surface_set_target(beyond);
	var vx = camera_get_view_x(view_camera[0]);
	var vy = camera_get_view_y(view_camera[0]);
	// afterimages
	for(var i=5; i>=0; i--){
		shader_set(Color);
		var col = shader_get_uniform(Color, "inColorActual");
		var mergecolor = merge_color(make_color_rgb(0,191,243),c_black,(i/6));
		shader_set_uniform_f(col, color_get_red(mergecolor), color_get_green(mergecolor), color_get_blue(mergecolor));
			draw_sprite_ext(afterimg[i,2],afterimg[i,3],(4.0)*(afterimg[i,0]-vx),(4.0)*(afterimg[i,1]-vy),(4.0)*afterimg[i,4],(4.0)*afterimg[i,5],0,c_white,1.0);
		shader_reset();
	}
	// slash (below)
	if(slash != noone && slash.y > y){
		draw_sprite_ext(slash.sprite_index,slash.image_index,(4.0)*(slash.x-vx),(4.0)*(slash.y-vy),4.0,4.0,slash.image_angle,c_white,1.0);
	}
	// sprite
	if(hit_flash > 0 || HP <= 0){
		shader_set(Color);
		var col = shader_get_uniform(Color, "inColorActual");
		if(hit_flash > 0){
			shader_set_uniform_f(col, 255.0, 255.0, 255.0, 1.0);
		}else{
			shader_set_uniform_f(col, 64.0, 64.0, 64.0, 0.5);
		}
	}
	draw_sprite_ext(sprite_index,image_index,(4.0)*(x-vx),(4.0)*(y-vy),(4.0)*xscale,(4.0)*yscale,0,c_white,1.0);
	shader_reset();
	// slash (above)
	if(slash != noone && slash.y <= y){
		draw_sprite_ext(slash.sprite_index,slash.image_index,(4.0)*(slash.x-vx),(4.0)*(slash.y-vy),4.0,4.0,slash.image_angle,c_white,1.0);
	}
	surface_reset_target();
}else{
	// draw normally
	if(hit_flash > 0 || HP <= 0){
		shader_set(Color);
		var col = shader_get_uniform(Color, "inColorActual");
		if(hit_flash > 0){
			shader_set_uniform_f(col, 255.0, 255.0, 255.0, 1.0);
		}else{
			shader_set_uniform_f(col, 64.0, 64.0, 64.0, 0.5);
		}
	}
	draw_sprite_ext(sprite_index,image_index,x,y,xscale,yscale,0,c_white,1.0);
	shader_reset();
}

// debug

// reset
draw_set_color(c_white);