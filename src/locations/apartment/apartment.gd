extends Node2D


@export var min_size: float = 6
@export var max_size: float = 11

@export var min_y = 420
@export var max_y = 720

var room_state: int = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$Player.scale.x = min_size + ($Player.position.y - min_y)/(max_y - min_y)*(max_size - min_size)
	$Player.scale.y = min_size + ($Player.position.y - min_y)/(max_y - min_y)*(max_size - min_size)
	pass
