// knockback / movement
x_knock = 0;
y_knock = 0;
mass = 1;
HP = 10;

// other
hit_flash = 0;
anim_wait = 0;
step_wait = 10;
facing = 0; // 0/1 for R/L, +2 for up-facing, +0 for down-facing
slash = noone;
attack = -1;
sprite_index = Player_idle_DR;
xscale = 1;
yscale = 1;
angle = 300;

// boost
boost = 200;
boost_max = 200;
beyond = surface_create(camera_get_view_width(view_camera[0]),camera_get_view_height(view_camera[0]));
afterimg[0,0] = 0; afterimg[0,1] = 0; afterimg[0,2] = 0; afterimg[0,3] = 0; afterimg[0,4] = 0; afterimg[0,5] = 0;
afterimg[1,0] = 0; afterimg[1,1] = 0; afterimg[1,2] = 0; afterimg[1,3] = 0; afterimg[1,4] = 0; afterimg[1,5] = 0;
afterimg[2,0] = 0; afterimg[2,1] = 0; afterimg[2,2] = 0; afterimg[2,3] = 0; afterimg[2,4] = 0; afterimg[2,5] = 0;
afterimg[3,0] = 0; afterimg[3,1] = 0; afterimg[3,2] = 0; afterimg[3,3] = 0; afterimg[3,4] = 0; afterimg[3,5] = 0;
afterimg[4,0] = 0; afterimg[4,1] = 0; afterimg[4,2] = 0; afterimg[4,3] = 0; afterimg[4,4] = 0; afterimg[4,5] = 0;
afterimg[5,0] = 0; afterimg[5,1] = 0; afterimg[5,2] = 0; afterimg[5,3] = 0; afterimg[5,4] = 0; afterimg[5,5] = 0;
afterimg_lag = 0;

// cinematic finisher
cinematic_finish = false;
kill_list_wait = 0;
kill_list = ds_list_create();