extends Node

var isNextSceneCollide = false

# Called when the node enters the scene tree for the first time.
func _ready():


	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if isNextSceneCollide:
		$progress_label.show()
	if Input.is_action_just_pressed("ui_accept"):
		get_tree().change_scene_to_file("res://src/locations/parking_lot_peacefull/ParkingLotPeacefull.tscn") 
	else:
		$progress_label.hide()
	
	if Input.is_action_just_pressed("E"):
		$Code.show()
	


func _on_code_enter_button():
	$Code.hide()
	$textures/door_textures/door_closed.hide()
	$textures/door_textures/door_opened.show()
	$door_body/door_collider.disabled = true


func _on_exit_to_parking_body_entered(body):
	get_tree().change_scene_to_file("res://src/locations/parking_lot_peacefull/ParkingLotPeacefull.tscn") 
	isNextSceneCollide = true
	pass # Replace with function body.


func _on_exit_to_parking_body_exited(body):
	isNextSceneCollide = false
	pass # Replace with function body.
