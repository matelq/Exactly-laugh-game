extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$CharacterBody2D.do_the_idle()
	$CharacterBody2D.handle_user_input(false)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

var has_looked_right = false
func _on_character_body_2d_collided_with_static_body():
	if has_looked_right:
		return
	$CharacterBody2D.look_right()
	has_looked_right = true
	if has_looked_left:
		start_dialogue()

var has_looked_left = false
func _on_enemy_collided_with_static_body():
	if has_looked_left:
		return
	$Enemy.look_left()
	has_looked_left = true
	if has_looked_right:
		start_dialogue()


const Ballon = preload("res://src/locations/parking_lot/balloon.tscn")

func start_dialogue():
	var ballon: Node = Ballon.instantiate()
	get_tree().current_scene.add_child(ballon)
	var dialogue = load("res://src/locations/parking_lot/parking_lot.dialogue")
	ballon.start(dialogue, "start")

func start_fight():
	await get_tree().create_timer(0.1).timeout
	$CharacterBody2D.handle_user_input(true)
