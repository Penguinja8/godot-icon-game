shader_type canvas_item;

void fragment() {
	if (COLOR.b > 0.5)
	{
		COLOR.b -= 0.5;
		COLOR.r = 1.0;
	}
	else
		COLOR.r = 0.0;
	COLOR.g = 0.9;
}
