extends Area2D
@export var level : Node2D;

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _change_scene():
	if level.name == "level_3":
		get_tree().change_scene_to_file("res://levels/titleMenu.tscn")
	
	if level.name == "level_1":
		get_tree().change_scene_to_file("res://levels/level_2.tscn")
	else:
		get_tree().change_scene_to_file("res://levels/level_3.tscn")

func _on_body_entered(body):
	if body.get_node_or_null("playerSprite") != null :
		if body.foodLevel >= 5:
			body.playerInfo.foodLevel = body.foodLevel;
			body.playerInfo.jumpUpgradeLevel = body.jumpUpgradeLevel
			_change_scene()


