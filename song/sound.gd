extends AudioStreamPlayer

var playback: AudioStreamPlayback

# Called when the node enters the scene tree for the first time.
func _ready():
	var img_data = []
	var img: Image = load("res://icon.svg").get_image()
	for x in range(img.get_width()):
		for y in range(img.get_height()):
			var pixel: Color = img.get_pixel(x,y)
			img_data.append(pixel.b + pixel.g + pixel.r)
	playback = get_stream_playback()
	for i in range(playback.get_frames_available()):
		if i >= len(img_data):
			break
		playback.push_frame(Vector2.ONE*img_data[i])
