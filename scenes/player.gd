extends CharacterBody2D

@export var speed : float = 100.0
@export var jumpVelocity : float = -300.0
@export var foodLevel : int = 1;
@export var maxFood : int = 5;
@export var UiLabel : Label;
var is_running = false;
var falling = false;
var is_sleeping = false;

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta):
	if Input.is_action_just_pressed("block"):
		print(foodLevel)
	
	if Input.is_action_just_pressed("sleep"):
		$PlayerAnimation.play("Sleep")
		is_sleeping = !is_sleeping
		return
	elif is_sleeping == true:
		return
	
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
		$PlayerAnimation.play("Falling")
		falling = true
	elif falling == true:
		$PlayerAnimation.play("Land")
		falling = false

	if Input.is_action_just_pressed("dash"):
		is_running = true
		speed = 200.0
	elif is_running == true && Input.is_action_just_released("dash"):
		is_running = false
		speed = 100.0

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jumpVelocity
		$PlayerAnimation.play("Jump")

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

	update_player_score()
	update_facing_direction()
	move_and_slide()

func update_facing_direction():
	if Input.get_action_strength("left") and Input.get_action_strength("right"):
		return
	if Input.get_action_strength("left") and $playerSprite.flip_h != true:
		$playerSprite.flip_h = true
	elif Input.get_action_strength("right") and $playerSprite.flip_h != false:
		$playerSprite.flip_h = false
		
func update_player_score():
	if ( int(UiLabel.text) < foodLevel  ):
		UiLabel.text = str(foodLevel)
