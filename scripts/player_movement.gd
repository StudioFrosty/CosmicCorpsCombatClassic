extends CharacterBody3D

@export var speed = 5.0
@export var jump_velocity = 4.5
@export var horizontal_jump_velocity = 3
@export var opponent: CharacterBody3D
@export var starts_on_right_side = true

var speed_change = 1
var jump_velocity_change = 1
var horizontal_jump_velocity_change = 1

var was_in_air

#  index variable
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
	if is_on_floor():
		if direction:
			velocity.x = direction.x * speed * speed_change
		else:
			velocity.x = 0
		switch_sides()

	# Handle jump input
	var jump_input = "Jump_" + str(player_index)
	if Input.is_action_just_pressed(jump_input) and is_on_floor():
		velocity.y = jump_velocity * jump_velocity_change
		velocity.x = direction.x * horizontal_jump_velocity * horizontal_jump_velocity_change
		was_in_air = true

	# Apply movement
	move_and_slide()

func switch_sides():
	if 	opponent.position.x > position.x and starts_on_right_side and was_in_air:
		starts_on_right_side = false
		rotate_y(180 * deg_to_rad(1))
		speed *= -1
		horizontal_jump_velocity *= -1
		was_in_air = false
		
	if 	opponent.position.x < position.x and !starts_on_right_side and was_in_air:
		starts_on_right_side = true
		rotate_y(180 * deg_to_rad(1))
		speed *= -1
		horizontal_jump_velocity *= -1
		was_in_air = false

func _on_node_3d_is_attacking(is_attacking: Variant) -> void:
	if is_attacking == true:
		speed_change = 0
		jump_velocity_change = 0
		horizontal_jump_velocity_change = 0
	else:
		speed_change = 1
		jump_velocity_change = 1
		horizontal_jump_velocity_change = 1
	
