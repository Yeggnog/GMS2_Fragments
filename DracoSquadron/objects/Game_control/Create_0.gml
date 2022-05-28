/// @description Set up control and globals

// control inputs
globalvar control_mode;
control_mode = 0; // 0 -> keyboard, 1 -> controller
// axis mode, fire, formations 1-4, pause, decline
globalvar control_binds;
control_binds = ["WASD", vk_space, ord("1"), ord("2"), ord("3"), ord("4"), ord("E"), vk_lshift];
// "Mouse", "LStick", "RStick", "WASD", "Arrows" are axis mode options
// idea: fixed with WASD for swapping, mouse for move and click for fire, lshift/rclick for decline, E for pause

// menu vars
globalvar game_paused;
game_paused = true;
menu_panel = 0;
/*
0: start menu
1: level select
2: wing select
3: basic pause
4: controls menu
5: level fail menu
6: level result menu
7: awards menu
*/
cursor_x = 0;
cursor_y = 0;
cursor_offset_x = 0;
cursor_offset_y = 0;

// UI vars
dragon_inst_ids = [noone, noone, noone, noone];
dragon_ids = [-1, -1, -1, -1];
