//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;
uniform vec4 inColorActual;

void main()
{
    vec4 actual_color = texture2D( gm_BaseTexture, v_vTexcoord );
    if(actual_color.a != 0.0){
        float alpha = inColorActual.a;
        float red = (alpha*(inColorActual.r/255.0)) + ((1.0-alpha)*(actual_color.r));
        float green = (alpha*(inColorActual.g/255.0)) + ((1.0-alpha)*(actual_color.g));
        float blue = (alpha*(inColorActual.b/255.0)) + ((1.0-alpha)*(actual_color.b));
        actual_color = vec4(red,green,blue,actual_color.a);
    }
    gl_FragColor = actual_color;
}
