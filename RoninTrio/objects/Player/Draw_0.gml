// -- draw self --

// scaling (cap at 4)
var xscale = 1.0+(abs(x_knock)/4);
var yscale = 1.0+(abs(y_knock)/4);

// color / hit flash
if(hit_flash > 0){
	draw_set_color(c_white);
}else{
	draw_set_color(c_lime);
}

// draw
draw_rectangle(x-((xscale/2)*sprite_width),y-((yscale/2)*sprite_height),
x+((xscale/2)*sprite_width)-1,y+((yscale/2)*sprite_height)-1,false);

// debug
//draw_text(x+24, y+24,"("+string(disp_1)+","+string(disp_2)+")");

// reset
draw_set_color(c_white);