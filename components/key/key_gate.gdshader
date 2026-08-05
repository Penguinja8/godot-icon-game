shader_type canvas_item;

void fragment() {
	if (COLOR.b < 0.2 || COLOR.a < 0.5)
	{
		COLOR.a = 1.0;
		COLOR.r = 0.4;
		COLOR.b = 0.4;
		COLOR.g = 0.4;
	}
	else if (COLOR.b < 0.4)
	{
		COLOR.r = 0.5;
		COLOR.b = 0.5;
		COLOR.g = 0.5;
	}
	else if (COLOR.r < 0.8)
	{
		COLOR.r = 0.4;
		COLOR.g = 0.4;
		COLOR.b = 0.4;
	}
}
