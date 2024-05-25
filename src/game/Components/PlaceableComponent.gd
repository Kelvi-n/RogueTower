class_name PlaceableComponent
extends Component


@onready var area_2d = $PlacementArea
@export var sprite: Sprite2D

var able_to_build: bool = true
var can_destroy: bool = false

@export_category("Collision")
@export_flags_2d_physics var layer
@export_flags_2d_physics var mask

var areas:int = 0
var active_buildable_object: bool = false:
	set(value):
		active_buildable_object = value
		#check if parent node has a light component that is turned off if being built
		if !active_buildable_object:
			placed.emit()

signal destroyed
signal placed

# Called when the node enters the scene tree for the first time.
func _ready():
	if get_children().size()>1:
		get_child(1).reparent(area_2d)
	else:
		push_error('hitbox is missing a collision shape')
	area_2d.collision_layer = layer
	area_2d.collision_mask = mask


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if active_buildable_object:
		if able_to_build:
			sprite.self_modulate = Color.WHITE
		else:
			sprite.self_modulate = Color.RED
		sprite.self_modulate.a = 0.5




func placement() -> void:
	sprite.self_modulate.a = 1


func _on_placement_area_area_entered(_area):
	if !active_buildable_object:
		return
	areas += 1
	able_to_build = false


func _on_placement_area_area_exited(_area):
	if !active_buildable_object:
		return
	areas -= 1
	if areas <= 0:
		able_to_build = true


func _on_placement_area_input_event(_viewport, event, _shape_idx):

	if (event.is_pressed() and event.button_index == MOUSE_BUTTON_RIGHT) and !active_buildable_object and can_destroy:
		destroyed.emit()
