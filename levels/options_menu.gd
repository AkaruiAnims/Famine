extends Control
var playerInfo;

func _ready():
	playerInfo = get_node("/root/PlayerInfo")
			

func _on_reset_pressed():
	playerInfo.newGamePlus = false;
	playerInfo.jumpUpgradeLevel = 1;
	playerInfo.firstChat = true;
	playerInfo.oneTime = true;
	playerInfo.sleepUnlock = false;
	


func _on_back_pressed():
	get_tree().change_scene_to_file("res://levels/title.tscn")
