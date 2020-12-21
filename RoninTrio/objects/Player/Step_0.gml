if(!paused){
	
// temps
var x_spd = 0;
var y_spd = 0;

// hit flash
hit_flash = lerp(hit_flash,0,1);

// boost level
if(instance_exists(GameControl)){
	if(boost_active){
		if(boost == 0){
			// cinematic finish
			if(kill_list_wait == 0){
				if(ds_list_size(kill_list) > 0){
					if(cinematic_finish == false){
						cinematic_finish = true;
					}
					var inst = kill_list[| 0];
					// particle
					part_particles_create(part_sys,inst.x,inst.y,part_types[| 1],1);
					kill_list_wait = 6;
					ds_list_delete(kill_list, 0);
				}else{
					boost_active = false;
					cinematic_finish = false;
				}
			}else{
				kill_list_wait -= 1;
			}
		}else if(boost > 0){
			boost -= 1;
		}
	}else if(boost < boost_max){
		boost += 1;
	}
}

// afterimages
if(afterimg_lag > 0){
	afterimg_lag -= 1;
}else{
	for(var i=0; i<5; i++){
		afterimg[i+1,0] = afterimg[i,0];
		afterimg[i+1,1] = afterimg[i,1];
	}
	afterimg[0,0] = x;
	afterimg[0,1] = y;
	afterimg_lag = 3;
}

// animation wait
if(anim_wait > 0){
	anim_wait -= 1;
}

// movement controls
if(int64(x_knock) == 0 && int64(y_knock) == 0 && HP > 0 && cinematic_finish == false && anim_wait == 0){
	if(inputs[0,0] > 0){
		// left
		x_spd += -2;
	}
	if(inputs[1,0] > 0){
		// right
		x_spd += 2;
	}
	if(inputs[2,0] > 0){
		// up
		y_spd += -2;
	}
	if(inputs[3,0] > 0){
		// down
		y_spd += 2;
	}
	if(inputs[9,0] > 0 && boost > 0 && instance_exists(GameControl) && !boost_active){
		// riptide boost
		boost_active = true;
		GameControl.boost_ring_age = 20;
		GameControl.boost_ring_x = x;
		GameControl.boost_ring_y = y;
	}
	if(inputs[11,0] > 0){
		// projectile
		var dir = point_direction(x,y,mouse_x,mouse_y);
		var shot = instance_create_layer(x+lengthdir_x(18,dir),y+lengthdir_y(18,dir),layer,ProjectileAttack);
		shot.dmg = 3;
		shot.force = 0.75;
		shot.dir = dir;
		shot.spd = 4;
		shot.life = 5;
		anim_wait = 4;
	}
	if(inputs[8,0] > 0 && slash == noone){
		// slash
		var dir = point_direction(x,y,mouse_x,mouse_y);
		slash = instance_create_layer(x+lengthdir_x(18,dir),y+lengthdir_y(18,dir),layer,MeleeAttack);
		slash.owner = id;
		slash.dmg = 2;
		//slash.dmg = 12;
		slash.force = 0.75;
		slash.dir = dir;
		slash.rad = 18;
		slash.life = 6;
		slash.sprite_index = Particles_Slash1;
		slash.image_angle = dir;
		anim_wait = 7; //4
	}
}

// variable updates
x_knock = lerp(x_knock, 0.0, 0.1);
y_knock = lerp(y_knock, 0.0, 0.1);

// collisions
if(place_meeting(x+x_spd+x_knock, y+y_spd+y_knock, Solid)){
	var inst = instance_place(x+x_spd+x_knock, y+y_spd+y_knock, Solid);
	// x bounce
	if(inst.y >= y-6 && inst.y <= y+6){
		x_knock = -x_knock;
	}
	// y bounce
	if(inst.x >= x-6 && inst.x <= x+6){
		y_knock = -y_knock
	}
}
var xsp = x_spd+round(x_knock);
var ysp = y_spd+round(y_knock);
var loops = 0;
while(place_meeting(x+xsp, y+ysp, Solid) && loops < 12){
	if(place_meeting(x+xsp, y, Solid)){
		if(xsp > 0){
			xsp -= 1;
		}else if(xsp < 0){
			xsp += 1;
		}
	}
	if(place_meeting(x, y+ysp, Solid)){
		if(ysp > 0){
			ysp -= 1;
		}else if(ysp < 0){
			ysp += 1;
		}
	}
	loops += 1;
}
x_spd = xsp;
y_spd = ysp;

// move object
x += x_spd;
y += y_spd;

// handle overflow
x = max(0,x);
x = min(x,room_width);
y = max(0,y);
y = min(y,room_height);

}