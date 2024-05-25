extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_resume_button_button_down():
	get_tree().paused = false
	queue_free()


func _on_menu_button_button_down():
	get_tree().paused = false
	MenuScenes.change_scene(MenuScenes.MAIN_MENU, self, MenuScenes.CURRENT_SCENE_HANDLING.DELETE)
