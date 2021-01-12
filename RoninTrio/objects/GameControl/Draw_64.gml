// get vars for sanity
var vw = camera_get_view_width(view_camera[0]);
var vh = camera_get_view_height(view_camera[0]);
var vx = camera_get_view_x(view_camera[0]);
var vy = camera_get_view_y(view_camera[0]);

// [DEBUG]
//draw_text(172,12,"mv["+string(inputs[0,0])+","+string(inputs[1,0])+","+string(inputs[2,0])+","+string(inputs[3,0])+"]  cm["+string(gamepad_axis_value(0,inputs[12,0]/*gp_axislh*/))+","+string(gamepad_axis_value(0,inputs[12,1]/*gp_axislv*/))+"]");

// riptide boost FX
if(boost_active){
	// generate normal map for boost
	if(surface_exists(boost_nmap)){
		surface_free(boost_nmap);
	}
	boost_nmap = surface_create(surface_get_width(application_surface),surface_get_height(application_surface));
	surface_set_target(boost_nmap);
	draw_set_color(make_color_rgb(128,128,255));
	draw_rectangle(0,0,surface_get_width(application_surface),surface_get_height(application_surface),false);
	draw_set_color(c_white);
	if(boost_ring_age > 0){
		var scale = (12*(1-(boost_ring_age/20)));
		draw_set_alpha(boost_ring_age/20);
		draw_sprite_ext(Circle_Normal,1,4*(boost_ring_x-vx),4*(boost_ring_y-vy),scale,scale,0,c_white,1.0);
		draw_set_alpha(1.0);
	}
	surface_reset_target();

	// copy application surface
	if(!surface_exists(boost_surface)){
		boost_surface = surface_create(surface_get_width(application_surface),surface_get_height(application_surface));
	}
	surface_copy(boost_surface,0,0,application_surface);
	
	// combine into riptide shader
	shader_set(Riptide);
	var mag = shader_get_uniform(Riptide,"f_magnitude");
	var normal = shader_get_sampler_index(Riptide,"s_NormalSampler");
	var normalmap = surface_get_texture(boost_nmap);
	var color = shader_get_sampler_index(Riptide, "s_ColorSampler");
	var colormap = surface_get_texture(boost_surface);
	shader_set_uniform_f(mag, 1);
	texture_set_stage(normal, normalmap);
	texture_set_stage(color, colormap);
	draw_surface(boost_surface,1,2);
	shader_reset();
	
	surface_free(boost_nmap);
	
	// draw player on top of boost FX
	if(instance_exists(Player) && surface_exists(Player.beyond)){
		draw_surface_ext(Player.beyond, 0, 0, 1.0, 1.0, 0, c_white, 1.0);
	}
}


// draw HUD
draw_set_color(c_white);

var UI_scale = 4.0;
var UI_surf = surface_create(vw,vh);
surface_set_target(UI_surf);

// [ everything in here is properly scaled ]

if(instance_exists(Player)){
	// boost meter
	draw_sprite(UI_Health,0,2,2);
	draw_sprite_part(UI_Health,1,7,3,(24*(Player.HP/10)),4,9,5);
	draw_sprite_part(UI_Health,2,7,5,(21*(Player.boost/Player.boost_max)),2,9,7);
}
/*draw_sprite(UI_Boost,0,2,2);
draw_rectangle(17,5,67,13,false);
draw_set_color(c_black);
draw_rectangle(18,6,66,12,false);
draw_set_color(make_color_rgb(0,191,243));
draw_rectangle(18,6,18+((Player.boost/Player.boost_max)*48),12,false);*/

draw_set_color(c_white);

// draw menu

if(menu_index == 0 || menu_index == 2 || menu_index == 3 || menu_index == 5){
	// cursor offset
	if(menu_index == 2 || menu_index == 5){
		var curs_off_x = (8-(4*(2*curs_y+1))+curs_offset_x);
		var curs_off_y = (-40+(20*(2*curs_y+1))+curs_offset_y);
	}else{
		var curs_off_x = (8-(4*curs_y)+curs_offset_x);
		var curs_off_y = (-40+(20*curs_y)+curs_offset_y);
	}
	
	// sword / menu cursor
	if(pause_wait != -1){
		var offset_x = 0;
		var offset_y = 0;
		var offset_a = point_direction(0, 0, 6, 1);
		if(paused){
			// ease out (0->max)
			offset_x = lengthdir_x(2-(pause_wait/6), offset_a);
			offset_y = lengthdir_y(2-(pause_wait/6), offset_a);
		}else{
			// ease in (max->0)
			offset_x = lengthdir_x((pause_wait/6), offset_a);
			offset_y = lengthdir_y((pause_wait/6), offset_a);
		}
		draw_sprite(UI_Sword, 0, 71+(71*offset_x)+curs_off_x, 93-(68*offset_y)+curs_off_y);
		draw_sprite(UI_Sword, 1, 71-(71*offset_x)+curs_off_x, 93+(68*offset_y)+curs_off_y);
	}else if(paused){
		draw_sprite(UI_Sword, 0, 71+curs_off_x, 93+curs_off_y);//96
		draw_sprite(UI_Sword, 1, 71+curs_off_x, 93+curs_off_y);
	}
}

