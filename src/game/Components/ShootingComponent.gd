class_name ShootingComponent
extends Component


var fire_rate:float = 1
@export var projectile:PackedScene
@onready var tower = get_parent()
@onready var timer = $Timer
@onready var projectile_spawn = $ProjectileSpawn/Marker2D
@onready var projectile_spawn_node = $ProjectileSpawn
var can_fire = false

func _ready():#
	await get_tree().create_timer(2).timeout
	can_fire = true
	timer.wait_time = fire_rate


func get_projectile_speed():
	var temp_projectile = projectile.instantiate()
	var projectile_speed =temp_projectile.speed
	temp_projectile.queue_free()
	return projectile_speed


func _process(delta):
	projectile_spawn_node.rotation = tower.tower.rotation


func fire():
	var new_projectile = projectile.instantiate()
	
	new_projectile.position = projectile_spawn.position.rotated(tower.tower.rotation)
	new_projectile.direction = Vector2.UP.rotated(tower.tower.rotation)
	add_child(new_projectile)


func _on_timer_timeout():
	timer.start()
	if can_fire:
		fire()
