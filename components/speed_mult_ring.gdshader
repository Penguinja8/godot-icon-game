shader_type canvas_item;

void fragment() {
	COLOR = texture(TEXTURE, UV);
	COLOR.r = 0.8;
	COLOR.g = 0.8;
	COLOR.b -= 0.4;
}