// temps
var x_spd = 0;
var y_spd = 0;

// hit flash
hit_flash = lerp(hit_flash,0,1);

// movement controls [TEMP] [3]
if(int64(x_knock) == 0 && int64(y_knock) == 0){
	if(keyboard_check(vk_left)){
		// left
		x_spd += -2;
	}
	if(keyboard_check(vk_right)){
		// right
		x_spd += 2;
	}
	if(keyboard_check(vk_up)){
		// up
		y_spd += -2;
	}
	if(keyboard_check(vk_down)){
		// down
		y_spd += 2;
	}
	if(keyboard_check_pressed(vk_lshift)){
		// knock
		var dir = point_direction(0,0,x_spd,y_spd);
		x_knock = mass*lengthdir_x(8,dir);
		y_knock = mass*lengthdir_y(8,dir);
		hit_flash = 3;
	}
}

// variable updates
x_knock = lerp(x_knock, 0.0, 0.2);
y_knock = lerp(y_knock, 0.0, 0.2);

// collisions
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
if(place_meeting(x+x_spd+x_knock, y+y_spd+y_knock, Solid)){
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
x_spd = xsp;
y_spd = ysp;
//disp_1 = xsp;
//disp_2 = ysp;

// move object
x += x_spd;
y += y_spd;

// handle overflow
x = max(0,x);
x = min(x,room_width);
y = max(0,y);
y = min(y,room_height);