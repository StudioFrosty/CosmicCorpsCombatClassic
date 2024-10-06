extends Node2D



func _on_debug_return_to_title_pressed() -> void:
	get_tree().change_scene_to_file("res://Title Screen.tscn")
