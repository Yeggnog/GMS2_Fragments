/// @description Draw menus / UI

// drawing vars
var vx = view_xport[0];
var vy = view_yport[0];
var vw = view_wport[0];
var vh = view_hport[0];

// UI

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

