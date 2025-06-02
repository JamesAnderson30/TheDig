extends "res://Actors/player/statetemplate.gd"

var state_name = "Running"

const SPEED = 130 #adjustable for sprint or w/e


func enter():
	player.animated_sprite.play("Run")
	
func process_input(event):
	pass

func exit():
	pass

func physics_process(_delta):
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction == 0:
		#player.change_state("Idle")
		return "Idling"
	player.velocity.x = direction * SPEED
	player.animated_sprite.flip_h = direction < 0
	player.move_and_slide()
	
	if Input.is_action_just_pressed("attack"):
		return "Attacking"
	return ""
