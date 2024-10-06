extends CanvasLayer

@onready var versus_button = $Control/MarginContainer/VBoxContainer/Versus
@onready var settings_button = $Control/MarginContainer/VBoxContainer/Settings
@onready var training_button = $Control/MarginContainer/VBoxContainer/Training
@onready var credits_button = $Control/MarginContainer/VBoxContainer/Credits
@onready var quit_button = $Control/MarginContainer/VBoxContainer/Quit



func _on_versus_pressed() -> void:
	get_tree().change_scene_to_file("res://Character Select Screen.tscn")


func _on_settings_pressed() -> void:
	print("Settings Button Pressed")
	#Enter credit code here


func _on_training_pressed() -> void:
	get_tree().change_scene_to_file("res://Character Select Screen.tscn")


func _on_credits_pressed() -> void:
	print("Credits Button Pressed")
	#Enter credit code here


func _on_quit_pressed() -> void:
	get_tree().quit()
