/// @description Start level

var test1 = true;
for(var i=0; i<4; i++){
	if(dragon_ids[i] == -1){
		test1 = false;
	}
}

if(test1 && menu_panel == 3){
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
		var dragon = instance_create_layer(spawn.x, spawn.y, layer_get_id("Instances"), Dragon_parent);
		dragon.dragon_id = dragon_ids[i];
		dragon.flight_pos = i;
		dragon_inst_ids[i] = dragon;
		if(i > 0){
			dragon.flight_lead = dragon_inst_ids[0];
		}
	}
}
