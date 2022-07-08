// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

// @function	control_input(action, test)
// @param		{real} dragon_id		The dragon id to get the stats of
function stats_from_id(dragon_id){
	var stats = ["normal", "shield", "graze"]; // shot type, screen nuke type, alt effect
	switch(dragon_id){
		case 0:
			// dragon A
			stats = ["normal", "shield", "graze"];
		break;
		case 1:
			// dragon B
			stats = ["rapid", "full", "graze"];
		break;
		case 2:
			// dragon C
			stats = ["homing", "shield", "graze"];
		break;
		case 3:
			// dragon D
			stats = ["normal", "shield", "graze"];
		break;
		case 4:
			// dragon E
			stats = ["normal", "shield", "graze"];
		break;
		case 5:
			// dragon F
			stats = ["rapid", "shield", "graze"];
		break;
		case 6:
			// dragon G
			stats = ["homing", "full", "graze"];
		break;
		case 7:
			// dragon H
			stats = ["normal", "shield", "graze"];
		break;
	}
	return stats;
}
