// temps
var x_spd = 0;
var y_spd = 0;

// movement controls [TEMP]
if(x_knock == 0 && y_knock == 0){
	if(keyboard_check(vk_left)){
		// left
		x_spd += -3;
	}
	if(keyboard_check(vk_right)){
		// right
		x_spd += 3;
	}
	if(keyboard_check(vk_up)){
		// up
		y_spd += -3;
	}
	if(keyboard_check(vk_down)){
		// down
		y_spd += 3;
	}
	if(keyboard_check_pressed(vk_space)){
		// knock
		var dir = point_direction(0,0,x_spd,y_spd);
		x_knock = (mass*lengthdir_x(4,dir));
		y_knock = (mass*lengthdir_y(4,dir));
	}
}

// variable updates
x_knock = lerp(x_knock, 0, 0.2);
y_knock = lerp(y_knock, 0, 0.2);

// collisions
var x_frac = (x_spd / 4);
var y_frac = (y_spd / 4);
var xsp = 0
var ysp = 0;
for(var i=0; i<4; i++){
	if(!place_meeting(x+x_spd+x_knock, y+y_spd+y_knock, Solid)){
		xsp += x_frac;
		ysp += y_frac;
	}else{
		var inst = instance_place(x+x_spd+x_knock, y+y_spd+y_knock, Solid);
		// x bounce
		if(inst.y <= y-6 && inst.y >= y+6){
			x_knock = -x_knock;
		}
		// y bounce
		if(inst.x <= x-6 && inst.x >= x+6){
			y_knock = -y_knock;
		}
	}
}
x_spd = xsp;
y_spd = ysp;

// move object
x += (x_spd+x_knock);
y += (y_spd+y_knock);

// handle overflow
x = max(0,x);
x = min(x,room_width);
y = max(0,y);
y = min(y,room_height);