extends CharacterBody2D

signal collided_with_staticBody

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

# Called when the node enters the scene tree for the first time.
func _ready():
	$Walk.hide()
	$Idle.show()
	$AnimationPlayer.play("stand")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
		
	move_and_slide()
	process_collisions()

func look_left():
	$Idle.hide()
	$Walk.show()

func process_collisions():
	for i in get_slide_collision_count():
		var col = get_slide_collision(i)
		if col.get_collider() is StaticBody2D:
			collided_with_staticBody.emit()
