extends Node2D


@export var min_size: float = 6
@export var max_size: float = 11
@export var tv_room_teleport: Node2D
@export var kitchen_teleport: Node2D
@export var min_y = 420
@export var max_y = 720

var room_state: int = 0
var player_can_exit_kitchen = false

@export var tv_room_color = Color(0.047, 0.02, 0.106)
@export var kitchen_color = Color(0.208, 0.247, 0.275)

# Called when the node enters the scene tree for the first time.
func _ready():
		# Access the root node of your scene, which is usually the main viewport
	RenderingServer.set_default_clear_color(tv_room_color)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if player_can_exit_kitchen and Input.is_action_just_pressed("ui_accept"):
		# next location progress
		print("YOU SHOULD TELEPORT!")
	$Player.scale.x = min_size + ($Player.position.y - min_y)/(max_y - min_y)*(max_size - min_size)
	$Player.scale.y = min_size + ($Player.position.y - min_y)/(max_y - min_y)*(max_size - min_size)
	pass


func _on_tv_room_exit_body_entered(body):
	$Player.max_speed = 600
	$Player.acceleration = 2600
	$Player.friction = 1000
	$Player.position = kitchen_teleport.position
	#$Camera.limit_left = 1512
	#$Camera.limit_right = 1512 + 1024

	RenderingServer.set_default_clear_color(kitchen_color)
	$Player.velocity = Vector2.ZERO
	$Player.isLeftRight = true


func _on_kitchen_to_tv_room_body_entered(body):
	RenderingServer.set_default_clear_color(tv_room_color)
	$Player.max_speed = 200
	$Player.acceleration = 1600
	$Player.friction = 600
	$Player.position = tv_room_teleport.position
	#$Camera.limit_left = 0
	#$Camera.limit_right = 1024
	$Player.velocity = Vector2.ZERO
	$Player.isLeftRight = false


func _on_kitchen_exit_body_entered(body):
	player_can_exit_kitchen = true
	pass # Replace with function body.


func _on_kitchen_exit_body_exited(body):
	player_can_exit_kitchen = false
	pass # Replace with function body.


func _on_audio_stream_player_finished():
	$AudioStreamPlayer.play()
