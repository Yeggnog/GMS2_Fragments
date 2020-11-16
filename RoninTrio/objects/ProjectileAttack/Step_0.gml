if(!boost_active){

// manage life
if(spd == 0){
	if(life > 0){
		life = lerp(life,0,1);
	}else if(life == 0){
		instance_destroy();
	}
}

// move
x += lengthdir_x(spd,dir);
y += lengthdir_y(spd,dir);

// collisions
if(place_meeting(x,y,Solid)){
	spd = 0;
}

// direction lerp
direction = dir;
lerp_dir = lerp(lerp_dir,dir,1);
image_angle = lerp_dir;

// damage entities
if(deactivate == 0){
	var ent_list = ds_list_create();
	var count = instance_place_list(x,y,Entity,ent_list,false);
	var flag = false;
	for(var i=0; i<count; i++){
		var inst = ent_list[| i];
		if(inst != owner && inst.HP > 0){
			inst.HP -= dmg;
			inst.hit_flash = 6;
			if(inst.mass != 0){
				inst.x_knock = (force/inst.mass)*lengthdir_x(8,dir);
				inst.y_knock = (force/inst.mass)*lengthdir_y(8,dir);
			}
			flag = true;
		}
	}
	ds_list_destroy(ent_list);
	if(flag){
		instance_destroy();
	}
}

}