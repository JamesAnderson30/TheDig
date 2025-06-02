extends CharacterBody2D

#signal debug_signal

#class_name Player

# Hello love, I'll try to explain what we are trying to achieve
# First thing's first, we're going to preload the individual state files
# So we can work with them. Let's do that below:

# Notice that I'm using the keyword "const". That means constant.
# It's like a variable, except it never changes. Not super important, just know
# No changes!
# Also because these are class files, make sure to capitalize them and use underscores c:

# You can drag and drop the file you want into the code editor too
# const Attacking_State = preload(**Drag file here**)
const Attacking_State = preload("res://Actors/player/attack.gd")
const Idling_State = preload("res://Actors/player/idle.gd")
const Running_State = preload("res://Actors/player/run.gd")

# These states are just saved in memory now, but how do we know which state we are in?
# By creating a current_state variable and setting it to either of these constants.
# Let's create a variable called current_state and set it to the Idling_State as default
var current_state = Idling_State.new(self)



#@onready
#var current_State = $State
@onready
var animated_sprite = $Animations



func _ready():
	#current_State.set_player(self)
	
#	So this is how we change state, we just pass the state_name to the change_state function
#	This is why we put a variable state_name in each state, this is what the strings have to match
#	Checkout the change_state function below to take a look!
	#change_state("Idling")
	ActorRegister.registerNPC(self, ActorRegister.getEntryByName("Player"))

func _unhandled_input(event: InputEvent):
	current_state.process_input(event)
#
func _physics_process(delta:float):
	if current_state:
#		Just some error checking
		if(!current_state.has_method("physics_process")):
			printerr(current_state.state_name, " has no pysics_process function. Every state must have a physics_process function")
		var next_state_name = current_state.physics_process(delta)
		if(typeof(next_state_name) == TYPE_NIL):
			printerr(self.get_name(), "'s current_state.physics_process returned nothing! It must return a string, even an empty one")
		
		if next_state_name != "":
			print("next state: ", next_state_name)
			# Convert string back to enum to call change_State
			match next_state_name:
				"Idling": change_state(next_state_name)
				"Running": change_state(next_state_name)
				"Attacking": change_state(next_state_name)
				"Falling": change_state(next_state_name)
				"Jumping": change_state(next_state_name)
				"Damaged": change_state(next_state_name)
				_: printerr(name, ": State ", current_state.state_name, " requested unknown next state '", next_state_name, "'")

	#current_State.process_physics(delta)
	if not is_on_floor():
		velocity += get_gravity() * delta
#
#func _process(delta: float):
	#current_State.process_frame(delta)

#func change_state(new_state: String):
	#current_State.change_state(new_state)

func change_state(new_state_name: String) -> void:
#	So first off, new_state_name is the name of the state we passed to change_state
#	This next line checks to see if we're trying to change to the state we're already in
#	If the new state and the old state is the same, we simply do nothing and return
	if current_state and current_state.state_name == new_state_name:
		return # Already in this state

#	If we are in fact, changing to a different state, we need to call our old state's
#	exit function. It doesn't matter if exit() does nothing right now, but if we want something
#	to happen when a state ends, this is where it happens.
#		A great example of this is playing a landing animation when your character lands on the ground
	if current_state:
		current_state.exit() # Call exit on the old state

#	After we are done calling the exit function of our old state, now it's time
#	to find the new state we called for.
#	Remember, we're trying to 'match' the new_state_name to the state_name in each file

#	Nowtice how we're simply changing the current state to our pre-loaded files
#	That way, if you call current_state.process_update, it will call the process_update
#	inside the file that you set current_state too
	match new_state_name:
		"Idling":
			current_state = Idling_State.new(self)
		"Attacking":
			current_state = Attacking_State.new(self)
		"Running":
			current_state = Running_State.new(self)
		_: #Error - State doesn't exist
			printerr("Attempted to change to unknown state: ", new_state_name)
			current_state = Idling_State.new(self) # Default to idle on error

	current_state.enter() # Call enter on the new state
	# print(name, " changed to state: ", current_state.state_name)

# ---USEFUL CODE, COPY AND PASTE LATER DO NOT DELETE MWAH I LOVE YOU ---

##past this is working code, just not within state machine
#var coyote_frames = 6
#var coyote = false
#var coyotePermitted = false
#
#var is_attacking = false
#
#
#
#
#const SPEED = 130.0 #could adjust for a sprint or w/e
#const JUMP_VELOCITY = -300.0
#var jumping = false
#
#func _ready() -> void:
	#$CoyoteTimer.wait_time = coyote_frames / 60.0
	#
	#ActorRegister.registerNPC(self, ActorRegister.getEntryByName("Player"))
#
#func _input(event: InputEvent) -> void:
	#if event.is_action_pressed("ui_cancel") and Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		#Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
#
#func _physics_process(delta):
	## Add the gravity so don't float
	#if not is_on_floor():
		#velocity += get_gravity() * delta
#
	## Handle jumpies
	#if Input.is_action_just_pressed("ui_accept") and (is_on_floor() or coyote):
		##$AnimatedSprite2D.play("Jump")
		#velocity.y = JUMP_VELOCITY
		#jumping = true
		#
	## Pressing 'G' lets you manually trigger things for testing
	#if Input.is_action_just_pressed("debug_action"):
		#ActorRegister.dumpNpcRegistry()
#
	#if Input.is_action_just_pressed("attack") and not is_attacking:
		#is_attacking = true
		#print("attacked!")
		#$AnimatedSprite2D.play("Attack")
		#velocity.x = move_toward(velocity.x, 0, SPEED * 0.5)
		##Optional - can have a 'stop moving' or a slow down (as it is now)
		#
		#
	#
	## Get the input direction and handle the movement/deceleration.
	## prolly replace UI default actions with our own custom ones..
	## add new animation sprite thingy? must research.
	#var direction = Input.get_axis("ui_left", "ui_right")
	#
	#if not is_attacking:
		#if direction:
			#velocity.x = direction * SPEED
			#$AnimatedSprite2D.flip_h = direction < 0
		#
			#if(direction != 0) and is_on_floor() and $AnimatedSprite2D.animation != "Run":
				#$AnimatedSprite2D.play("Run")
#
		#else:
			#velocity.x = move_toward(velocity.x, 0, SPEED)
			#if (direction == 0) and is_on_floor() and $AnimatedSprite2D.animation != "Idle" and $AnimatedSprite2D.animation != "Attack":
				#$AnimatedSprite2D.play("Idle")
#
	#move_and_slide()
	#coyotePermitted = is_on_floor()
	#if is_on_floor() and coyotePermitted and jumping:
		#coyote = true
		#$CoyoteTimer.start()
#
#func _on_coyote_timer_timeout():
	#coyote = false
#
##this function is for when any animation ends now..
#func _on_AnimatedSprite2D_animation_finished():
	#if $AnimatedSprite2D.animation == "Attack":
		#is_attacking = false
		#$AnimatedSprite2D.play("Idle")
