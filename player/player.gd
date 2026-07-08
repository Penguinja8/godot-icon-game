extends CharacterBody2D

const MAIN_SPEED_CUTOFF = 600.0
const ACCELERATION = 500
@export var acceleration_curve: Curve

const DECELERATION = 900
const AIR_BRAKE = .99
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

const PAUSE_MENU = preload("res://UI/pause_menu.tscn")

func _ready():
	$StartOnGround.force_raycast_update()
	global_position.y = $StartOnGround.get_collision_point().y - $CollisionShape2D.shape.size.y/2 + $CollisionShape2D.position.y
	GameState.start_level_timer()

func _physics_process(delta):
	if not $DeathTimer.is_stopped():
		if Input.is_action_just_pressed("ResetLevel") or Input.is_action_just_pressed("jump"):
			_on_death_timer_timeout()
		return
	if Input.is_action_just_pressed("ResetLevel"):
		GameState.restart_level()
	if Input.is_action_just_pressed("pause"):
		$Hud.call_deferred("add_child", PAUSE_MENU.instantiate())
	# camera
	if $TeleportCameraBoost.is_stopped():
		if velocity.length() > MAIN_SPEED_CUTOFF:
			$Camera2D.position_smoothing_speed = 4.0 + velocity.length()/MAIN_SPEED_CUTOFF
		else:
			$Camera2D.position_smoothing_speed = 5.0
	if velocity.x < 0:
		if $CameraShiftLeft.is_stopped():
			$CameraShiftLeft.start()
	else:
		$CameraShiftLeft.stop()
		$Camera2D.position = Vector2(500, 0)
	# gravity
	if not is_on_floor():
		if velocity.y > 0: # falling
			velocity.y += gravity * delta * gravity_curve_falling.sample(abs(velocity.y)/MAX_FALL_SPEED)
		else:
			velocity.y += gravity * delta * gravity_curve_ascending.sample(velocity.y/MAX_JUMP_VELOCITY)
		var calc_max_fall_speed = MAX_FALL_SPEED
		if Input.is_action_pressed("down"):
			calc_max_fall_speed *= 2
		if velocity.y > calc_max_fall_speed:
			velocity.y = calc_max_fall_speed
	if not is_on_floor() or not velocity.x:
		$WheelParticles.emitting = false
	if is_on_floor():
		$Coyote.start()
		if velocity.x and not $WheelParticles.emitting:
			$WheelParticles.emitting = true
	if Input.is_action_pressed("jump"):
		velocity.x -= JUMP_CHARGE_DECEL * signf(velocity.x) * delta
		if Input.is_action_just_pressed("jump"):
			for node in jump_charge_scaling:
				var jump_tween = get_tree().create_tween()
				jump_tweens.append(jump_tween)
				jump_tween.tween_property(node, "scale", Vector2(node.scale.x, 0.7), MAX_JUMP_CHARGE)
		jump_charge += delta
	elif Input.is_action_just_released("jump"):
		if not $Coyote.is_stopped() or $CloseEnoughToJump.is_colliding():
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
			if direction * velocity.x <= 0.0:
				velocity.x *= AIR_BRAKE
				velocity.x += AIR_CONTROL * delta * direction
			if abs(velocity.x) < MAIN_SPEED_CUTOFF:
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

func teleported(distance, destination):
	$Camera2D.position_smoothing_speed = distance/50
	$TeleportCameraBoost.start()
	if destination.normal_dir.x == -1:
		_on_camera_shift_left_timeout()

func die():
	$DeathTimer.start()
	for sprite: Sprite2D in $Body.get_children():
		sprite.material.shader = load("res://player/death.gdshader")


func _on_camera_shift_left_timeout() -> void:
	$Camera2D.position = Vector2(-200, 0)


func _on_death_timer_timeout() -> void:
	GameState.restart_level()
