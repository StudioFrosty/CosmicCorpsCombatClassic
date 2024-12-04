extends Area3D

signal attack_connected(block_stun_duration, knockback)

@export_category("Hit stun frame data")
@export var hit_stop_duration : float = 0.5
@export var hit_stun_duration : float = 0.5
@export var block_stun_duration : float = 0.5
@export_category("Other effects")
@export var damage : float = 1.0
@export var knockback = 1.0

func _ready():
	self.body_entered.connect(_on_body_entered)

func _on_body_entered(body):
	if body is CharacterBody3D:
		print("body entered")
		PlayerStatusManager.take_damage(damage, "P2")
		GettingHitManager.hit_stop(hit_stop_duration)
		GettingHitManager.hit_stun(hit_stun_duration, "P2")
