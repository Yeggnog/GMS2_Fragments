/// @description Camera vars

state = 0; // 0 -> moving, 1 -> camera locked
scroll_speed = 2;

// screenshake
shake_duration = 0;
shake_offset_x = 0;
shake_offset_y = 0;
follower = instance_create_layer(x, y, layer, Camera_follow);
