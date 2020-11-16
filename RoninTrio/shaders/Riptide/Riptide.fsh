//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

void main()
{
	// for now, just make everything greyscale
	vec4 color = texture2D( gm_BaseTexture, v_vTexcoord );
	float avg = ((color.r+color.g+color.b)/3.0);
    gl_FragColor = vec4(avg, avg, avg, color.a);
}
