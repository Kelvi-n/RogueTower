class_name HitboxComponent
extends Component

@onready var area_2d = $Area2D

@export_category("Collision")
@export_flags_2d_physics var layer
@export_flags_2d_physics var mask

signal just_hit(hit)

# Called when the node enters the scene tree for the first time.
func _ready():
	if get_children().size()>1:
		for child in get_children():
			if child is CollisionShape2D:
				var new_area = Area2D.new()
				new_area.collision_layer = layer
				new_area.collision_mask = mask
				add_child(new_area)
				child.reparent(new_area)
	else:
		push_error('hitbox is missing a collision shape')

	area_2d.collision_layer = layer
	area_2d.collision_mask = mask

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func hit(attack) -> void:
	just_hit.emit(attack)
