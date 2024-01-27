extends Node2D

var isNextSceneCollide = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if isNextSceneCollide:
		$progress_label.show()
		if Input.is_action_just_pressed("ui_accept"):
			get_tree().change_scene_to_file("res://src/locations/resto/Resto_inside.tscn") 
	else:
		$progress_label.hide()
	pass


func _on_enter_resto_body_entered(body):
	isNextSceneCollide = true
	pass # Replace with function body.


func _on_enter_resto_body_exited(body):
	isNextSceneCollide = false
	pass # Replace with function body.
