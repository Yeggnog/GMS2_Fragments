// -- draw self --

/*if(HP > 0){
	// ranges (debug)
	draw_set_alpha(0.1);
	draw_set_color(c_yellow);
	draw_ellipse(origin_x-64,origin_y-64,origin_x+64,origin_y+64,false);
	draw_set_color(c_red);
	draw_ellipse(x-64,y-64,x+64,y+64,false);
	draw_set_color(c_blue);
	draw_ellipse(x-56,y-56,x+56,y+56,true);
	draw_ellipse(x-48,y-48,x+48,y+48,true);
	draw_set_color(c_orange);
	draw_ellipse(x-20,y-20,x+20,y+20,false);
	draw_set_alpha(1.0);
	draw_set_color(c_white);
}*/

// scaling (cap at 4)
xscale = 1;
yscale = 1;
if(!boost_active){
	var knock_dir = point_direction(0,0,x_knock,y_knock);
	if((knock_dir > 45 && knock_dir <= 135) || (knock_dir > 225 && knock_dir <= 315)){
		yscale = 1+(abs(y_knock)/4);
	}else{
		xscale = 1+(abs(x_knock)/4);
	}
}

// color / hit flash
/*if(target != noone){
var dist = distance_to_point(target.x,target.y);
}else{
	var dist = 500;
}
if(hit_flash > 0){
	draw_set_color(c_white);
}else if(HP > 0){
	if(AI_intention == 1){
		draw_set_color(c_maroon);
	}else if(dist < 48){
		draw_set_color(c_blue);
	}else{
		draw_set_color(c_gray);
	}
}else{
	draw_set_color(c_dkgray);
}*/

// draw
//draw_rectangle(x-((xscale/2)*sprite_width),y-((yscale/2)*sprite_height),
//x+((xscale/2)*sprite_width),y+((yscale/2)*sprite_height),false);
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


// [DEBUG]
/*
draw_set_color(c_lime)
draw_text(x,y,string(AI_state));
draw_ellipse(AI_targ_x-3,AI_targ_y-3,AI_targ_x+3,AI_targ_y+3,false);
*/

// reset
draw_set_color(c_white);