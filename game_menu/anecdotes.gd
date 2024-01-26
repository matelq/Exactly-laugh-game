extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	update_anecdote()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_back_button_pressed():
	get_tree().change_scene_to_file("res://game_menu/menu.tscn")


func _on_next_button_pressed():
	update_anecdote()
	
func update_anecdote():
	pass
