// get vars for sanity
var vw = camera_get_view_width(view_camera[0]);
var vh = camera_get_view_height(view_camera[0]);

// draw HUD
draw_set_color(c_white);

var UI_scale = 4.0;
var UI_surf = surface_create(vw,vh);
surface_set_target(UI_surf);

// [ everything in here is properly scaled ]

// boost meter
draw_sprite(UI_Boost,0,2,2);
draw_rectangle(17,5,67,13,false);
draw_set_color(c_black);
draw_rectangle(18,6,66,12,false);
draw_set_color(make_color_rgb(0,191,243));
draw_rectangle(18,6,18+((Player.boost/Player.boost_max)*48),12,false);

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
	draw_sprite(UI_Sword, 0, 71+(71*offset_x)+curs_off_x, 96-(68*offset_y)+curs_off_y);
	draw_sprite(UI_Sword, 1, 71-(71*offset_x)+curs_off_x, 96+(68*offset_y)+curs_off_y);
}else if(paused){
	draw_sprite(UI_Sword, 0, 71+curs_off_x, 96+curs_off_y);
	draw_sprite(UI_Sword, 1, 71+curs_off_x, 96+curs_off_y);
}

// [ end of proper scaling ]

surface_reset_target();

draw_surface_ext(UI_surf,0,0,UI_scale,UI_scale,0,c_white,1.0);

surface_free(UI_surf);
