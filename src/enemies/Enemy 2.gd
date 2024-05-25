extends Node2D

@onready var hitbox_component = $HitboxComponent


func set_health_component(new_health_component:HealthComponent):
	hitbox_component.health_component = new_health_component
