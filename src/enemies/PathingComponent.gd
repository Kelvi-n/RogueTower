class_name PathingComponent
extends Component

@onready var path_follow = $PathFollow2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func get_path_follow():
	return path_follow
