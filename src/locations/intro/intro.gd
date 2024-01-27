extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	var resource = load("res://src/locations/intro/intro.dialogue")
	DialogueManager.show_example_dialogue_balloon(resource)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func flip_noise():
	$Control/Noise.rotation += PI
	$Control/Noise.show()

func show_frame1():
	$Control/Noise.hide()
	
func show_frame2():
	$Control/Frame1.hide()
	
func show_frame3():
	$Control/Frame2.hide()
	
func show_frame4():
	$Control/Frame3.hide()
	
func show_frame5():
	$Control/Frame4.hide()

func end_dialogue():
	get_tree().change_scene_to_file("res://src/locations/apartment/apartment.tscn")

func play_tv_ost():
	$SoundrackTV.play()

func _on_soundrack_tv_finished():
	play_tv_ost()
