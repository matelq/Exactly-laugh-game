extends CharacterBody2D


@export var max_speed = 1000
@export var acceleration = 2500
@export var friction = 800
@export var isLeftRight = true
#const SPEED = 300.0
@export var JUMP_VELOCITY = -100.0
@export var animationVelocityThreshold = 10

var handle_input = true

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

# Define a list to store AnimatedSprite2D nodes
var animated_sprites: Array = []

var is_animation_stopped = false

signal collided_with_staticBody

func _ready():
	# Iterate through the children of the current node
	for child in get_children():
		# Check if the child is an AnimatedSprite2D node
		if child is AnimatedSprite2D:
			animated_sprites.append(child)

func _physics_process(delta):
	if isLeftRight:
		$MainCollider.disabled = false
		$TopDownCollider.disabled = true
	else:
		$MainCollider.disabled = true
		$TopDownCollider.disabled = false
	
	player_movement(delta)
	handle_player_animations()
	
func get_input():
	var input = Vector2.ZERO
	
	input.x = int(Input.is_action_pressed("right")) - int(Input.is_action_pressed("left"))
	input.y = int(Input.is_action_pressed("down")) - int(Input.is_action_pressed("up"))
	
	var is_jump = false
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		is_jump = true
	
	# Create a dictionary to hold the values
	var result = {
		"input": input.normalized(),
		"is_jump": is_jump
	}	
	return result

func handle_player_animations():
	if not handle_input:
		return
	if (velocity.length() == 0):
		if (Input.is_action_pressed("rightF")):
			$mayor_walk_middleF.scale.x = abs($mayor_walk_middleF.scale.x)
			$mayor_walk_middleF/HitBox/CollisionShape2D.disabled = false
			show_play_animation($mayor_walk_middleF)
			$mayor_walk_middleF/HitBox/CollisionShape2D.disabled = true
		elif (Input.is_action_pressed("leftF")):
			$mayor_walk_middleF.scale.x = -abs($mayor_walk_middleF.scale.x)
			show_play_animation($mayor_walk_middleF)
		elif not is_animation_stopped:
			show_play_animation($"mayor-idle-animation2")
		return
	
	is_animation_stopped = false
	if (abs(velocity.y) < animationVelocityThreshold) or gravityEnabled:
		# x axe animations
		if (velocity.x > 0):
			show_play_animation($mayor_walk_right2)
		elif (velocity.x < 0):
			show_play_animation($mayor_walk_left2)
	else:
		# y axe animations
		if (velocity.y > 0):
			show_play_animation($mayor_walk_forward)
		elif (velocity.y < 0):
			show_play_animation($mayor_walk_backward)


func show_play_animation(sprite: AnimatedSprite2D):
	sprite.show()
	sprite.play()
	reset_animations_besides(sprite)

func reset_animations_besides(sprite: AnimatedSprite2D):
	for item in animated_sprites:
		if (item == sprite):
			continue
		item.hide()
		item.set_frame(0)
	

func player_movement(delta):
	if not is_on_floor() and isLeftRight:
		velocity.y += gravity * delta
	
	if not handle_input:
		move_and_slide()
		process_collisions()
		return
	
	var input_result = get_input()

	var input_vector = input_result["input"]
	var is_jump = input_result["is_jump"]
	
	if input_vector.x == 0:
		if abs(velocity.x) > (friction * delta):
			velocity.x -= friction * delta * sign(velocity.x)
		else:
			velocity.x = 0
	else:
		velocity.x += (input_vector.x * acceleration * delta)
		velocity.x = min(abs(velocity.x), max_speed) * sign(velocity.x)
	
	if !isLeftRight:
		if input_vector.y == 0:
			if abs(velocity.y) > (friction * delta):
				velocity.y -= friction * delta * sign(velocity.y)
			else:
				velocity.y = 0
		else:
			velocity.y += (input_vector.y * acceleration * delta)
			velocity.y = min(abs(velocity.y), max_speed) * sign(velocity.y)
	
	if is_jump and is_on_floor():
		velocity.y += JUMP_VELOCITY
	move_and_slide()
	process_collisions()

func look_right():
	is_animation_stopped = true
	var sprite = $mayor_walk_right2
	show_play_animation(sprite)
	sprite.stop()
	
func do_the_idle():
	var sprite = $"mayor-idle-animation2"
	show_play_animation(sprite)

func process_collisions():
	for i in get_slide_collision_count():
		var col = get_slide_collision(i)
		if col.get_collider() is StaticBody2D:
			collided_with_staticBody.emit()


func handle_user_input(value: bool):
	handle_input = value
