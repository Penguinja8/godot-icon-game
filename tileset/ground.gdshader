shader_type canvas_item;


void fragment() {
	COLOR = texture(TEXTURE, UV);
	COLOR.b /= 4.0;
	COLOR.b += 0.2;
	COLOR.r = 0.1;
	COLOR.g = 0.0;
}