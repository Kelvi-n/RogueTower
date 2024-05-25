extends Node2D

signal just_hit(hit)


func _on_hitbox_component_just_hit(hit):
	just_hit.emit(hit)
