extends Node

var isNextSceneCollide = false
var isDoorDialog = false
var isEnemyDialog = false
var isCodeLocked = true

# Called when the node enters the scene tree for the first time.
func _ready():
	if get_node("/root/GlobalContext").is_code_active_lock:
		$"TextureRect#Enemy".hide()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if isNextSceneCollide:
		$progress_label.show()
		if Input.is_action_just_pressed("ui_accept"):
			get_tree().change_scene_to_file("res://src/locations/parking_lot_peacefull/ParkingLotPeacefull.tscn") 
	else:
		$progress_label.hide()
	pass
	
	if not is_E:
			return
	if isDoorDialog and isCodeLocked:
		$door_label.show()
		if Input.is_action_just_pressed("E"):
			if get_node("/root/GlobalContext").is_code_active_lock:
				$Code.show()
				$Camera.followNode = $code_camera
			else:				
				#$Camera.limit_left = 0
				#$Camera.limit_top = 0
				#$Camera.limit_right = 905
				#$Camera.limit_bottom = 905
				FUNCIA_DLYA_SEVY_ON_DVER_APPROACH_AND_CLICK()
				pass
		else:
			pass
	else:
		$door_label.hide()
	
	if isEnemyDialog and !get_node("/root/GlobalContext").is_code_active_lock:
		$enemy_label.show()
		if Input.is_action_just_pressed("E"):
			SEVUHA_ENEMY_MAKER_DIALOG_CHALLENGER()
	else:
		$enemy_label.hide()
	
func SEVUHA_ENEMY_MAKER_DIALOG_CHALLENGER():
	START_DIALOG_WITH_MUDAK_FOR_MATVEY()

var is_E = true
func release_E():
	is_E = true

func FUNCIA_DLYA_SEVY_ON_DVER_APPROACH_AND_CLICK():
	is_E = false
	var dialog = load("res://src/locations/resto/resto.dialogue")
	DialogueManager.show_example_dialogue_balloon(dialog, "lock")


func _on_code_enter_button():
	$Code.hide()
	$textures/door_textures/door_closed.hide()
	$textures/door_textures/door_opened.show()
	$door_body/door_collider.disabled = true
	#$Camera.limit_left = 1505
	#$Camera.limit_top = 430
	#$Camera.limit_right = 2415
	#$Camera.limit_bottom = 1375
	$Camera.followNode = $CharacterBody2D
	isCodeLocked = false
	

func anecdotes_going():
	get_tree().change_scene_to_file("res://src/game_menu/anecdotes.tscn") 
	pass

func _on_exit_to_parking_body_entered(body):
	#get_tree().change_scene_to_file("res://src/locations/parking_lot_peacefull/ParkingLotPeacefull.tscn") 
	isNextSceneCollide = true
	pass # Replace with function body.


func _on_exit_to_parking_body_exited(body):
	isNextSceneCollide = false
	pass # Replace with function body.


func _on_door_dialog_body_entered(body):
	isDoorDialog = true
	pass # Replace with function body.


func _on_door_dialog_body_exited(body):
	isDoorDialog = false
	pass # Replace with function body.

func START_DIALOG_WITH_MUDAK_FOR_MATVEY():
	is_E = false
	var dialog = load("res://src/locations/resto/resto.dialogue")
	DialogueManager.show_example_dialogue_balloon(dialog, "mudak")

# ВНИМАНИЕ!
# ХУЙ ПИЗДА
# ТУТ НАДО ПЕРЕХОД НА СЛЕД СЦЕНУ ПОСЛЕ ДИАЛОГА
# ДРАКА ДРАКА ДРАКА!!!!!
func next_location():
	get_tree().change_scene_to_file("res://src/locations/parking_lot/parking_lot.tscn") 
	pass

func _on_enemy_dialog_body_entered(body):
	isEnemyDialog = true
	pass # Replace with function body.


func _on_enemy_dialog_body_exited(body):
	isEnemyDialog = false
	pass # Replace with function body.

func close_toilet():
	$textures/door_textures/door_closed.show()
	$textures/door_textures/door_opened.hide()
	$door_body/door_collider.disabled = false
	$toilet_area/toilet_collider.disabled = false


func _on_sink_area_body_entered(body):
	var dialog = load("res://src/locations/resto/resto.dialogue")
	DialogueManager.show_example_dialogue_balloon(dialog, "sink")
	pass # Replace with function body.

func sest_srat():
	$Camera.followNode = $funnymanfollow
	pass


func _on_sink_area_body_exited(body):
	pass # Replace with function body.


func _on_toilet_area_body_entered(body):
	var dialog = load("res://src/locations/resto/resto.dialogue")
	DialogueManager.show_example_dialogue_balloon(dialog, "toilet")
	pass # Replace with function body.
