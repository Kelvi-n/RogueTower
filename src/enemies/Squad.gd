extends StaticBody2D

#@onready var troops = $Troops
#@onready var units:int = troops.get_child_count()
@onready var health_component:HealthComponent = $HealthComponent
@onready var unit_component:UnitComponent = $UnitComponent

var velocity:Vector2


func _on_health_component_damaged(old_health, new_health):
	var health_chunk:float = health_component.max_health / unit_component.get_unit_size()
	if ceil(new_health / health_chunk) - ceil(old_health/health_chunk) < 0:
		unit_component.remove_enemy()


func _on_health_component_health_zero():
	queue_free()


func _on_unit_component_just_hit(hit):
	if health_component:
		health_component.damage(hit)
