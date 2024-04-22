extends CharacterBody2D

@export var speed : float = 100.0;
@export var jumpUpgradeLevel : int = 1; # with a max of 5
@export var foodLevel : int = 0;
@export var maxFood : int = 5;
@export var UiLabel : Label;
var jumpVelocity = [-150.0, -240.0, -310.0, -425.0, -500.0] 
var jumpPower = 1; # with a max of 5
var is_running = false;
var is_falling = false;
var is_emoting = false;
var is_holdingRun = false;
var jumpIndex = 0;
var targetTime;
var targetTimeIsSet = false;
var jumpIsHeld = false;
var lastCheckPoint : Vector2;
var playerInfo : Node;
var jumpContainer;
var sleepUnlock;
var justDied = false;

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	playerInfo = get_node("/root/PlayerInfo");
	jumpContainer = get_node("JumpContainer");
	lastCheckPoint = Vector2( position.x, position.y );
	#foodLevel = playerInfo.foodLevel;
	jumpUpgradeLevel = playerInfo.jumpUpgradeLevel;
	sleepUnlock = playerInfo.sleepUnlock;
	

func _physics_process(_delta):
	
	#if Input.is_action_just_pressed("block"):
		#foodLevel = 5;
	#
	if Input.is_action_just_pressed("sleep") && is_on_floor() && sleepUnlock == true:
		$PlayerAnimation.play("Sleep")
		is_emoting = !is_emoting
		return
	elif is_emoting == true:
		return
	
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * _delta
		$PlayerAnimation.play("Falling")
		is_falling = true
	elif is_falling == true:
		$PlayerAnimation.play("Land")
		is_falling = false

	if Input.is_action_just_pressed("dash"):
		is_running = true
		speed = 150.0
	elif is_running == true && Input.is_action_just_released("dash"):
		is_running = false
		speed = 100.0

	# Handle jump.
	if (Input.is_action_just_pressed("jump") || jumpIsHeld == true || Input.is_action_just_released("jump")) and is_on_floor():
		if justDied:
			justDied = false;
			return
			
		if jump_hold() == true || Input.is_action_just_released("jump"):
			jumpIsHeld = false;
			targetTimeIsSet = false;
			jumpContainer.hideJumps();
			velocity.y = jumpVelocity[jumpIndex];
			$PlayerAnimation.play("Jump");
	else:
		if justDied:
			jumpIsHeld = false;
			jumpPower = 1;
			jumpIndex = 0;
			targetTimeIsSet = false;
			jumpContainer.hideJumps();

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * speed
		if is_on_floor():
			$PlayerAnimation.play("Walk")
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		if is_on_floor():
			$PlayerAnimation.play("Idle")
		
	if position.y > 44:
		death();
		
	update_player_score()
	update_facing_direction()
	move_and_slide()
	
func death():
	position = lastCheckPoint;
	justDied = true;

func newCheckPoint( ):
	lastCheckPoint.x = position.x;
	lastCheckPoint.y = position.y;

func update_facing_direction():
	if Input.get_action_strength("left") and Input.get_action_strength("right"):
		return
	if Input.get_action_strength("left") and $playerSprite.flip_h != true:
		$playerSprite.flip_h = true
	elif Input.get_action_strength("right") and $playerSprite.flip_h != false:
		$playerSprite.flip_h = false
		
func update_player_score():
	UiLabel.text = str(foodLevel);
		
func jump_hold():
	
	if targetTimeIsSet == false:
		targetTime = Time.get_ticks_msec() + 1500;
		targetTimeIsSet = true;
		jumpIsHeld = true;
		jumpPower = 1;
		jumpIndex = 0;
	
	if jumpContainer.jumps[jumpPower].visible == false:
		jumpContainer.jumps[jumpPower].visible = true;
	
		
	if jumpPower == jumpUpgradeLevel: 
		return true;
		
	if Time.get_ticks_msec() > targetTime:
		jumpPower = jumpPower + 1;
		targetTime = targetTime + 1500;
		jumpIndex = jumpIndex + 1;
	return false