if(menu_index == 0){
	// title menu
	draw_sprite(UI_Title,0,-1,2);
	// menu text
	for(var i=0; i<3; i++){
		draw_sprite(UI_TitleMenu_text,i,71+8-(4*i),99-40+(20*i));//96
	}
}else if(menu_index == 1){
	// save data menu
	// save font
	var fnt_save1 = font_add_sprite(UI_Text_noOutline,ord("A"),true,1);
	var fnt_save2 = font_add_sprite(UI_Text_small,ord("0"),true,1);
	for(var i=0; i<3; i++){
		// slot bases
		if(i == curs_y){
			draw_sprite(UI_SaveData,0,3,16+55*i);
		}else{
			draw_sprite(UI_SaveData,1,3,16+55*i);
		}
		if(saves[i,0]){
			// slot data
			draw_set_font(fnt_save1);
			draw_text(8,20+55*i,saves[i,1]);
			draw_set_font(fnt_save2);
			// area name
			var area = saves[i,2];
			var str = "???";
			switch(area){
				case Stage_0: str = "MARSH"; break;
			}
			draw_text(12,36+55*i,str);
			draw_text(12,45+55*i,string(saves[i,3]));
			// beast "orbs"
			// pegasus
			if(saves[i,4] == 1){
				if(i == curs_y){ draw_sprite(UI_SaveIcons,0,124,52+55*i); }
				else{ draw_sprite(UI_SaveIcons,4,124,52+55*i); }
			}else if(saves[i,4] == 2){
				if(i == curs_y){ draw_sprite(UI_SaveIcons,3,124,52+55*i); }
				else{ draw_sprite(UI_SaveIcons,7,124,52+55*i); }
			}
			// dragon
			if(saves[i,5] == 1){
				if(i == curs_y){ draw_sprite(UI_SaveIcons,1,118,39+55*i); }
				else{ draw_sprite(UI_SaveIcons,5,118,39+55*i); }
			}else if(saves[i,5] == 2){
				if(i == curs_y){ draw_sprite(UI_SaveIcons,3,118,39+55*i); }
				else{ draw_sprite(UI_SaveIcons,7,118,39+55*i); }
			}
			// phoenix
			if(saves[i,6] == 1){
				if(i == curs_y){ draw_sprite(UI_SaveIcons,2,130,39+55*i); }
				else{ draw_sprite(UI_SaveIcons,6,130,39+55*i); }
			}else if(saves[i,6] == 2){
				if(i == curs_y){ draw_sprite(UI_SaveIcons,3,130,39+55*i); }
				else{ draw_sprite(UI_SaveIcons,7,130,39+55*i); }
			}
		}else{
			draw_set_font(fnt_save1);
			draw_text(8,20+55*i,"NONE");
		}
	}
	font_delete(fnt_save1);
	font_delete(fnt_save2);
}else if(menu_index == 2 || menu_index == 5){
	// options
	// menu text
	for(var i=0; i<4; i++){
		if(i == 1){
			draw_sprite(UI_option_text,3+control_mode,71+8-(4*i),99-40+(20*i));
		}else if(i == 0){
			draw_sprite(UI_option_text,0,71+8-(4*i),99-40+(20*i));//96
		}else if(i == 3){
			draw_sprite(UI_option_text,i-1,71+8-(4*i),99-40+(20*i));//96
			// sensitivity things
			for(var j=0; j<axis_sens; j++){
				draw_sprite(UI_option_text,5,71+8-(4*i)-54+(11*j),99-40+(20*i)+3-(2*j));
			}
		}else{
			draw_sprite(UI_option_text,i-1,71+8-(4*i),99-40+(20*i));//96
		}
	}
}else if(menu_index == 3){
	// pause menu
	// menu text
	draw_set_alpha(0.0);
	if(pause_wait > -1){
		if(!paused){
			draw_set_alpha((1.0-(pause_wait/12)));
		}else{
			draw_set_alpha((pause_wait/12));
		}
	}else if(paused){
		draw_set_alpha(1.0);
	}
	for(var i=0; i<5; i++){
		draw_sprite(UI_pause_text,i,71+8-(4*i),99-40+(20*i));//96
	}
	draw_set_alpha(1.0);
}else if(menu_index == 4){
	// items menu
	draw_sprite(UI_ItemBG,0,0,0);
	// draw item sprites
	draw_sprite(UI_ItemCursor,0,10+(curs_x*18)+curs_offset_x,16+(curs_y*18)+curs_offset_y);
}else if(menu_index == 6){
	// quit Y/N
	// cursor
	draw_sprite(UI_pause_text,7,69-14+(38*curs_x)+curs_offset_x,109+3-(8*curs_x)+curs_offset_y);
	// text
	draw_sprite(UI_pause_text,5,71+2,99-10);
	draw_sprite(UI_pause_text,6,71-2,99+10);
}

if(menu_index == 2 || menu_index == 3 || menu_index == 5){
	// control mode indicator
	var off_x = 0;
	if(pause_wait != -1){
		if(paused){
			off_x = (-20*(2-(pause_wait/6)));
		}else{
			off_x = (-20*(pause_wait/6));
		}
		draw_sprite(UI_Control_Icon,control_mode,10+off_x,20);
	}else if(paused){
		draw_sprite(UI_Control_Icon,control_mode,10,20);
	}
}

// [ end of proper scaling ]

surface_reset_target();

draw_surface_ext(UI_surf,0,0,UI_scale,UI_scale,0,c_white,1.0);

surface_free(UI_surf);
