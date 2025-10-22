shader_type canvas_item;

void fragment() {
	vec4 col = texture(TEXTURE, UV);
	
	if (col.a == 0.0) {
		discard;
	}
	
	// Convert to grayscale by averaging RGB components
	col.rgb = vec3((col.r + col.g + col.b) / 3.0);
	
	COLOR = col;
}

