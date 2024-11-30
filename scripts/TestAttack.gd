extends Node3D

@export_category("Animation frame data")
@export var start_up_duration : float 
@export var hitbox_duration : float   
@export var endlag_duration : float
@export_category("Attack location")
@export_category("Player info")
@export var player_index : int = 0

signal is_attacking(is_attacking)

@onready var attack_timer : Timer = $AttackTimer
@export var hitbox: Area3D	

enum AttackPhase {
	AVAILABLE,
	STARTUP,
	ACTIVE,
	ENDLAG
}
var current_phase : AttackPhase = AttackPhase.AVAILABLE

func _ready():
	attack_timer.timeout.connect(_on_attack_timeout)
	attack_timer.autostart = false
	hitbox.monitoring = false
	
func _process(delta):
	if Input.is_action_just_pressed("Light attack_" + str(player_index)) and current_phase == AttackPhase.AVAILABLE:
		emit_signal("is_attacking", true)
		set_up_hitbox()

func set_up_hitbox():
	
	current_phase = AttackPhase.STARTUP
	attack_timer.start(start_up_duration)

func _on_attack_timeout():
	match current_phase:
		AttackPhase.STARTUP:
			current_phase = AttackPhase.ACTIVE
			hitbox.monitoring = true
			hitbox.visible = true
			attack_timer.start(hitbox_duration)
		
		AttackPhase.ACTIVE:
			current_phase = AttackPhase.ENDLAG
			if hitbox:
				hitbox.monitoring = false
				hitbox.visible = false
			attack_timer.start(endlag_duration)

		AttackPhase.ENDLAG:
			emit_signal("is_attacking", false)
			current_phase = AttackPhase.AVAILABLE
