/// @description Moving

// homing check
if(homing && homing_targ != noone){
	best_angle = point_direction(x, y, homing_targ.x, homing_targ.y);
	if(best_angle > move_angle){
		if(best_angle - move_angle > angle_difference(best_angle, move_angle)){
			move_angle -= homing_turn;
		}else{
			move_angle += homing_turn;
		}
	}else if(best_angle < move_angle){
		if(move_angle - best_angle > angle_difference(move_angle, best_angle)){
			move_angle += homing_turn;
		}else{
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
