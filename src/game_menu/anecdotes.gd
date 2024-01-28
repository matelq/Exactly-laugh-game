extends Node2D

@export var aneci_speed = 75
var is_aneci_move = true
# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if is_aneci_move:
		$Anecdore.position.y -= delta*aneci_speed
	pass

func stop_moving():
	is_aneci_move = false
	pass

func continue_moving():
	is_aneci_move = true


func _on_back_button_pressed():
	get_tree().change_scene_to_file("res://src/game_menu/menu.tscn")


func _on_next_button_pressed():
	update_anecdote()
	
func update_anecdote():
	var dialog = load("res://src/anecdotes.dialogue")
	DialogueManager.show_example_dialogue_balloon(dialog, "razgovor")
	pass

func stop_audi():
	$AudioStreamPlayer.stop()
	pass

func start_audi():
	$AudioStreamPlayer.play()
	pass

func _on_audio_stream_player_finished():
	$AudioStreamPlayer.play()
	pass # Replace with function body.
