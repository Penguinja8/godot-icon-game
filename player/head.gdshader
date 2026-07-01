shader_type canvas_item;
varying vec4 vertex_color;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	COLOR = texture(TEXTURE, UV); //read from texture
 	COLOR.b = 0.0; //set blue channel to 1.0
	COLOR.r = 1.0;
	COLOR.g *= 0.4;
	COLOR.g += 0.6;
}