shader_type canvas_item;

void fragment() {
	COLOR = texture(TEXTURE, UV);
	if (COLOR.b < 0.26 && COLOR.b > 0.25 && COLOR.r > 0.2)
	{
		COLOR.b = 1.0;
		COLOR.r = 1.0;
		COLOR.g = 1.0;
	}
	else
	{
		COLOR.r = 0.0;
		COLOR.g = 0.0;
		COLOR.b -= 0.6;
		COLOR.b /= 2.0;
	}
}