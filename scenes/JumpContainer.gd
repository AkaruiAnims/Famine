extends Node2D
var jumps = {};

# Called when the node enters the scene tree for the first time.
func _ready():
	jumps = {
		1 : get_node("Jump1"),
		2 :	get_node("Jump2"),
		3 :	get_node("Jump3"),
		4 :	get_node("Jump4"),
		5 :	get_node("Jump5")
	}

func hideJumps():
	jumps[1].visible = false;
	jumps[2].visible = false;
	jumps[3].visible = false;
	jumps[4].visible = false;
	jumps[5].visible = false;

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
