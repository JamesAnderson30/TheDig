extends Node

#defining variables

var player = null
var current_state = null

#this function takes the data 
func set_player(player_Ref):
	player = player_Ref
	for child in get_children():
		if "player" in child:
			child.player = player

func change_state(state_name: String):
	if current_state:
		current_state.exit()
	current_state = get_node(state_name)
	current_state.enter()




func process_input(event):
	print("Input recieved..")
	if event.is_action_pressed("ui_cancel") and Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
