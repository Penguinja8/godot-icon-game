shader_type canvas_item;


void fragment() {
	vec2 center = UV - vec2(0.5);
	COLOR.a = 1.0-3.0*(center.x*center.x + center.y*center.y);
	COLOR.a -= 0.4;
	if (center.x*center.x + center.y*center.y > 0.2)
		COLOR.a = 0.0;
	COLOR.r = 0.8;
	COLOR.g = 0.8;
	COLOR.b /= 2.0;
}


//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
