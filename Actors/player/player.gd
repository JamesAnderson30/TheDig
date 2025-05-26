extends CharacterBody2D

signal debug_signal

const SPEED = 130.0 #could adjust for a sprint or w/e
const JUMP_VELOCITY = -300.0


func _physics_process(delta):
	# Add the gravity so don't float
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jumpies
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		
	# Pressing 'G' lets you manually trigger things for testing
	if Input.is_action_just_pressed("debug_action"):
		emit_signal("debug_signal")

	if Input.is_action_just_pressed("attack"):
		print("attacked!")
		$AnimatedSprite2D.play("Attack")
	# Get the input direction and handle the movement/deceleration.
	# prolly replace UI default actions with our own custom ones..
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		if(direction > 0):
			$AnimatedSprite2D.flip_h = false
		elif (direction < 0):
			$AnimatedSprite2D.flip_h = true
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()


func _attack_animation_finished() -> void:
	$AnimatedSprite2D.play("Idle")
