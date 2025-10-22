shader_type canvas_item;

uniform vec4 color1 : source_color = vec4(1.0, 1.0, 1.0, 1.0);
uniform vec4 color2 : source_color = vec4(1.0, 1.0, 1.0, 1.0);
uniform vec4 color3 : source_color = vec4(1.0, 1.0, 1.0, 1.0);
uniform vec4 color4 : source_color = vec4(1.0, 1.0, 1.0, 1.0);
uniform vec4 color5 : source_color = vec4(1.0, 1.0, 1.0, 1.0);

void fragment() {
	vec4 col = texture(TEXTURE, UV);
	
	if (col.a == 0.0) {
		discard;
	}
	
	if (col.r == 0.0 && col.g == 0.0 && col.b == 0.0) {
		COLOR = col;
	}
	else {
		// Convert to grayscale
		float brightness = (col.r + col.g + col.b) / 3.0;
		
		// Map brightness to one of 5 colors
		if (brightness > 0.8) {
			COLOR = color1;
		}
		else if (brightness > 0.7) {
			COLOR = color2;
		}
		else if (brightness > 0.4) {
			COLOR = color3;
		}
		else if (brightness > 0.15) {
			COLOR = color4;
		}
		else if (brightness > 0.0) {
			COLOR = color5;
		}
		else {
			COLOR = col;
		}
	}
}

