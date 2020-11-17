// draw HUD
draw_set_color(c_white);

var UI_scale_factor = 4.0;
var UI_surf = surface_create(camera_get_view_width(view_camera[0]),camera_get_view_height(view_camera[0]));
surface_set_target(UI_surf);

// boost meter
draw_sprite(UI_Boost,0,2,2);
draw_rectangle(17,5,67,13,false);
draw_set_color(c_black);
draw_rectangle(18,6,66,12,false);
draw_set_color(make_color_rgb(0,191,243));
draw_rectangle(18,6,18+((Player.boost/100)*48),12,false);

draw_set_color(c_white);

surface_reset_target();

draw_surface_ext(UI_surf,0,0,UI_scale_factor,UI_scale_factor,0,c_white,1.0);

surface_free(UI_surf);