shader_type canvas_item;

void fragment() {
	COLOR = texture(TEXTURE, UV);
	COLOR.r = 1.0;
	COLOR.g = 0.7;
	COLOR.b -= 0.2;
}