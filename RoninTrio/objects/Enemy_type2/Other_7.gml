// draw into stop
if(appear == 0){ // M
	switch(facing){
		case 0: if(sprite_index == E2M_draw_DR){ image_index = 3; image_speed = 0; } break;
		case 1: if(sprite_index == E2M_draw_DL){ image_index = 3; image_speed = 0; } break;
		case 2: if(sprite_index == E2M_draw_UR){ image_index = 3; image_speed = 0; } break;
		case 3: if(sprite_index == E2M_draw_UL){ image_index = 3; image_speed = 0; } break;
	}
}else{ // F
	switch(facing){
		case 0: if(sprite_index == E2F_draw_DR){ image_index = 3; image_speed = 0; } break;
		case 1: if(sprite_index == E2F_draw_DL){ image_index = 3; image_speed = 0; } break;
		case 2: if(sprite_index == E2F_draw_UR){ image_index = 3; image_speed = 0; } break;
		case 3: if(sprite_index == E2F_draw_UL){ image_index = 3; image_speed = 0; } break;
	}
}

// stow into idle
if(appear == 0){ // M
	switch(facing){
		case 0: if(sprite_index == E2M_stow_DR){ sprite_index = E1M_idle_DR; AI_intention = 0; } break;
		case 1: if(sprite_index == E2M_stow_DL){ sprite_index = E1M_idle_DL; AI_intention = 0; } break;
		case 2: if(sprite_index == E2M_stow_UR){ sprite_index = E1M_idle_UR; AI_intention = 0; } break;
		case 3: if(sprite_index == E2M_stow_UL){ sprite_index = E1M_idle_UL; AI_intention = 0; } break;
	}
}else{ // F
	switch(facing){
		case 0: if(sprite_index == E2F_stow_DR){ sprite_index = E1F_idle_DR; AI_intention = 0; } break;
		case 1: if(sprite_index == E2F_stow_DL){ sprite_index = E1F_idle_DL; AI_intention = 0; } break;
		case 2: if(sprite_index == E2F_stow_UR){ sprite_index = E1F_idle_UR; AI_intention = 0; } break;
		case 3: if(sprite_index == E2F_stow_UL){ sprite_index = E1F_idle_UL; AI_intention = 0; } break;
	}
}