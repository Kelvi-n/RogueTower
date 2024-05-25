extends Node2D

@onready var path = $Path2D
@export var enemy_scene:PackedScene 


func _process(delta):
	
	if Input.is_action_just_pressed("ui_accept"):
		add_enemy()
	
	if Engine.get_process_frames() % 20:
		for enemy in path.get_children():
			if not enemy is PathFollow2D:
				return
			if enemy.get_child_count()>0:
				enemy.get_child(0).position.y = clamp(enemy.get_child(0).position.y + randf_range(-0.2, 0.2), -10, 10)
			else:
				enemy.queue_free()
			enemy.progress += 1
			if enemy.get_child_count() > 0:
				enemy.get_child(0).velocity = Vector2.RIGHT.rotated(enemy.rotation)


func add_enemy():
	var new_enemy = enemy_scene.instantiate()
	path.add_child(new_enemy)
	path.reparent_path_follow_2d()
