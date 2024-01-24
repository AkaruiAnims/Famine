extends CharacterBody2D

@export var speed : float = 200.0
@export var jumpVelocity : float = -300.0
@export var foodLevel : int = 1;
@export var maxFood : int = 5;

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
		$PlayerAnimation.play("Jump")

	if Input.is_action_just_pressed("dash"):
		print(foodLevel)

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jumpVelocity

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * speed
		$PlayerAnimation.play("Walk")
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		if is_on_floor():
			$PlayerAnimation.play("Idle")

	update_facing_direction()
	move_and_slide()

func update_facing_direction():
	if Input.get_action_strength("left") and Input.get_action_strength("right"):
		return
	if Input.get_action_strength("left") and $playerSprite.flip_h != true:
		$playerSprite.flip_h = true
		$PlayerAnimation.play("Turn Around")
	elif Input.get_action_strength("right") and $playerSprite.flip_h != false:
		$playerSprite.flip_h = false
		$PlayerAnimation.play("Turn Around")
		
		
