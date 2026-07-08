shader_type canvas_item;

void fragment() {
	COLOR = texture(TEXTURE, UV);
	COLOR.b /= 2.0;
	COLOR.r = 1.0;
	COLOR.g = 0.1;
	COLOR.a = 0.8;
}