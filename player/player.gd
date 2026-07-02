extends CharacterBody2D

const MAIN_SPEED_CUTOFF = 600.0
const ACCELERATION = 500
@export var acceleration_curve: Curve

const DECELERATION = 900
const AIR_BRAKE = .98
const AIR_CONTROL = 200

const JUMP_CHARGE_DECEL = 100

const MAX_JUMP_VELOCITY = -700.0
const MAX_FALL_SPEED = 400
const MAX_JUMP_CHARGE = .6
var jump_charge = 0
@export var jump_charge_curve: Curve
@onready var jump_charge_scaling = [$Body, $CollisionShape2D]
var jump_tweens = []
const gravity = 1200
@export var gravity_curve_falling: Curve
@export var gravity_curve_ascending: Curve

func _ready():
	GameState.start_level_timer()

func _physics_process(delta):
	if Input.is_action_just_pressed("ResetLevel"):
		GameState.restart_level()
	# camera
	if velocity.x < 0:
		if $CameraShiftLeft.is_stopped():
			$CameraShiftLeft.start()
	else:
		$CameraShiftLeft.stop()
		$Camera2D.position = Vector2(450, 0)
	# gravity
	if not is_on_floor():
		if velocity.y > 0: # falling
			velocity.y += gravity * delta * gravity_curve_falling.sample(abs(velocity.y)/MAX_FALL_SPEED)
		else:
			velocity.y += gravity * delta * gravity_curve_ascending.sample(velocity.y/MAX_JUMP_VELOCITY)
		if velocity.y > MAX_FALL_SPEED:
			velocity.y = MAX_FALL_SPEED

	if is_on_floor():
		$Coyote.start()
	if Input.is_action_pressed("jump"):
		velocity.x -= JUMP_CHARGE_DECEL * signf(velocity.x) * delta
		if Input.is_action_just_pressed("jump"):
			for node in jump_charge_scaling:
				var jump_tween = get_tree().create_tween()
				jump_tweens.append(jump_tween)
				jump_tween.tween_property(node, "scale", Vector2(node.scale.x, 0.7), MAX_JUMP_CHARGE)
		jump_charge += delta
	elif Input.is_action_just_released("jump"):
		if not $Coyote.is_stopped():
			velocity.y = MAX_JUMP_VELOCITY * jump_charge_curve.sample(clampf(jump_charge, 0, MAX_JUMP_CHARGE)/MAX_JUMP_CHARGE)
			jump_charge = 0
		for tween in jump_tweens:
			tween.kill()
		for node in jump_charge_scaling:
			var release_tween = get_tree().create_tween()
			release_tween.tween_property(node, "scale", Vector2(node.scale.x, 1), .05)
	var direction = Input.get_axis("left", "right")
	if direction:
		if is_on_floor():
			if direction * velocity.x >= 0:
				if abs(velocity.x) < MAIN_SPEED_CUTOFF:
					velocity.x += ACCELERATION * delta * acceleration_curve.sample(abs(velocity.x)/MAIN_SPEED_CUTOFF) * direction
				else:
					velocity.x += ACCELERATION * delta * (MAIN_SPEED_CUTOFF/(abs(velocity.x) ** 1.6)) * direction
			else:
				velocity.x += DECELERATION * delta * direction
		else:
			if abs(velocity.x) < MAIN_SPEED_CUTOFF or direction * velocity.x <= 0:
				velocity.x += AIR_CONTROL * delta * direction
			else:
				velocity.x += AIR_CONTROL * delta * direction * (MAIN_SPEED_CUTOFF/(abs(velocity.x) ** 1.6))
		#velocity.x = clampf(velocity.x, -MAX_SPEED, MAX_SPEED)
	else:
		if is_on_floor():
			velocity.x = move_toward(velocity.x, 0, DECELERATION*delta)
		else:
			velocity.x *= AIR_BRAKE
	$Body/Wheel.rotation += delta * velocity.x/(10*PI)
	move_and_slide()

func die():
	GameState.restart_level()


func _on_camera_shift_left_timeout() -> void:
	$Camera2D.position = Vector2.ZERO
