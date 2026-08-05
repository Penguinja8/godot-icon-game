shader_type canvas_item;

void fragment() {
	if (COLOR.b > 0.5)
	{
		COLOR.b -= 0.5;
		COLOR.r = 0.2;
		COLOR.g = 0.2;
	}
	else
	{
		COLOR.b -= 0.2;
		COLOR.r = 1.0;
		COLOR.g = 0.85;
	}
}
