extends CharacterBody3D

@export var speed = 5.0
@export var jump_velocity = 4.5
@export var horizontal_jump_velocity = 3

var speed_change = 1
var jump_velocity_change = 1
var horizontal_jump_velocity_change = 1

@export var player_index : int = 0

@onready var animation_player: AnimationPlayer = $xbot2/AnimationPlayer
@onready var animation_tree: AnimationTree = $xbot2/AnimationTree

func _ready():
	# Activate the animation tree for blending
	animation_tree.active = true

func _physics_process(delta: float) -> void:
	# Add gravity if not on the floor
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Get the input direction based on the player index
	var left_input = "Left_" + str(player_index)
	var right_input = "Right_" + str(player_index)
	var up_input = "Up_" + str(player_index)
	var down_input = "Down_" + str(player_index)
	
	var speed_change = 1
	var jump_velocity_change = 1
	var horizontal_jump_velocity_change = 1
	
	var input_dir := Input.get_vector(left_input, right_input, up_input, down_input)
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()

	# Apply movement
	if is_on_floor():
		if direction:
			velocity.x = direction.x * speed * speed_change
		else:
			velocity.x = 0

	# Handle jump input
	var jump_input = "Jump_" + str(player_index)
	if Input.is_action_just_pressed(jump_input) and is_on_floor():
		velocity.y = jump_velocity * jump_velocity_change
		velocity.x = direction.x * horizontal_jump_velocity * horizontal_jump_velocity_change

	# Apply movement
	move_and_slide()
