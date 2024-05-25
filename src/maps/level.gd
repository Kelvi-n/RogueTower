extends Node2D
@onready var map = $Map
@onready var towers = $Towers


func _ready():
	for i in range(100):
		await get_tree().create_timer(0.5).timeout
		map.add_enemy()



func _process(delta):
	$CanvasLayer/Label.text = str(1/delta)
	if  map.path.get_child_count() > 0:
		for tower in towers.get_children():
			if map.path.get_child(0) and map.path.get_child(0).get_child_count() > 0:
				tower.target = map.path.get_child(0).get_child(0)
	if Input.is_action_just_pressed("ui_cancel"):
		MenuScenes.change_scene(MenuScenes.PAUSE, self, MenuScenes.CURRENT_SCENE_HANDLING.PAUSE)
		#queue_free()
