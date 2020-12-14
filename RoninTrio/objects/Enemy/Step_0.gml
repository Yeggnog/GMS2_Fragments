if(!paused){

// temps
var x_spd = 0;
var y_spd = 0;

// hit flash
hit_flash = lerp(hit_flash,0,1);

if(!boost_active){

// movement controls
if(HP > 0){
	// AI control
	if(int64(x_knock) == 0 && int64(y_knock) == 0){
		if(AI_wait == 0){
			// pick action
			
			// debug action [DEBUG]
			var dir = point_direction(x,y,Player.x,Player.y);
			slash = instance_create_layer(x+lengthdir_x(18,dir),y+lengthdir_y(18,dir),layer,MeleeAttack);
			slash.owner = id;
			slash.dmg = 2;
			slash.force = 0.75;
			slash.dir = dir;
			slash.rad = 18;
			slash.life = 12;
			AI_wait = 90;
		}else{
			AI_wait -= 1;
		}
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

}

// handle overflow
x = max(0,x);
x = min(x,room_width);
y = max(0,y);
y = min(y,room_height);

}