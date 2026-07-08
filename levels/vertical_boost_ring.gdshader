shader_type canvas_item;

uniform float alpha;

void fragment() {
	COLOR = texture(TEXTURE, UV);
	COLOR.r = 0.0;
	COLOR.g = 0.8;
	COLOR.b -= 0.2;
	COLOR.a = alpha;
}