extends CharacterBody2D

const IDLE_STATE = preload("res://Actors/enemy/fruits/testFruitEnemy/State/idle.gd")
const CHASE_PLAYER_STATE = preload("res://Actors/enemy/fruits/testFruitEnemy/State/chasePlayer.gd")

var current_state

const SPEED = 300.0
const JUMP_VELOCITY = -400.0



func _ready():
	current_state = IDLE_STATE.new(self)
	$Sprite2D/AnimationPlayer.play("Idle")
	
func _physics_process(delta: float) -> void:
	
	if current_state:
		
		var next_state_name: String = current_state.physics_update(delta)
		
		
		if next_state_name != "":
			print("next state: ", next_state_name)
			# Convert string back to enum to call change_state
			match next_state_name:
				"idle": change_state(next_state_name)
				"chasePlayer": change_state(next_state_name)
				_: printerr(name, ": State ", current_state.state_name, " requested unknown next state '", next_state_name, "'")
	# Add the gravity.
	#if not is_on_floor():
		#velocity += get_gravity() * delta
#
	## Handle jump.
	#if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		#velocity.y = JUMP_VELOCITY
#
	## Get the input direction and handle the movement/deceleration.
	## As good practice, you should replace UI actions with custom gameplay actions.
	#var direction := Input.get_axis("ui_left", "ui_right")
	#if direction:
		#velocity.x = direction * SPEED
	#else:
		#velocity.x = move_toward(velocity.x, 0, SPEED)
#
	#move_and_slide()
	pass
	
func change_state(new_state_name: String) -> void:
	if current_state and current_state.state_name == new_state_name:
		return # Already in this state

	if current_state:
		current_state.exit() # Call exit on the old state

	match new_state_name:
		"idle":
			current_state = IDLE_STATE.new(self)
		"chasePlayer":
			current_state = CHASE_PLAYER_STATE.new(self)
			# Special setup for ChaseTargetState if needed, e.g., passing nav_agent
			# (Though the state now gets it from the actor)
		_:
			printerr("Attempted to change to unknown state: ", new_state_name)
			current_state = IDLE_STATE.new(self) # Default to idle on error

	current_state.enter(self) # Call enter on the new state
	# print(name, " changed to state: ", current_state.state_name)
