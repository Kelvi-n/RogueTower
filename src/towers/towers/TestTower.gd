extends StaticBody2D
@onready var tower = $Tower
@onready var shooting_component:ShootingComponent = $ShootingComponent
var target

func _process(delta):
	#print(target.global_position)
	if target:
		var aim_vector = find_aim_vector(delta)
		if aim_vector:
			tower.look_at(aim_vector*get_time(delta)+position)
			tower.rotate(PI/2)


func set_target(new_target):
	target = new_target


func find_aim_vector(delta):
	if !target or !is_instance_valid(target):
		target = null #maybe
		return
	var target_velocity = target.velocity
	var bullet_speed = shooting_component.get_projectile_speed()
	var target_position = global_position - target.global_position
	
	var a = target_velocity.dot(target_velocity) - pow(bullet_speed, 2)
	var b = 2*(target_position.dot(target_velocity))
	var c = target_position.dot(target_position)
	
	var solutions
	
	#print(quadratic_formula_number_of_solutions(a, b, c))
	if quadratic_formula_number_of_solutions(a, b, c) > 0:
		solutions = quadratic_formula(a, b, c)
	else:
		print("NO SOLUTION")
		return
	#print(solutions)
	var solution = solutions[0]
	
	var aim_vector:Vector2 = (target_position + target_velocity*solution)/(bullet_speed*solution)
	return aim_vector#.normalized()

func quadratic_formula(a, b, c):
	if a == 0:
		return
	var solution_one = (-b + sqrt((b*b)-4*a*c))/(2*a)
	var solution_two = (-b - sqrt((b*b)-4*a*c))/(2*a)
	
	var solutions = []
	solutions.append(solution_one)
	solutions.append(solution_two)
	#print(solutions)
	return([solution_one, solution_two])


func quadratic_formula_number_of_solutions(a, b, c):
	#print((b*b)-4*a*c)
	if (b*b)-4*a*c > 0:
		return 2
	if (b*b)-4*a*c == 0:
		return 1
	if (b*b)-4*a*c < 0:
		return 0


func get_time(delta):
	if !target or !is_instance_valid(target):
		target = null #maybe
		return
	var target_velocity = target.velocity
	var bullet_speed = shooting_component.get_projectile_speed()
	var target_position = target.global_position
	
	var a = target_velocity.dot(target_velocity) - pow(bullet_speed, 2)
	var b = 2*(target_position.dot(target_velocity))
	var c = target_position.dot(target_position)
	
	var solutions
	
	#print(quadratic_formula_number_of_solutions(a, b, c))
	if quadratic_formula_number_of_solutions(a, b, c) > 0:
		solutions = quadratic_formula(a, b, c)
	else:
		return 0
	if !solutions:
		return 0
	return solutions[1]

