extends State
# File: res://Actors/Enemies/States/Idle_state.gd
# class_name IdleState # Optional: if you want to reference it by class name elsewhere
const name = "idle"

func _init(actor: Node): # Use _init for Objects, this runs when .new() is called
	self.actor = actor
	self.enter(actor)
	
func enter(actor):
	#print("Actor that entered idle State: ", actor)
	pass
	
func physics_update(delta):
	
	if(actor.position.distance_to(ActorRegister.getOneNodeByName("Player").position) < 100):
		print("Slime goes GRRRRRR!")
		return "chasePlayer"
	
	return ""
	pass


func exit():
	pass
