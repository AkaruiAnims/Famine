extends Area2D

var foodValue = 1
var foodType = "meat"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass



func _on_body_entered(body):
	if body.name == "Player" && body.get_node_or_null("Sprite") != null :
		body.foodLevel = body.foodLevel + foodValue
		get_tree().queue_delete(self)
