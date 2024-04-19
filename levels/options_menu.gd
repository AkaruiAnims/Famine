extends Control



func _on_reset_pressed():
	#get_tree().change_scene_to_file("res://scenes/test_debug.tscn")
	print("pressed!")



func _on_back_pressed():
	get_tree().change_scene_to_file("res://levels/title.tscn")
