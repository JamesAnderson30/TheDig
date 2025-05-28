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
		#$AnimatedSprite2D.play("Jump")
		velocity.y = JUMP_VELOCITY
		
	# Pressing 'G' lets you manually trigger things for testing
	if Input.is_action_just_pressed("debug_action"):
		print(ActorRegister.getById("TestEnemy"))

	if Input.is_action_just_pressed("attack"):
		print("attacked!")
		$AnimatedSprite2D.play("Attack")
		return
		
		
	# Get the input direction and handle the movement/deceleration.
	# prolly replace UI default actions with our own custom ones..
	# add new animation sprite thingy? must research.
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
		$AnimatedSprite2D.flip_h = direction < 0
		
		if(direction != 0) and is_on_floor() and $AnimatedSprite2D.animation != "Run":
			$AnimatedSprite2D.play("Run")

	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		if (direction == 0) and is_on_floor() and $AnimatedSprite2D.animation != "Idle" and $AnimatedSprite2D.animation != "Attack":
			$AnimatedSprite2D.play("Idle")

	move_and_slide()


func _attack_animation_finished() -> void:
	$AnimatedSprite2D.play("Idle")
