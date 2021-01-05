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
        float red = (inColorActual.r/255.0);
        float green = (inColorActual.g/255.0);
        float blue = (inColorActual.b/255.0);
        float alpha = inColorActual.a;
        actual_color = vec4(red,green,blue,alpha);
    }
    gl_FragColor = actual_color;
}
