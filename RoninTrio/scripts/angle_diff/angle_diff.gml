/// @function					angle_diff(angle1, angle2);
/// @param	{real}	angle1		the first angle to consider
/// @param	{real}	angle2		the second angle to consider

function angle_diff(angle1, angle2){
	if(angle1 > angle2){
		if(angle1-angle2 <= 180){
			return (angle1-angle2);
		}else{
			return ((360-angle1)+angle2);
		}
	}else if(angle1 < angle2){
		if(angle2-angle1 <= 180){
			return (angle2-angle1);
		}else{
			return ((360-angle2)+angle1);
		}
	}else{
		return 0;
	}
}