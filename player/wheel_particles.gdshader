shader_type canvas_item;


void fragment() {
	COLOR = texture(TEXTURE, UV); 
 	COLOR.b = 0.0;
	COLOR.r = 0.2;
	COLOR.g *= 0.2;
	COLOR.g += 0.1;
}
