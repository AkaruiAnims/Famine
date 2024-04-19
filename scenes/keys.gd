extends Node2D

@export var key_name : String ;
var child;

# Called when the node enters the scene tree for the first time.
func _ready():
	child = find_child(key_name);
	child.visible = true;


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$AnimationPlayer.play(key_name)
