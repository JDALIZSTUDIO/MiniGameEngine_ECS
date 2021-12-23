extern float time         = 0.0;
extern float displacement = 32.0;
extern float scale        = 0.0;

vec4 effect( vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords ){  

  texture_coords.x += (sin(texture_coords.y*displacement+(time/5))*0.25)*scale;
  vec4 tex_color = Texel(texture, texture_coords);
    
  if(tex_color.a != 0.0){
    float left  = 0.2;
    float right = 0.8;
    
    if(texture_coords.x>right){      
      tex_color.a = 1-distance(vec2(texture_coords.y, 0), vec2(right, 0))*8;
      
    }
    
    if(texture_coords.x<left){
      tex_color.a = 1-distance(vec2(texture_coords.y, 0), vec2(left, 0))*8;
      
    }
  }
  
  return tex_color;  
}