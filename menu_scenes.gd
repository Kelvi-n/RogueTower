extends Node

const MAIN_MENU = preload("res://src/game/UI/main_menu.tscn")
const PAUSE = preload("res://src/game/UI/Pause.tscn")

enum CURRENT_SCENE_HANDLING {NOTHING, DELETE, PAUSE}
var previous_scene

func change_scene(new_scene, current_scene, handling):
	get_tree().root.add_child(new_scene.instantiate())
	match handling:
		CURRENT_SCENE_HANDLING.NOTHING:
			previous_scene = current_scene
		CURRENT_SCENE_HANDLING.DELETE:
			current_scene.queue_free()
			if previous_scene:
				previous_scene.queue_free()
				previous_scene = null
		CURRENT_SCENE_HANDLING.PAUSE:
			previous_scene = current_scene
			get_tree().paused = true
