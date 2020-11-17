// knockback / movement
//x_spd = 0;
//y_spd = 0;
x_knock = 0;
y_knock = 0;
mass = 1;
HP = 10;

disp_1 = 42;
disp_2 = 42;

// other
hit_flash = 0;
slash = noone;
boost = 100;
beyond = surface_create(camera_get_view_width(view_camera[0]),camera_get_view_height(view_camera[0]));
afterimg[0,0] = 0; afterimg[0,1] = 0;
afterimg[1,0] = 0; afterimg[1,1] = 0;
afterimg[2,0] = 0; afterimg[2,1] = 0;
afterimg[3,0] = 0; afterimg[3,1] = 0;
afterimg[4,0] = 0; afterimg[4,1] = 0;
afterimg[5,0] = 0; afterimg[5,1] = 0;
afterimg_lag = 0;