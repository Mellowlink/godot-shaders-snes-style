shader_type canvas_item;

uniform vec4 color1 : source_color = vec4(1.0, 1.0, 1.0, 1.0);
uniform vec4 color2 : source_color = vec4(1.0, 1.0, 1.0, 1.0);
uniform vec4 color3 : source_color = vec4(1.0, 1.0, 1.0, 1.0);
uniform vec4 color4 : source_color = vec4(1.0, 1.0, 1.0, 1.0);
uniform vec4 color5 : source_color = vec4(1.0, 1.0, 1.0, 1.0);
uniform vec4 color6 : source_color = vec4(1.0, 1.0, 1.0, 1.0);
uniform vec4 color7 : source_color = vec4(1.0, 1.0, 1.0, 1.0);
uniform vec4 color8 : source_color = vec4(1.0, 1.0, 1.0, 1.0);
uniform vec4 newColor1 : source_color = vec4(1.0, 1.0, 1.0, 1.0);
uniform vec4 newColor2 : source_color = vec4(1.0, 1.0, 1.0, 1.0);
uniform vec4 newColor3 : source_color = vec4(1.0, 1.0, 1.0, 1.0);
uniform vec4 newColor4 : source_color = vec4(1.0, 1.0, 1.0, 1.0);
uniform vec4 newColor5 : source_color = vec4(1.0, 1.0, 1.0, 1.0);
uniform vec4 newColor6 : source_color = vec4(1.0, 1.0, 1.0, 1.0);
uniform vec4 newColor7 : source_color = vec4(1.0, 1.0, 1.0, 1.0);
uniform vec4 newColor8 : source_color = vec4(1.0, 1.0, 1.0, 1.0);

bool color_match(vec3 a, vec3 b) {
	float epsilon = 0.004; // Tolerance for floating point comparison
	return abs(a.r - b.r) < epsilon && abs(a.g - b.g) < epsilon && abs(a.b - b.b) < epsilon;
}

void fragment() {
	vec4 col = texture(TEXTURE, UV);
	
	if (col.a == 0.0) {
		discard;
	}
	
	// Preserve black pixels
	if (col.r == 0.0 && col.g == 0.0 && col.b == 0.0) {
		COLOR = col;
	}
	// Check each color for match and replace
	else if (color_match(col.rgb, color1.rgb)) {
		COLOR = newColor1;
	}
	else if (color_match(col.rgb, color2.rgb)) {
		COLOR = newColor2;
	}
	else if (color_match(col.rgb, color3.rgb)) {
		COLOR = newColor3;
	}
	else if (color_match(col.rgb, color4.rgb)) {
		COLOR = newColor4;
	}
	else if (color_match(col.rgb, color5.rgb)) {
		COLOR = newColor5;
	}
	else if (color_match(col.rgb, color6.rgb)) {
		COLOR = newColor6;
	}
	else if (color_match(col.rgb, color7.rgb)) {
		COLOR = newColor7;
	}
	else if (color_match(col.rgb, color8.rgb)) {
		COLOR = newColor8;
	}
	else {
		COLOR = col;
	}
}

