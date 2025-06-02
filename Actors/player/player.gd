extends CharacterBody2D

signal debug_signal

#coyote time variables.
var coyote_frames = 6
var coyote = false
var coyotePermitted = false

var is_attacking = false




const SPEED = 130.0 #could adjust for a sprint or w/e
const JUMP_VELOCITY = -300.0
var jumping = false

func _ready() -> void:
	$CoyoteTimer.wait_time = coyote_frames / 60.0
	
	ActorRegister.registerNPC(self, ActorRegister.getEntryByName("Player"))

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel") and Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

func _physics_process(delta):
	# Add the gravity so don't float
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jumpies
	if Input.is_action_just_pressed("ui_accept") and (is_on_floor() or coyote):
		#$AnimatedSprite2D.play("Jump")
		velocity.y = JUMP_VELOCITY
		jumping = true
		
	# Pressing 'G' lets you manually trigger things for testing
	if Input.is_action_just_pressed("debug_action"):
		ActorRegister.dumpNpcRegistry()

	if Input.is_action_just_pressed("attack") and not is_attacking:
		is_attacking = true
		print("attacked!")
		$AnimatedSprite2D.play("Attack")
		velocity.x = move_toward(velocity.x, 0, SPEED * 0.5)
		#Optional - can have a 'stop moving' or a slow down (as it is now)
		
		
	
	# Get the input direction and handle the movement/deceleration.
	# prolly replace UI default actions with our own custom ones..
	# add new animation sprite thingy? must research.
	var direction = Input.get_axis("ui_left", "ui_right")
	
	if not is_attacking:
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
	coyotePermitted = is_on_floor()
	if is_on_floor() and coyotePermitted and jumping:
		coyote = true
		$CoyoteTimer.start()

func _on_coyote_timer_timeout():
	coyote = false

#this function is for when any animation ends now..
func _on_AnimatedSprite2D_animation_finished():
	if $AnimatedSprite2D.animation == "Attack":
		is_attacking = false
		$AnimatedSprite2D.play("Idle")
