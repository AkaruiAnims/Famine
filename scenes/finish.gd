extends Area2D
@export var level : Node2D;
var player;

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _change_scene():
	if level.name == "Level_3":
		player.playerInfo.newGamePlus = true;
		get_tree().change_scene_to_file("res://levels/title.tscn")
		return
	
	if level.name == "Level_1":
		get_tree().change_scene_to_file("res://levels/level_2.tscn")
	else:
		get_tree().change_scene_to_file("res://levels/level_3.tscn")

func _on_body_entered(body):
	if body.get_node_or_null("playerSprite") != null :
		if body.foodLevel >= 4:
			#body.playerInfo.foodLevel = body.foodLevel;
			player = body;
			body.playerInfo.jumpUpgradeLevel = body.jumpUpgradeLevel
			_change_scene()


