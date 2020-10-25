// -- draw self --

// scaling (cap at 4)
var xscale = 1+(abs(x_knock)/4);
var yscale = 1+(abs(y_knock)/4);

// color / hit flash
if(hit_flash > 0){
	draw_set_color(c_white);
}else{
	draw_set_color(c_gray);
}

// draw
draw_rectangle(x-((xscale/2)*sprite_width),y-((yscale/2)*sprite_height),
x+((xscale/2)*sprite_width),y+((yscale/2)*sprite_height),false);

// reset
draw_set_color(c_white);