extends CharacterBody2D


@export var max_speed = 1000
@export var acceleration = 2500
@export var friction = 800

#const SPEED = 300.0
@export var JUMP_VELOCITY = -100.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

# Define a list to store AnimatedSprite2D nodes
var animated_sprites: Array = []

func _ready():
	# Iterate through the children of the current node
	for child in get_children():
		# Check if the child is an AnimatedSprite2D node
		if child is AnimatedSprite2D:
			animated_sprites.append(child)

func _physics_process(delta):
	player_movement(delta)
	handle_player_animations()
	
func get_input():
	var input = Vector2.ZERO
	input.x = int(Input.is_action_pressed("right")) - int(Input.is_action_pressed("left"))
	
	var is_jump = false
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		is_jump = true
	
	# Create a dictionary to hold the values
	var result = {
		"input": input,
		"is_jump": is_jump
	}
	
	return result

func handle_player_animations():
	if (velocity.x > 0):
		show_play_animation($mayor_walk_right2)
	elif (velocity.x < 0):
		show_play_animation($mayor_walk_left2)
	elif (velocity.length() == 0):
		if (Input.is_action_pressed("rightF")):
			$mayor_walk_middleF.flip_h = false
			show_play_animation($mayor_walk_middleF)
		elif (Input.is_action_pressed("leftF")):
			$mayor_walk_middleF.flip_h = true
			show_play_animation($mayor_walk_middleF)
		else:
			show_play_animation($"mayor-idle-animation2")
	


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

func reset_animation(sprite: AnimatedSprite2D):
	sprite.hide()
	sprite.set_frame(0)
	

func player_movement(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
	
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
	
	if is_jump and is_on_floor():
		velocity.y += JUMP_VELOCITY
	
	move_and_slide()



	 
