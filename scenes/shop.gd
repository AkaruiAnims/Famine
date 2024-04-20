extends Area2D
var player;
var upgrade = false;
var oneTime;
var seeText;

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if seeText == true:
		$TextBox.visible = true;
	
	if 	player != null:
		if Input.is_key_pressed(KEY_E): 
			if player.foodLevel > 4 && upgrade == true:
				player.jumpUpgradeLevel = player.jumpUpgradeLevel + 1;
				player.playerInfo.jumpUpgradeLevel = player.playerInfo.jumpUpgradeLevel + 1;
			elif oneTime == true:
				player.jumpUpgradeLevel = player.jumpUpgradeLevel + 1;
				player.playerInfo.jumpUpgradeLevel = player.playerInfo.jumpUpgradeLevel + 1;
			else:
				print("chat");
		
	
func _on_body_entered(body):
	if body.get_node_or_null("playerSprite") != null :
		body.newCheckPoint();
		body.playerInfo.atCheckPoint = true;
		player = body;


func _on_body_exited(body):
	if body.get_node_or_null("playerSprite") != null :
		body.playerInfo.atCheckPoint = false;
		player = null;
