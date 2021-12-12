
extern sampler2D noiseTexture;
extern vec2 surfaceDimensions;
extern vec2 noiseTextureDimensions;
extern float radius;

#define NUM_SAMPLES	64.0

vec2 noise2D(vec2 _in){
	return texture2D( noiseTexture, _in ).xy;
}

vec4 effect( vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords ){
	vec2 noiseCoords;
	noiseCoords.x = fract((texture_coords.x * surfaceDimensions.x) / noiseTextureDimensions.x);
	noiseCoords.y = fract((texture_coords.y * surfaceDimensions.y) / noiseTextureDimensions.y);		
		
	vec4 accumcol = vec4(0.0,0.0,0.0,0.0);
	
	for(float s = 0.0; s < NUM_SAMPLES; s++){
		noiseCoords = noise2D(noiseCoords);		
		vec2 sampleCoords = texture_coords + (((noiseCoords - 0.5) * 4.0 * radius) / surfaceDimensions);		
		accumcol += texture2D( texture, sampleCoords );
	}
	
	return vec4( accumcol / NUM_SAMPLES );
}