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
						menu_panel = 2;
					break;
				}
				cursor_y = 0;
			break;
			case 2:
				// wing select
				var selected_id = cursor_x + (5 * cursor_y);
				var i = 0;
				var dupe = false;
				while(i < 4 && dragon_ids[i] != -1){
					if(dragon_ids[i] == selected_id){
						dupe = true;
					}
					i += 1;
				}
				if(i < 4){
					if(!dupe){
						dragon_ids[i] = selected_id;
					}
				}else{
					// get spawn point
					var spawn = noone;
					for(var i=0; i<instance_number(Spawn_point); i++){
						var pt = instance_find(Spawn_point, i);
						if(pt.team == 1 || pt.spawn_type == "Player"){
							spawn = pt;
						}
					}
					
					// instantiate dragons
					for(var i=0; i<4; i++){
						var dragon = instance_create_layer(spawn.x, spawn.y, "Instances", Dragon_parent);
						dragon.dragon_id = dragon_ids[i];
						dragon.flight_pos = i;
						dragon_inst_ids[i] = dragon;
						if(i > 0){
							dragon.flight_lead = dragon_inst_ids[0];
						}
					}
					
					// start level
					menu_panel = 3;
					game_paused = false;
				}
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
						
						// get spawn point
						var spawn = noone;
						for(var i=0; i<instance_number(Spawn_point); i++){
							var pt = instance_find(Spawn_point, i);
							if(pt.team == 1 || pt.spawn_type == "Player"){
								spawn = pt;
							}
						}
						
						// clean up dragons
						for(var i=0; i<4; i++){
							if(dragon_inst_ids[i] != noone){
								with(dragon_inst_ids[i]){
									instance_destroy();
								}
								dragon_inst_ids[i] = noone;
							}
						}
						
						//room_restart();
					
						/*
						// instantiate dragons
						for(var i=0; i<4; i++){
							var dragon = instance_create_layer(spawn.x, spawn.y, "Instances", Dragon_parent);
							dragon.dragon_id = dragon_ids[i];
							dragon.flight_pos = i;
							dragon_inst_ids[i] = dragon;
							if(i > 0){
								dragon.flight_lead = dragon_inst_ids[0];
							}
						}
						*/
						
						game_paused = false;
					break;
					case 2:
						// quit level
						menu_panel = 0;
						// clean up dragons
						for(var i=0; i<4; i++){
							if(dragon_inst_ids[i] != noone){
								with(dragon_inst_ids[i]){
									instance_destroy();
								}
								dragon_inst_ids[i] = noone;
							}
						}
					break;
				}
				cursor_y = 0;
			break;
		}
	}
	if(control_input("decline", "pressed") == 1){
		switch(menu_panel){
			case 2:
				// wing select
				var i = 0;
				while(i < 4 && dragon_ids[i] != -1){
					i += 1;
				}
				i -= 1;
				if(i >= 0){
					dragon_ids[i] = -1;
				}else{
					// go back
					menu_panel = 0;
				}
			break;
			case 3:
				// unpause
				game_paused = false;
			break;
		}
	}
}

// level updates

