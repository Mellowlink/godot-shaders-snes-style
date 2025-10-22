shader_type canvas_item;

uniform vec4 color : source_color = vec4(1.0, 1.0, 1.0, 1.0);

void fragment() {
	vec4 col = texture(TEXTURE, UV);
	
	if (col.a == 0.0) {
		discard;
	}
	
	// Replace black pixels with the outline color
	if (col.r == 0.0 && col.g == 0.0 && col.b == 0.0) {
		COLOR = color;
	}
	else {
		COLOR = col;
	}
}

