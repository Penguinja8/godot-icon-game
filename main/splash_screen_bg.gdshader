shader_type canvas_item;

void fragment() {
	COLOR = texture(TEXTURE, UV);
	COLOR.r = 0.0;
	COLOR.g = 0.0;
	COLOR.b -= 0.6;
	COLOR.b /= 2.0;
}
