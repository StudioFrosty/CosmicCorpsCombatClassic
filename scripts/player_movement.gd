extends CharacterBody3D

# Constants
const SPEED = 5.0
const JUMP_VELOCITY = 4.5
const HORIZONTAL_JUMP_VELOCITY = 3

# Player index variable
@export var player_index : int = 0  # Can be 0 for player 1 or 1 for player 2

# Physics process function
func _physics_process(delta: float) -> void:
	# Add gravity if not on the floor
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Get the input direction based on the player index
	var left_input = "Left_" + str(player_index)
	var right_input = "Right_" + str(player_index)
	var up_input = "Up_" + str(player_index)
	var down_input = "Down_" + str(player_index)
	
	var input_dir := Input.get_vector(left_input, right_input, up_input, down_input)
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()

	# Apply movement
	if direction and is_on_floor():
		velocity.x = direction.x * SPEED
	if !direction and is_on_floor():
		velocity.x = move_toward(velocity.x, 0, SPEED)

	# Handle jump input
	var jump_input = "Jump_" + str(player_index)
	if Input.is_action_just_pressed(jump_input) and is_on_floor():
		velocity.y = JUMP_VELOCITY
		velocity.x = direction.x * HORIZONTAL_JUMP_VELOCITY

	# Apply movement
	move_and_slide()
