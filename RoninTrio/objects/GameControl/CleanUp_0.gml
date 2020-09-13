// clean up the world

ds_list_destroy(obj_list);

part_system_destroy(part_sys_weather);

var siz = ds_list_size(part_types_weather);
for(var i=0; i<siz; i++){
	part_type_destroy(part_types_weather[| i]);
}
ds_list_destroy(part_types_weather);