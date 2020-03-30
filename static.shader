shader_type canvas_item;
uniform sampler2D TextureUniform;
uniform float alpha_factor = 0.5;
const float pi = 3.1415926;

void vertex() {
}

float rand(vec2 co){
    return fract(sin(dot(co.xy ,vec2(12.9898,78.233))) * 43758.5453) ;
}

void fragment() {

	float mask_wave_factor;
	float mask_alpha_factor;
	{
		vec4 mask = texture( TextureUniform , SCREEN_UV );
		mask_wave_factor = mask.r;
		mask_alpha_factor = mask.a;
	}
	
	vec3 ref_color;
	float ref_alpha;
	
	{
		float lamada = 5.0 * TEXTURE_PIXEL_SIZE.y; 
		float offset_x = mask_wave_factor * 1.0 * TEXTURE_PIXEL_SIZE.x * sin(2.0* pi * (TIME - UV.y/lamada) ) ;
		vec2 new_uv = UV + vec2(offset_x,0);
		vec4 ref = texture( TEXTURE , new_uv );
		ref_color = ref.rgb;
		ref_alpha = ref.a;
	}

    

	float delta = 1.0 - mask_alpha_factor;
	
	float output_alpha;
	output_alpha = ceil(ref_alpha - delta);
	output_alpha = max( output_alpha , 0.0 );
  
	vec4 bg_color = texture(SCREEN_TEXTURE,SCREEN_UV);
	COLOR.rgb = (mask_alpha_factor * alpha_factor) * ref_color + (1.0 - mask_alpha_factor * alpha_factor) * bg_color.rgb;
	COLOR.a = output_alpha;
	

}

void light() {
}
