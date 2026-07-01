shader_type canvas_item;

uniform sampler2D my_texture : source_color; 

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	COLOR = texture(my_texture, UV);
	COLOR.b -= 0.7;
	COLOR.g = 0.0;
	COLOR.r = 0.0;
}
