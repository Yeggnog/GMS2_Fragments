if(!boost_active || (owner != noone && owner.object_index == Player)){

// manage life
if(life > 0){
	life = lerp(life,0,1);
}else if(life == 0){
	if(owner != noone){
		owner.slash = noone;
	}
	instance_destroy();
}

// update position
if(owner != noone){
	x = owner.x + lengthdir_x(rad,dir);
	y = owner.y + lengthdir_y(rad,dir);
}
image_angle = dir;

// deactivation timer
if(deactivate > 0){
	deactivate = lerp(deactivate,0,1);
}

// damage entities
if(deactivate == 0){
	var ent_list = ds_list_create();
	var flag = false;
	// entities
	var count = instance_place_list(x,y,Entity,ent_list,false);
	for(var i=0; i<count; i++){
		var inst = ent_list[| i];
		if(inst != owner && inst.HP > 0){
			inst.HP -= dmg;
			inst.hit_flash = 6;
			if(inst.mass != 0){
				inst.x_knock = (force/inst.mass)*lengthdir_x(8,dir);
				inst.y_knock = (force/inst.mass)*lengthdir_y(8,dir);
			}
			// kill list add
			if(boost_active && owner != noone && owner.object_index == Player && inst.HP <= 0){
				ds_list_add(Player.kill_list,inst);
			}
			part_particles_create(part_sys_weather,inst.x,inst.y,part_types_weather[| 2],1);
			flag = true;
		}
	}
	ds_list_clear(ent_list);
	// attacks(for clashing / deflecting)
	count = instance_place_list(x,y,Attack,ent_list,false);
	for(var i=0; i<count; i++){
		var inst = ent_list[| i];
		if(inst.owner != owner){
			// react to enemy attack
			if(inst.object_index == MeleeAttack && owner != noone && inst.owner != noone 
				&& force >= inst.force){
				// melee clash
				var k_dir = point_direction(owner.x,owner.y,inst.owner.x,inst.owner.y);
				inst.owner.x_knock = (force/inst.owner.mass)*lengthdir_x(8,k_dir);
				inst.owner.y_knock = (force/inst.owner.mass)*lengthdir_y(8,k_dir);
				owner.x_knock = (force/owner.mass)*lengthdir_x(8,(180-k_dir));
				owner.y_knock = (force/owner.mass)*lengthdir_y(8,(180-k_dir));
				// clash particle(s)
				part_particles_create(part_sys_weather,inst.x,inst.y,part_types_weather[| 4],1);
			}else if(inst.object_index == ProjectileAttack){
				// projectile
				inst.dir = dir;
				// deflect particle
				part_particles_create(part_sys_weather,inst.x,inst.y,part_types_weather[| 3],1);
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