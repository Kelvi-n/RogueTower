@icon("res://src/game/Components/GearSmall.png")
class_name Component
extends Node2D

func get_type() -> String:
	return get_script().resource_path.split("/")[-1].split(".")[0]

func is_type(type) -> bool:
	return get_type() == type
