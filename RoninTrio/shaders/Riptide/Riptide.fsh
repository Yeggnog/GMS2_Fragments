//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;
uniform sampler2D s_ColorSampler;
uniform sampler2D s_NormalSampler;
uniform float f_magnitude;

void main()
{
	// mess with the texture coords
	vec4 normal = texture2D( s_NormalSampler, v_vTexcoord );
	//vec2 v_newTexcoord = (v_vTexcoord + (f_magnitude*vec2(normal.r,normal.g)) );
	float off = -0.5;
	vec2 offset = normal.xy+vec2(off,off);//vec2( normal.x, normal.y );
	vec2 v_newTexcoord = v_vTexcoord + offset;
	vec4 color = texture2D( s_ColorSampler, v_newTexcoord );
	// greyscale
	float avg = ((color.r+color.g+color.b)/3.0);
	vec4 val = vec4(avg, avg, avg, color.a);
	vec4 final = ((1.0)*val) + ((0.0)*normal);
    gl_FragColor = final;
}
