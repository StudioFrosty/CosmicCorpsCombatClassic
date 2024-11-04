extends CharacterBody3D


const SPEED = 5.0
const JUMP_VELOCITY = 4.5
const HORIZONTAL_JUMP_VELOCITY = 3


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("p2left", "p2right", "ui_up", "ui_down")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction and is_on_floor():
		velocity.x = direction.x * SPEED
		#velocity.z = direction.z * SPEED
	if !direction and is_on_floor():
		velocity.x = move_toward(velocity.x, 0, SPEED)
		#velocity.z = move_toward(velocity.z, 0, SPEED)
		
		# Handle jump.
	if Input.is_action_just_pressed("p2jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		velocity.x = direction.x * HORIZONTAL_JUMP_VELOCITY

	move_and_slide()
