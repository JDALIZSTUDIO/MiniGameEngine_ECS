extern float tX    = 0;
extern float tY    = 0;
extern float speed = 0;

vec4 effect( vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords ){  
    texture_coords.x = mod(texture_coords.x + tX, 1.0);
    texture_coords.y = mod(texture_coords.y + tY, 1.0);
    vec4 tex_color = Texel(texture, texture_coords);
    
    return tex_color;  
}