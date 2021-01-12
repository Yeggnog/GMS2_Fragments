var in_well = false;
var well = noone;
with(Player){
	in_well = (place_meeting(x,y,Camera_Lock_Trigger));
	well = instance_place(x,y,Camera_Lock_Trigger);
}
if(in_well && well != noone){
	// lock into a well
	if(well.lock_x){
		x = lerp(x, well.x, 0.1);
		follow_player = false;
	}else{
		x = lerp(x, Player.x, 0.1);
	}
	if(well.lock_y){
		y = lerp(y, well.y, 0.1);
		follow_player = false;
	}else{
		y = lerp(y, Player.y, 0.1);
	}
}else{
	follow_player = true;
}

if(follow_player){
	x = lerp(x, Player.x, 0.1);
	y = lerp(y, Player.y, 0.1);
}
