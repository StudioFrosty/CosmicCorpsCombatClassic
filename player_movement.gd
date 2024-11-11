extends CharacterBody3D


const SPEED = 5.0
const JUMP_VELOCITY = 4.5
const HORIZONTAL_JUMP_VELOCITY = 3

var value_change = 1


func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta

	var input_dir := Input.get_vector("p1left", "p1right", "ui_up", "ui_down")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	if direction and is_on_floor(): # change mv
		velocity.x = direction.x * SPEED * value_change
	if !direction and is_on_floor(): #mv
		velocity.x = move_toward(velocity.x, 0, SPEED * value_change)
		
	if Input.is_action_just_pressed("p1jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY * value_change
		velocity.x = direction.x * HORIZONTAL_JUMP_VELOCITY * value_change

	move_and_slide()


func _on_test_attack_is_attacking(is_attacking: Variant) -> void:
	if is_attacking == true:
		value_change = 0
	else:
		value_change = 1
