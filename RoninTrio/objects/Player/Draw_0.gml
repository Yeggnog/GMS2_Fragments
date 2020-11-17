// -- draw self --

// scaling (cap at 4)
var xscale = 1.0//+(abs(x_knock)/4);
var yscale = 1.0//+(abs(y_knock)/4);

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
	if(!surface_exists(beyond)){
		beyond = surface_create(camera_get_view_width(view_camera[0]),camera_get_view_height(view_camera[0]));
	}
	surface_set_target(beyond);
	var col = draw_get_color();
	var vx = camera_get_view_x(view_camera[0]);
	var vy = camera_get_view_y(view_camera[0]);
	// afterimages
	for(var i=5; i>=0; i--){
		draw_set_color(merge_color(make_color_rgb(0,191,243),c_black,(i/6)));
		draw_rectangle(afterimg[i,0]-(sprite_width/2)-vx,afterimg[i,1]-(sprite_height/2)-vy,
			afterimg[i,0]+(sprite_width/2)-1-vx,afterimg[i,1]+(sprite_height/2)-1-vy,false);
	}
	draw_set_color(col);
	// slash / sprite
	if(slash != noone && slash.y > y){
		draw_sprite(slash.sprite_index,slash.image_index,slash.x-vx,slash.y-vy);
	}
	draw_rectangle(x-((xscale/2)*sprite_width)-vx,y-((yscale/2)*sprite_height)-vy,
		x+((xscale/2)*sprite_width)-1-vx,y+((yscale/2)*sprite_height)-1-vy,false);
	if(slash != noone && slash.y <= y){
		draw_sprite(slash.sprite_index,slash.image_index,slash.x-vx,slash.y-vy);
	}
	surface_reset_target();
}else{
	// draw normally
	draw_rectangle(x-((xscale/2)*sprite_width),y-((yscale/2)*sprite_height),
		x+((xscale/2)*sprite_width)-1,y+((yscale/2)*sprite_height)-1,false);

	// debug
	//draw_text(x+24, y+24,"("+string(disp_1)+","+string(disp_2)+")");
}

// reset
draw_set_color(c_white);