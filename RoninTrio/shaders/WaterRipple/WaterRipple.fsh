//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;
uniform sampler2D s_texture;
uniform float pixelW;
uniform float pixelH;
uniform vec2 mag;

uniform float iGlobalTime;
//uniform vec3 iResolution;

void main()
{
    //gl_FragColor = v_vColour * texture2D( gm_BaseTexture, v_vTexcoord );
	// get pixel offsets
    //vec2 offsetx = vec2(pixelW,0);
    //vec2 offsety = vec2(0,pixelH);
	#define xSinCycles (24.0)*(3.14);
	#define ySinCycles (24.0)*(3.14);
    
	// variables
	//float xMag = 0.05;
	//float yMag = 0.05;
	//#define xSinCycles 6.28;
	#define ySinCycles (24.0)*(3.14);
	
	vec2 pxCoord = v_vTexcoord;
	
	// shear transform
	float time = iGlobalTime * 2.0;
	float xAngle = time + pxCoord.y * ySinCycles;
	float yAngle = time + pxCoord.x * xSinCycles;
	vec2 distortOffset = (vec2(sin(xAngle), sin(yAngle)) * mag);
	pxCoord += distortOffset;
	
	gl_FragColor = texture2D(s_texture, pxCoord);
}
