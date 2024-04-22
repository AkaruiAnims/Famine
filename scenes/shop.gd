extends Area2D
var player;
var upgrade = false;
var oneTime;
var firstChat;
var seeText;
var textBox;
var text;
var textBoxVisible = false;
var setText;
var newGamePlus;
var textPass = false;
var isFed = false;
var reset

# Called when the node enters the scene tree for the first time.
func _ready():
	textBox = find_child("TextBox");
	text = find_child("text");

func dialogue():
	if  newGamePlus && isFed:
		text.text = "Thank you! ( press 4 )"
		reset = true;
		isFed = false;
	elif firstChat == true :
		text.text = "You seem hungry, best get some food on your way home, and since cats don't like water \n you should stay away from it!, I'll help you back if you're in danger tho :D";
	elif oneTime == true && textPass == false :
		text.text = "I can teach you to jump higher, normally I'd ask for 2 foods, but this time you get 50% off. \n Hint: Hold the space button untill you jump or see 2+ arrows!";		
	elif newGamePlus == true :
		text.text = "Come back to me with 2 foods and I'll give you \n a reward :D ( food must be 6+ )";
	elif isFed:
		text.text = "Thank you!"
		isFed = false;
		reset = true;
	else:
		upgrade = true;
		text.text = "Feed me 2 food for Jump Upgrades (food must be 6 or more) \n and stay clear of water and other rats!";
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if seeText == true:
		$TextBox.visible = true;
	
	if 	player != null:
		if Input.is_action_just_pressed("Interact"): 
			if player.foodLevel >= 6 && upgrade == true && player.jumpUpgradeLevel != 5:
				player.foodLevel = player.foodLevel - 2;
				player.jumpUpgradeLevel = player.jumpUpgradeLevel + 1;
				player.playerInfo.jumpUpgradeLevel = player.playerInfo.jumpUpgradeLevel + 1;
				isFed = true;
				dialogue();
			elif isFed:
				dialogue();
			elif firstChat == true:
				dialogue();
				textBoxVisible = true;
				textBox.visible = true;
				textPass = true;
				firstChat = false;
				player.playerInfo.firstChat = false;
			elif oneTime == true && textPass == false:
				player.jumpUpgradeLevel = player.jumpUpgradeLevel + 1;
				player.playerInfo.jumpUpgradeLevel = player.playerInfo.jumpUpgradeLevel + 1;
				player.foodLevel = player.foodLevel -1;
				player.playerInfo.oneTime = false;
				dialogue();
				textBoxVisible = true;
				textBox.visible = true;
				oneTime = false;
			else:
				if reset == true:
					textBox.visible = false;
					textBoxVisible = false;
					reset = false;
				elif textBoxVisible == true:
					if newGamePlus == true && player.foodLevel >= 6:
						player.sleepUnlock = true;
						player.playerInfo.sleepUnlock = true;
						player.foodLevel = player.foodLevel - 2;
						isFed = true;
						dialogue();
				else:
					textBox.visible = true;
					textBoxVisible = true;
					dialogue();
					
func _on_body_entered(body):
	if body.get_node_or_null("playerSprite") != null :
		body.newCheckPoint();
		body.playerInfo.atCheckPoint = true;
		firstChat = body.playerInfo.firstChat;
		oneTime = body.playerInfo.oneTime;
		newGamePlus = body.playerInfo.newGamePlus;
		player = body;


func _on_body_exited(body):
	if body.get_node_or_null("playerSprite") != null :
		body.playerInfo.atCheckPoint = false;
		player = null;
