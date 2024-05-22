extends StaticBody2D
@onready var tower = $Tower

func _process(delta):
	tower.look_at(get_global_mouse_position())
	tower.rotate(PI/2)
