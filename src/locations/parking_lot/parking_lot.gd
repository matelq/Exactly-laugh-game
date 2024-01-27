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
	var dialogue = load("res://src/locations/parking_lot/parking_lot.dialogue")
	var ballon: Node = Ballon.instantiate()
	get_tree().current_scene.add_child(ballon)
	ballon.start(dialogue, "start")

func start_fight():
	await get_tree().create_timer(0.1).timeout
	$CharacterBody2D.handle_user_input(true)

var curr_dialogue = 1

func _on_enemy_damage_taken(value):
	$CharacterBody2D.handle_user_input(false)
	var dialogue = load("res://src/locations/parking_lot/parking_lot.dialogue")
	var ballon: Node = Ballon.instantiate()
	get_tree().current_scene.add_child(ballon)
	var pos = ""
	if curr_dialogue == 1:
		pos = "First"
	elif curr_dialogue == 2:
		pos = "Second"
	elif curr_dialogue == 3:
		pos = "Third"
	ballon.start(dialogue, pos)
	curr_dialogue += 1
	
func next_scene():
	pass

func _on_intro_finished():
	$FightTheme.play()

func _on_fight_theme_finished():
	$FightTheme.play()
