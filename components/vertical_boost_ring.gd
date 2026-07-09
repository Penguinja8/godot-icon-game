extends Area2D

## additive to vertical
@export var boost_amount: float = 400.0
var disappearing

func _on_body_entered(body):
	if body.velocity.y > 0:
		body.velocity.y = 0
	body.velocity.y -= boost_amount
	disappearing = true
	set_deferred("monitoring", false)

func _process(delta):
	if disappearing:
		$Sprite2D.material.set_shader_parameter("alpha", $Sprite2D.material.get_shader_parameter("alpha")-delta*2)
		if $Sprite2D.material.get_shader_parameter("alpha") < 0.0:
			queue_free()
