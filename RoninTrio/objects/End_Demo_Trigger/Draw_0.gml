if(collided){
	draw_set_alpha(0.5);
	draw_sprite_tiled(UI_BrickTile,0,camera_get_view_x(view_camera[0]),camera_get_view_y(view_camera[0]));
	draw_set_alpha(1.0);
	draw_sprite(UI_DemoSplash,0,camera_get_view_x(view_camera[0])+3,camera_get_view_y(view_camera[0])+96-22);
}