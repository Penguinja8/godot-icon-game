shader_type canvas_item;

void fragment() {
	COLOR = texture(TEXTURE, UV);
	COLOR.b += 0.2;
	COLOR.r = 0.9;
	COLOR.g = 0.9;
}