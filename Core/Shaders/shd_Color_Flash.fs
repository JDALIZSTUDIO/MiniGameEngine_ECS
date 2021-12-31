extern vec3  color  = vec3(1.0);
extern float amount = 1.0;

vec4 effect(vec4 color, Image tx, vec2 tc, vec2 pc){
    local pixel = Texel(tx, tc);
    if(pixel.a != 0.0){
        float diffR   = color.r - pixel.r
        float diffG   = color.g - pixel.g
        float diffB   = color.b - pixel.b
        float percent =  1.0 - amount
        pixel.r       = diffR;
        pixel.g       = diffG;
        pixel.b       = diffB;
    }

  return pixel;
}