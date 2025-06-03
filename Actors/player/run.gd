extends "res://Actors/player/statetemplate.gd"

var state_name = "Running"




func enter():
	player.animated_sprite.play("Run")
	
func process_input(event):
	if(Input.is_action_just_pressed("space")):
		return "Jumping"
	pass

func exit():
	pass

func physics_process(_delta):
#	gravity
	if not player.is_on_floor():
		player.velocity += player.get_gravity() * _delta
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction == 0:
		#player.change_state("Idle")
		return "Idling"
	player.velocity.x = direction * player.SPEED
	player.animated_sprite.flip_h = direction < 0
	#player.move_and_slide()
	
	if Input.is_action_just_pressed("attack"):
		return "Attacking"
	return ""
