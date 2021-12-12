extern number aberration = 2.0;
extern number scale      = 1.0;

vec4 effect(vec4 color, Image tx, vec2 tc, vec2 pc){
  // fake chromatic aberration
  float sx = aberration/love_ScreenSize.x*scale;
  float sy = aberration/love_ScreenSize.y*scale;
  vec4 r = Texel(tx, vec2(tc.x + sx, tc.y - sy));
  vec4 g = Texel(tx, vec2(tc.x, tc.y + sy));
  vec4 b = Texel(tx, vec2(tc.x - sx, tc.y - sy));
  number a = (r.a + g.a + b.a)/3.0;

  return vec4(r.r, g.g, b.b, a);
}