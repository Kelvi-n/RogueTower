class_name UnitComponent
extends Component

@export var enemy_type:PackedScene
@export var health_component:HealthComponent
@onready var spawn_points = $SpawnPoints
@onready var enemies = $Enemies

signal just_hit(hit)

# Called when the node enters the scene tree for the first time.
func _ready():
	for child in get_children():
		if child is Marker2D:
			child.reparent(spawn_points)
			var new_enemy = enemy_type.instantiate()
			enemies.add_child(new_enemy)
			new_enemy.just_hit.connect(_on_enemy_just_hit)
			new_enemy.position = child.position
			


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func get_unit_size():
	return spawn_points.get_child_count()


func get_remaining_enemies_count():
	return enemies.get_children_count()


func remove_enemy():
	enemies.get_children()[-1].queue_free()


func _on_enemy_just_hit(hit):
	just_hit.emit(hit)
