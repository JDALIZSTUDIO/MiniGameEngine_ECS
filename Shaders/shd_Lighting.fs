#define NUM_LIGHT 32

struct Light{
  vec2 position;
  vec3 diffuse;
  float power;
};

extern Light lights[NUM_LIGHT];
extern int num_lights;
extern vec2 screen;

const float constant  = 1.0;
const float linear    = 0.09;
const float quadratic = 0.032;

vec4 effect( vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords ){   
  vec4 pixel = Texel(texture, texture_coords);

  vec2 norm_screen = screen_coords / screen;
  vec3 diffuse     = vec3(0);
  
  for (int i = 0; i < num_lights; i++){
    Light light = lights[i];
    vec2 norm_pos = light.position / screen;

    float dist = length(norm_pos - norm_screen) * light.power;
    float attenuation = 1.0 / ( constant + linear * dist + quadratic * ( dist * dist ) );

    diffuse += light.diffuse * attenuation;
  }

  diffuse = clamp(diffuse, 0.0, 1.0);
  
  return pixel * vec4(diffuse, 1.0);  
}