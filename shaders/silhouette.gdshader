shader_type canvas_item;

void fragment() {
	vec4 col = texture(TEXTURE, UV);
	
	if (col.a == 0.0) {
		discard;
	}
	
	// Set RGB to black, keeping alpha
	col.rgb = vec3(0.0);
	
	COLOR = col;
}

