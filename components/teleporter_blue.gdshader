shader_type canvas_item;

void fragment() {
	COLOR = texture(TEXTURE, UV);
	COLOR.b += 0.6;
	COLOR.r = 0.5;
	COLOR.g += 0.9;
}