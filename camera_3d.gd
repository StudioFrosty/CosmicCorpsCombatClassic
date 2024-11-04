extends Camera3D 

@export var player1: CharacterBody3D
@export var player2: CharacterBody3D
@export var min_distance: float = 5.0  # Minimum distance from the midpoint
@export var max_distance: float = 20.0  # Maximum distance from the midpoint
@export var zoom_factor: float = 1.0    # Factor to adjust the zoom sensitivity

func _process(delta):
	if player1 and player2:
		var midpoint = (player1.position + player2.position) / 2
		var distance_between_players = player1.position.distance_to(player2.position)
		var camera_distance = clamp(distance_between_players * zoom_factor, min_distance, max_distance)
		position = midpoint + Vector3(0, 0.2, camera_distance)  
		look_at(midpoint, Vector3.UP)
