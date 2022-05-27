/// @description Menus / level tracking

// pausing
if(control_input("pause", "pressed") == 1){
	game_paused = (!game_paused);
}

// cursor offsets
if(cursor_offset_x > 7){
	cursor_offset_x -= 8;
}else if(cursor_offset_x < -7){
	cursor_offset_x += 8;
}else{
	cursor_offset_x = 0;
}

if(cursor_offset_y > 7){
	cursor_offset_y -= 8;
}else if(cursor_offset_y < -7){
	cursor_offset_y += 8;
}else{
	cursor_offset_y = 0;
}

// menu controls
if(game_paused && cursor_offset_x == 0 && cursor_offset_y == 0){
	if(control_input("move_left", "check") == 1){
		if(menu_panel == 2 || menu_panel == 6){
			if(cursor_x > 0){
				cursor_x -= 1;
				cursor_offset_x = 48;
			}else{
				cursor_x = 4;
				cursor_offset_x = -4 * 48;
			}
		}
	}
	if(control_input("move_right", "check") == 1){
		if(menu_panel == 2 || menu_panel == 6){
			if(cursor_x < 4){
				cursor_x += 1;
				cursor_offset_x = -48;
			}else{
				cursor_x = 0;
				cursor_offset_x = 4 * 48;
			}
		}
	}
	if(control_input("move_up", "check") == 1){
		//if(menu_panel == 2 || menu_panel == 6){
			if(cursor_y > 0){
				cursor_y -= 1;
				cursor_offset_y = 48;
			}else{
				cursor_y = 5;
				cursor_offset_y = -5 * 48;
			}
		//}
	}
	if(control_input("move_down", "check") == 1){
		//if(menu_panel == 2 || menu_panel == 6){
			if(cursor_y < 5){
				cursor_y += 1;
				cursor_offset_y = 48;
			}else{
				cursor_y = 0;
				cursor_offset_y = 5 * 48;
			}
		//}
	}
	if(control_input("fire", "pressed") == 1){
		// confirm
		switch(menu_panel){
			case 0:
				// main menu
				switch(cursor_y){
					case 0:
						// start game
						game_paused = false;
						menu_panel = 3;
					break;
				}
				cursor_y = 0;
			break;
			case 3:
				// pause menu
				switch(cursor_y){
					case 0:
						// resume game
						game_paused = false;
					break;
					case 1:
						// restart level
						room_restart();
						game_paused = false;
					break;
					case 2:
						// quit level
						menu_panel = 0;
					break;
				}
				cursor_y = 0;
			break;
		}
	}
}

// level updates

