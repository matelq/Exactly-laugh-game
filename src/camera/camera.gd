extends Camera2D

@export var followNode: Node2D
#@export var limits = [0,0,500,500]

# Called when the node enters the scene tree for the first time.
func _ready():
	#limit_left = limits[0]
	#limit_top = limits[1]
	#limit_right = limits[2]
	#limit_bottom = limits[3]
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	transform = followNode.transform
	pass
