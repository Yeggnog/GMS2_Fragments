/// @description Draw menus / UI

// drawing vars
var vx = camera_get_view_x(view_camera[0]);
var vy = camera_get_view_y(view_camera[0]);
var vw = camera_get_view_width(view_camera[0]);
var vh = camera_get_view_height(view_camera[0]);

// UI
// sp meters
var lead_found = false;
for(var i=0; i<4; i++){
	var offset = 0;
	var extend = 0;
	if(lead_found){
		offset = 4;
	}
	if(dragon_inst_ids[i] != noone && dragon_inst_ids[i] == dragon_inst_ids[i].flight_lead){
		lead_found = true;
		extend = 4;
	}
	draw_set_alpha(0.5);
	draw_rectangle_color(vx+10, vy+10+(12*i)+offset, vx+80+(3*extend), vy+18+(12*i)+offset+extend, c_grey, c_grey, c_grey, c_grey, false);
	draw_set_alpha(1.0);
	if(dragon_inst_ids[i] != noone && dragon_inst_ids[i].sp_meter > 0){
		draw_rectangle_color(vx+10, vy+10+(12*i)+offset, vx+((80+(3*extend))*(dragon_inst_ids[i].sp_meter / 20)), vy+18+(12*i)+offset+extend, c_aqua, c_aqua, c_lime, c_lime, false);
	}
}

// debug
/*
if(dragon_inst_ids[0] != noone && dragon_inst_ids[0].flight_lead != noone){
	draw_circle_color(dragon_inst_ids[0].flight_lead.x, dragon_inst_ids[0].flight_lead.y, 9, c_lime, c_lime, false);
	draw_circle_color(dragon_inst_ids[0].flight_lead.form_targ_x, dragon_inst_ids[0].flight_lead.form_targ_y, 7, c_red, c_red, false);
}
for(var i=0; i<4; i++){
	if(dragon_inst_ids[i] != noone){
		var drg = dragon_inst_ids[i];
		if(drg != drg.flight_lead){
			draw_circle_color(drg.form_targ_x, drg.form_targ_y, 5,c_blue, c_blue, false);
		}
		draw_line_color(drg.form_targ_x, drg.form_targ_y, drg.form_targ_x+lengthdir_x(drg.trans_dist, drg.trans_angle), drg.form_targ_y+lengthdir_y(drg.trans_dist, drg.trans_angle), c_yellow, c_orange);
		//draw_line_color(drg.x, drg.y, drg.form_targ_x, drg.form_targ_y, c_aqua, c_green);
	}
}
*/

// Menus

if(game_paused){
	
if(menu_panel == 2 || menu_panel == 3){
	// background
	draw_set_alpha(0.5);
	draw_sprite_tiled(UI_BG, 0, vx+( (current_time/25) mod 32 ), vy+( (current_time/25) mod 32 ));
	draw_set_alpha(1.0);
}

var UI_start = vy+(vh*(2/3));
var menu_strings = [];
switch(menu_panel){
	case 0:
		menu_strings = ["Press Fire to start"];
		draw_text_color( vx+(vw/2)-(string_width("Draco Squadron")/2), vy+(vh/3), "Draco Squadron", c_white, c_white, c_white, c_white, 1.0 );
	break;
	case 2:
		menu_strings = ["Select your dragons ["+string(cursor_x)+","+string(cursor_y)+"]"];
		for(var i=0; i<4; i++){
			if(dragon_ids[i] != -1){
				draw_sprite_stretched(UI_BG, 0, vx+32+(48*i), UI_start-48, 2*sprite_get_width(UI_BG), 2*sprite_get_height(UI_BG));
			}
		}
	break;
	case 3:
		menu_strings = ["Resume", "Restart", "Quit Level"];
		draw_text_color( vx+(vw/2)-(string_width("Pause")/2), vy+(vh/3), "Pause", c_white, c_white, c_white, c_white, 1.0 );
	break;
}

for(var i=0; i<array_length(menu_strings); i++){
	var alt_color = c_white;
	if(i == cursor_y){
		alt_color = c_aqua;
	}
	draw_text_color( vx+(vw/2)-(string_width(menu_strings[i])/2), UI_start+(40*i), menu_strings[i], c_white, alt_color, c_white, alt_color, 1.0 );
}

}

