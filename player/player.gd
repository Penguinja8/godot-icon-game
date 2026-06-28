extends CharacterBody2D


const MAX_SPEED = 300.0
const ACCELERATION = 400
@export var acceleration_curve: Curve

const DECELERATION = 900
const AIR_BRAKE = .98

const JUMP_VELOCITY = -600.0
const MAX_JUMP_VELOCITY = -600.0
const MAX_FALL_SPEED = 300
const MAX_JUMP_CHARGE = .7
var jump_charge = 0
@export var jump_charge_curve: Curve
@onready var jump_charge_scaling = [$Sprite2D, $CollisionShape2D]


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		if velocity.y > MAX_FALL_SPEED:
			velocity.y = MAX_FALL_SPEED

	# Handle jump.
	if Input.is_action_pressed("jump") and is_on_floor():
		if Input.is_action_just_pressed("jump"):
			for node in jump_charge_scaling:
				var jump_tween = get_tree().create_tween()
				jump_tween.tween_property(node, "scale", Vector2(node.scale.x, 0.5), MAX_JUMP_CHARGE)
		jump_charge += delta
	elif Input.is_action_just_released("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY * jump_charge_curve.sample(clampf(jump_charge, 0, MAX_JUMP_CHARGE)/MAX_JUMP_CHARGE)
		for node in jump_charge_scaling:
				var release_tween = get_tree().create_tween()
				release_tween.tween_property(node, "scale", Vector2(node.scale.x, 1), .05)

	var direction = Input.get_axis("left", "right")
	if direction and direction * velocity.x >= 0:
		if is_on_floor():
			velocity.x += ACCELERATION * delta * acceleration_curve.sample(velocity.x/MAX_SPEED) * direction
	else:
		if is_on_floor():
			velocity.x = move_toward(velocity.x, 0, DECELERATION*delta)
		else:
			velocity.x *= AIR_BRAKE

	move_and_slide()
