shader_type canvas_item;

void fragment() {
	COLOR = texture(TEXTURE, UV);
	COLOR.b /= 1.5;
	COLOR.b += .3;
	COLOR.r = 0.5;
	COLOR.g = 0.5;
}