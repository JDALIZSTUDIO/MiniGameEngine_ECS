vec4 effect( vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords ){  
  vec4 tex_color = Texel(texture, texture_coords);
  float d = 1-distance(texture_coords, vec2(0.5, 0.5))*1.5;  
  
  float mr = smoothstep(tex_color.r, 0, d);
  float mg = smoothstep(tex_color.g, 0, d);
  float mb = smoothstep(tex_color.b, 0, d);
  float ma = smoothstep(tex_color.a, 0, d);
  
  return vec4(tex_color.r, tex_color.g, tex_color.b, ma);  
}