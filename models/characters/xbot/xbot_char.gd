extends CharacterBody3D

const SPEED = 5.0
const JUMP_VELOCITY = 4.5
const HORIZONTAL_JUMP_VELOCITY = 3

@onready var animation_player: AnimationPlayer = $xbot2/AnimationPlayer
@onready var animation_tree: AnimationTree = $xbot2/AnimationTree

func _ready():
	# Activate the animation tree for blending
	animation_tree.active = true

func _physics_process(delta: float) -> void:
	# Add the gravity
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Get input direction and handle movement
	var input_dir := Input.get_vector("Left", "Right", "Up", "Down")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction and is_on_floor():
		velocity.x = direction.x * SPEED
		# Control animation blend amount based on movement speed
		animation_tree.set("parameters/Idw/BlendAmount", 1.0)  # E.g., for idle state
		animation_tree.set("parameters/Walk F Speed/Scale", abs(velocity.x / SPEED))
	elif !direction and is_on_floor():
		velocity.x = move_toward(velocity.x, 0, SPEED)
		animation_tree.set("parameters/Idw/BlendAmount", -1.0)  # E.g., for idle
	else:
		animation_tree.set("parameters/Idw/BlendAmount", 0.0)  # E.g., for in-air

	# Handle jump
	if Input.is_action_just_pressed("Jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		velocity.x = direction.x * HORIZONTAL_JUMP_VELOCITY

	move_and_slide()
