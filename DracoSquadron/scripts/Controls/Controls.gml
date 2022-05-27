// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

// @function	control_input(action, test)
// @param		{real} action		The action to test for
// @param		{real} test			The test to run (check, pressed, released, etc.)
function control_input(action, test){
	
	// get action index
	action_index = 1;
	sub_index = 0;
	switch(action){
		case "move_up": 
			action_index = 0; 
			sub_index = 0; 
			break;
		case "move_left": 
			action_index = 0; 
			sub_index = 1; 
			break;
		case "move_down": 
			action_index = 0; 
			sub_index = 2; 
			break;
		case "move_right": 
			action_index = 0; 
			sub_index = 3; 
			break;
		case "fire": action_index = 1; break;
		case "form1": action_index = 2; break;
		case "form2": action_index = 3; break;
		case "form3": action_index = 4; break;
		case "form4": action_index = 5; break;
		case "pause": action_index = 6; break;
		case "decline": action_index = 7; break;
	}
	
	// run test
	if(action_index == 0){
		// special tests
		switch(control_binds[action_index]){
			case "Mouse": return 1; break;
			case "LStick":
				subs = [gp_axislv, gp_axislh, gp_axislv, gp_axislh];
				return ( abs(gamepad_axis_value(0, subs[sub_index])) > gamepad_get_axis_deadzone(0) );
			break;
			case "RStick": 
				subs = [gp_axisrv, gp_axisrh, gp_axisrv, gp_axisrh];
				return ( abs(gamepad_axis_value(0, subs[sub_index])) > gamepad_get_axis_deadzone(0) );
			break;
			case "WASD": 
				subs = [ord("W"), ord("A"), ord("S"), ord("D")];
				switch(test){
					case "check":
						return keyboard_check(subs[sub_index]);
					break;
					case "pressed":
						return keyboard_check_pressed(subs[sub_index]);
					break;
				}
			break;
			case "Arrows": 
				subs = [vk_up, vk_left, vk_down, vk_right];
				switch(test){
					case "check":
						return keyboard_check(subs[sub_index]);
					break;
					case "pressed":
						return keyboard_check_pressed(subs[sub_index]);
					break;
				} 
			break;
		}
	}else{
		// normal test
		switch(test){
			case "check":
				if(control_mode == 1){
					return gamepad_button_check(0, control_binds[action_index]);
				}else{
					return keyboard_check(control_binds[action_index]);
				}
			break;
			case "pressed":
				if(control_mode == 1){
					return gamepad_button_check_pressed(0, control_binds[action_index]);
				}else{
					return keyboard_check_pressed(control_binds[action_index]);
				}
			break;
		}
	}
}