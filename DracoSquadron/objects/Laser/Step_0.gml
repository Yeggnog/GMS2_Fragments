/// @description Moving

// move
move_speed += move_accel;
image_yscale += move_speed;

if(instance_find(parent, 0) != noone){
	x = parent.x+offset[0];
	y = parent.y+offset[1];
}else{
	instance_destroy();
}

// duration
if(duration > 0){
	duration -= 1;
}else{
	instance_destroy();
}

// destroy if outside
if(x > Camera_parent.x+208 || x < Camera_parent.x-208 || y > Camera_parent.y+352 || y < Camera_parent.y-352){
	instance_destroy();
}
