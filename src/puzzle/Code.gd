extends Node2D

signal enter_button

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_1_pressed():
	$Sprite2D/CodeInput.text += "1"

func _on_button_2_pressed():
	$Sprite2D/CodeInput.text += "2"


func _on_button_3_pressed():
	$Sprite2D/CodeInput.text += "3"


func _on_button_4_pressed():
	$Sprite2D/CodeInput.text += "4"


func _on_button_5_pressed():
	$Sprite2D/CodeInput.text += "5"


func _on_button_6_pressed():
	$Sprite2D/CodeInput.text += "6"


func _on_button_7_pressed():
	$Sprite2D/CodeInput.text += "7"


func _on_button_8_pressed():
	$Sprite2D/CodeInput.text += "8"


func _on_button_9_pressed():
	$Sprite2D/CodeInput.text += "9"


func _on_button_enter_pressed():
	if $Sprite2D/CodeInput.text == "1337":
		$Sprite2D/CodeInput.text = ""
		enter_button.emit()
	else:
		$Sprite2D/CodeInput.text = ""


func _on_code_input_text_set():
	if len($Sprite2D/CodeInput.text) > 4:
		$Sprite2D/CodeInput.text = ""
