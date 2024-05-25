extends Path2D

# Called when the node enters the scene tree for the first time.
func _ready():
	reparent_path_follow_2d()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func reparent_path_follow_2d():
	for child in get_children():
		for child_child in child.get_children():
			if child_child is PathingComponent:
				#print("reparend")
				var path_follow:PathFollow2D = child_child.get_path_follow()
				path_follow.reparent($".")
				child.reparent(path_follow)
				path_follow.progress = 1
