extends StaticBody2D

@export var life_time: float = 3
var direction:Vector2 = Vector2.UP
var speed:float = 7

func _ready():
	await get_tree().create_timer(life_time).timeout
	queue_free()


func _process(delta):
	position += direction*speed
	scale *= 0.99


func _on_area_2d_area_entered(area):
	if area.get_parent() is HitboxComponent:
		var hitbox:HitboxComponent = area.get_parent()
		hitbox.hit(20)
	#area.get_parent().queue_free()
	queue_free()
