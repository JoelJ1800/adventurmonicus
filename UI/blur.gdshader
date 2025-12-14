shader_type canvas_item;

uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_linear_mipmap;
uniform float blur_strength : hint_range(0.0, 10.0) = 4.0;
uniform vec4 overlay_color : source_color = vec4(0.0, 0.0, 0.0, 0.5);

void fragment() {
	vec2 uv = SCREEN_UV;
	vec2 pixel = SCREEN_PIXEL_SIZE * blur_strength;

	vec4 col = vec4(0.0);
	col += texture(SCREEN_TEXTURE, uv + vec2(-pixel.x, 0.0));
	col += texture(SCREEN_TEXTURE, uv + vec2( pixel.x, 0.0));
	col += texture(SCREEN_TEXTURE, uv + vec2(0.0, -pixel.y));
	col += texture(SCREEN_TEXTURE, uv + vec2(0.0,  pixel.y));
	col *= 0.25;

	// Dark overlay blend
	col.rgb = mix(col.rgb, overlay_color.rgb, overlay_color.a);

	COLOR = col;
}
