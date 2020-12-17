// knockback / movement
x_knock = 0;
y_knock = 0;
mass = 1;
HP = 10;

// other
hit_flash = 0;
anim_wait = 0;
facing = 0; // 0/1 for R/L, +2 for up-facing, +0 for down-facing
slash = noone;

// boost
boost = 200;
boost_max = 200;
beyond = surface_create(camera_get_view_width(view_camera[0]),camera_get_view_height(view_camera[0]));
afterimg[0,0] = 0; afterimg[0,1] = 0;
afterimg[1,0] = 0; afterimg[1,1] = 0;
afterimg[2,0] = 0; afterimg[2,1] = 0;
afterimg[3,0] = 0; afterimg[3,1] = 0;
afterimg[4,0] = 0; afterimg[4,1] = 0;
afterimg[5,0] = 0; afterimg[5,1] = 0;
afterimg_lag = 0;

// cinematic finisher
cinematic_finish = false;
kill_list_wait = 0;
kill_list = ds_list_create();