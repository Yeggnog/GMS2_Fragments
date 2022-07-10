/// @description damage tracking

// i-frames
if(i_frames > 0){
	i_frames -= 1;
}

// collisions
if(place_meeting(x, y, Bullet_parent)){
	var collided = ds_list_create();
	if(instance_place_list(x, y, Bullet_parent, collided, false)){
		for(var i=0; i<ds_list_size(collided); i++){
			var inst = collided[|i];
			if(i_frames == 0 && inst.team != team){
				hp -= inst.dmg;
				hp = max(hp, 0);
				i_frames = 8; // default 8, increase for dragons
				with(inst){
					// put particle here
					instance_destroy();
				}
			}
		}
	}
	ds_list_destroy(collided);
}

if(hp == 0){
	instance_destroy(); // change for player
}
