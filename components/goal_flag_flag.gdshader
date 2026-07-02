shader_type canvas_item;

void fragment() {
	COLOR = texture(TEXTURE, UV);
	COLOR.b += .1;
	COLOR.r = 1.0;
	COLOR.g = 0.0;
}