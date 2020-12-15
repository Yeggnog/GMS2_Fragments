// clean up the world

ds_list_destroy(obj_list);

part_system_destroy(part_sys);

var siz = ds_list_size(part_types);
for(var i=0; i<siz; i++){
	part_type_destroy(part_types[| i]);
}
ds_list_destroy(part_types);

surface_free(boost_surface);