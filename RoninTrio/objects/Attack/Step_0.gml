if(!boost_active){

// manage life
if(life > 0){
	life = lerp(life,0,1);
}else if(life == 0){
	instance_destroy();
}

// deactivation timer
if(deactivate > 0){
	deactivate = lerp(deactivate,0,1);
}

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
		deactivate = 3;
	}
}

}