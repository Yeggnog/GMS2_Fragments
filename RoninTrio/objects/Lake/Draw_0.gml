// background water color
draw_sprite(sprite_index, 3, x, y);

// generate texture to send to ripple shader
var ripple_surf = surface_create(sprite_width,sprite_height);
var alpha_surf = surface_create(sprite_width,sprite_height);

// "underwater" part of sprite
surface_set_target(ripple_surf);
draw_sprite(sprite_index, 2, 0, 0);
surface_reset_target();

// reflective part of other objects
surface_set_target(alpha_surf);
var ent_list = ds_list_create();
var atk_list = ds_list_create();
instance_place_list(x,y,Entity,ent_list,true);
var n = ds_list_size(ent_list);
for(var i=0; i<n; i++){
	if(i < n){
		var inst = ent_list[| i];
		draw_sprite_ext(inst.sprite_index,inst.image_index,inst.x-x,inst.y-y+16,inst.xscale,-(inst.yscale),0,c_white,1.0);
	}
}
surface_reset_target();

draw_set_alpha(0.5);
surface_set_target(ripple_surf);
draw_surface(alpha_surf,0,0);
surface_reset_target();
draw_set_alpha(1.0);

//draw with shader
shader_set(WaterRipple);
var time = shader_get_uniform(WaterRipple,"iGlobalTime");
var mag = shader_get_uniform(WaterRipple,"mag");
var pixelW = shader_get_uniform(WaterRipple,"pixelW");
var pixelH = shader_get_uniform(WaterRipple,"pixelH");
var surf_tex = surface_get_texture(ripple_surf);
var samp = shader_get_sampler_index(WaterRipple,"s_texture");
texture_set_stage(samp,surf_tex);
//shader_set_uniform_f(time,(current_time/room_speed));
shader_set_uniform_f(time,sec*off);
if(GameControl.snow_lvl == 1){
	shader_set_uniform_f(mag,0.005*(GameControl.weather_timers[1]/240),0.007*(GameControl.weather_timers[1]/240));
}else if(GameControl.snow_lvl == 0){
	shader_set_uniform_f(mag,0.005,0.007);
}
shader_set_uniform_f(pixelW,texture_get_texel_width(surf_tex));
shader_set_uniform_f(pixelH,texture_get_texel_height(surf_tex));
draw_surface(ripple_surf,x,y);
shader_reset();

// draw ice layer
if(GameControl.snow_lvl > 0){
	var alph = 0.0;
	if(GameControl.weather_timers[1] > 0){
		if(GameControl.snow_lvl == 1){
			alph = ((1-(GameControl.weather_timers[1]/240))*0.6);
		}else if(GameControl.snow_lvl == 2){
			alph = 0.6; //((GameControl.weather_timers[1]/240)*0.6);
		}
	}else if(GameControl.snow_lvl == 2){
		alph = 0.6;
	}
	draw_set_alpha(alph);
	draw_sprite(sprite_index,4,x,y);
	draw_set_alpha(1.0);
}

// draw top layer
draw_sprite(sprite_index,1,x,y);

// reset
ds_list_destroy(ent_list);
surface_free(ripple_surf);
surface_free(alpha_surf);