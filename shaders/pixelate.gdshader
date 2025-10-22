shader_type canvas_item;

uniform float pixelation : hint_range(0.5, 32.0) = 0.5;

void fragment() {
	float pixels = 32.0;
	float mx = UV.x * pixels - 1.0;
	float my = UV.y * pixels;
	
	float x = round(mx / pixelation) * pixelation;
	float y = round(my / pixelation) * pixelation;
	vec2 coord = vec2(x / pixels, y / pixels);
	
	COLOR = texture(TEXTURE, coord);
}

