// temps
var xsp = 0;
var ysp = 0;

// movement controls

// variable updates
x_knock = lerp(x_knock, 0, 0.2);
y_knock = lerp(y_knock, 0, 0.2);

// collisions
var x_frac = (x_spd / 4);
var y_frac = (y_spd / 4);
for(var i=0; i<4; i++){
	if(!place_meeting(x+xsp+x_knock, y+ysp+y_knock, Solid)){
		xsp += x_frac;
		ysp += y_frac;
	}else{
		var inst = instance_place(x+xsp+x_knock, y+ysp+y_knock, Solid);
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

// move object
x += (xsp+x_knock);
y += (ysp+y_knock);

// handle overflow
x = max(0,x);
x = min(x,room_width);
y = max(0,y);
y = min(y,room_height);