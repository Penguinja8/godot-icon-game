shader_type canvas_item;

void fragment() {
	COLOR = texture(TEXTURE, UV);
	COLOR.r = 0.4;
	COLOR.g = 0.4;
	COLOR.b /= 2.0;
	COLOR.b += 0.3;
}
