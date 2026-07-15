extends Path2D

var speed = 0
var player
@export var gravity = 10
var last_progress = 0.0

func _ready():
	var points = curve.get_baked_points()
	$Line2D.points = points
	$Area2D/CollisionPolygon2D.polygon = points
	points.reverse()
	$Area2D/CollisionPolygon2D.polygon += points

func _process(delta):
	if speed:
		$PathFollow2D.progress += speed * delta
		if abs(speed) > 10:
			$PathFollow2D2.progress = $PathFollow2D.progress + delta * speed
		else:
			$PathFollow2D2.progress = $PathFollow2D.progress + delta * sign(speed) * 10
		speed += sign(speed) * sign($PathFollow2D2.global_position.y - $PathFollow2D.global_position.y) * sqrt(gravity * abs($PathFollow2D2.global_position.y - $PathFollow2D.global_position.y))
		
		if abs($PathFollow2D.progress_ratio - last_progress) > 0.9:
			dismount()
		last_progress = $PathFollow2D.progress_ratio
	
func dismount():
	$PathFollow2D.progress_ratio = last_progress
	$PathFollow2D2.progress_ratio = last_progress
	$PathFollow2D2.progress -= sign(speed) * 0.1
	player.dismount_rail(speed, $PathFollow2D2.global_position.direction_to($PathFollow2D.global_position))
	speed = 0	

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.rail_mount:
		return
	$PathFollow2D.progress_ratio = find_closest_progress_on_path(body.global_position)
	last_progress = $PathFollow2D.progress_ratio
	body.mount_rail($PathFollow2D)
	player = body
	set_deferred("speed", body.velocity.length())

func find_closest_progress_on_path(point):
	var closest_progress = 0.0
	var closest_dist = 10000.0
	for i in range(100):
		$PathFollow2D.progress_ratio = $PathFollow2D.progress_ratio + 0.01
		var dist = $PathFollow2D.global_position.distance_to(point)
		if dist < closest_dist:
			closest_dist = dist
			closest_progress = $PathFollow2D.progress_ratio
	return closest_progress
