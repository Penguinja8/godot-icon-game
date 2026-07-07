shader_type canvas_item;

void fragment() {
	COLOR = texture(TEXTURE, UV);
	if (COLOR.b < 0.2)
	{
		COLOR.b = 0.2;
		COLOR.r = 0.0;
		COLOR.g = 0.0;
	}
	else
	{
		COLOR.r = 0.5;
		COLOR.b /= 2.0;
		COLOR.b += 0.5;
		COLOR.g = 0.5;
	}
}