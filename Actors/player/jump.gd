extends "res://Actors/player/statetemplate.gd"

var state_name = "Jumping"

#How many frames the player has the chance to rise into the air
const jump_grace_period = 3
var framesSinceJump = 0
var extraJumps

# Big Note to my precious Auri, if you need to make things
# Happen to the player, the player node is called "player"
#enters state..
func enter():
	player.animated_sprite.play("Jump")
	extraJumps = player.EXTRA_JUMPS
	framesSinceJump = 0
	player.velocity.y += player.JUMP_POWER
	pass
	
func process_input(event):
	var direction = Input.get_axis("ui_left", "ui_right")
	var target_velocity = direction * (player.SPEED * player.AIR_SPEED_MULTIPLIER)
	player.velocity.x = lerp(player.velocity.x, target_velocity, player.AIR_SPEED_ACCELERATION)
	player.animated_sprite.flip_h = direction < 0
	
	if(Input.is_action_just_pressed("space") and extraJumps > 0):
			player.animated_sprite.play("Jump")
			player.velocity.y = player.JUMP_POWER
			extraJumps -= 1
	pass

#when it processes stuff..?
func physics_process(delta):
#	This simulates the fall slowing down
	framesSinceJump += 1
	player.velocity += player.get_gravity() * delta
	print("Frames Since Jump: ", framesSinceJump)
	if(player.is_on_floor() and framesSinceJump > jump_grace_period):
		return "Idling"
	return ""

func exit():
	pass
