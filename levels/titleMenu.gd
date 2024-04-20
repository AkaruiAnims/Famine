extends Control
var playerInfo;

func _ready():
	playerInfo = get_node("/root/PlayerInfo")
	if playerInfo.newGamePlus == true:
			get_node("MarginContainer/VBoxContainer/Play").text = "Play+"

func _on_play_pressed():
	get_tree().change_scene_to_file("res://levels/level_1.tscn")

func _on_options_pressed():
	get_tree().change_scene_to_file("res://levels/options_menu.tscn")

func _on_exit_pressed():
	get_tree().quit()
