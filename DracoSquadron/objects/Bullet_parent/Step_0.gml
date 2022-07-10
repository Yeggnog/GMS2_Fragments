/// @description Moving

// homing check
if(homing && instance_find(homing_targ, 0) != noone){
	var best_angle = point_direction(x, y, homing_targ.x, homing_targ.y);
	// get alt angle
	var alt_best1 = best_angle - 360;
	var alt_best2 = best_angle + 360;
	
	if(abs(alt_best1 - move_angle) < abs(best_angle - move_angle)){
		// alt 1 better, rotate right
		move_angle -= homing_turn;
	}else if(abs(alt_best2 - move_angle) < abs(best_angle - move_angle)){
		// alt 2 better, rotate left
		move_angle += homing_turn;
	}else{
		// rotate normally
		if(best_angle > move_angle){
			move_angle += homing_turn;
		}else if(best_angle < move_angle){
			move_angle -= homing_turn;
		}
	}
	
	// corrections
	if(move_angle > 360){
		move_angle -= 360;
	}
	if(move_angle < 0){
		move_angle += 360;
	}
}

// move
move_speed += move_accel;
x += lengthdir_x(move_speed, move_angle);
y += lengthdir_y(move_speed, move_angle);

// destroy if outside
//if(x > room_width+6 || x < -6 || y > room_height+6 || y < -6){
if(x > Camera_parent.x+208 || x < Camera_parent.x-208 || y > Camera_parent.y+352 || y < Camera_parent.y-352){
	instance_destroy();
}
