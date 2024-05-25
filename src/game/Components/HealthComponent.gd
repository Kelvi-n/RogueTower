extends Component
class_name HealthComponent

@export_category("Health Component")
@export var max_health: int
@export var test_damage:bool = false

@export_category("Display")
@export var rotate_with_parent: bool = false

@onready var health: int = max_health:
	set(new_health):
		#update health value
		health = _update_health(new_health)

@onready var health_bar = %HealthProgressBar

@onready var start_position = position

var dead:bool = false

signal health_changed
signal damaged
signal healed
signal health_zero


# Called when the node enters the scene tree for the first time.
func _ready():
	health_bar.visible = false
	health_bar.max_value = max_health


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if !rotate_with_parent:
		reset_position()
	if !test_damage:
		return
	if Engine.get_process_frames() % 20 != 0:
		return
	damage(1)


func reset_position():
	global_position = get_parent().global_position + start_position
	global_rotation = 0


func _update_health(new_health:int) -> int:
	#clamp between 0 and maximum health value
	new_health = clamp(new_health, 0, max_health)
	#emit appropriate signals
	if new_health > health:
		healed.emit()
		health_changed.emit()
	elif new_health < health:
		damaged.emit(health, new_health)
		health_changed.emit()
	if new_health == 0:
		health_zero.emit()
		dead = true
	#update health bar
	health_bar.value = new_health
	if new_health == max_health:
		health_bar.visible = false
	else:
		health_bar.visible = true
	#return new health value to update health
	return new_health


func damage(damage_amount:int) -> void:
	health -= damage_amount


func heal(heal_amount:int) -> void:
	health += heal_amount

#func is_type(type) -> bool:
	#return type == get_type()
	#
#func get_type() -> String:
	#
	#return "null"
