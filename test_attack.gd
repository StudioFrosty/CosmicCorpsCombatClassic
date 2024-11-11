extends Node3D

@export var hitbox_scene : PackedScene
@export var start_up_duration : float = 0.5
@export var hitbox_duration : float = 0.5  
@export var endlag_duration : float = 0.5
@export var hit_stun_duration : float = 0.5
@export var hit_stop_duration : float = 0.5
@export var block_stun_duration : float = 0.5
@export var damage : float = 1.0
@export var hitbox_offset : Vector3 = Vector3(1, 0, 0)
@export var hitbox_rotation : Vector3 = Vector3(0, 90, 0)

signal is_attacking(is_attacking)

@onready var attack_timer : Timer = $AttackTimer
var hitbox : Area3D = null

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
	
func _process(delta):
	if Input.is_action_just_pressed("p1 test attack") and current_phase == AttackPhase.AVAILABLE:
		emit_signal("is_attacking", true)
		set_up_hitbox()

func set_up_hitbox():
	hitbox = hitbox_scene.instantiate()

	hitbox.transform.origin = hitbox_offset
	hitbox.rotation_degrees = hitbox_rotation
	
	current_phase = AttackPhase.STARTUP
	attack_timer.start(start_up_duration)

func _on_attack_timeout():
	match current_phase:
		AttackPhase.STARTUP:
			current_phase = AttackPhase.ACTIVE
			get_parent().add_child(hitbox)
			attack_timer.start(hitbox_duration)
		
		AttackPhase.ACTIVE:
			current_phase = AttackPhase.ENDLAG
			attack_timer.start(endlag_duration)

		AttackPhase.ENDLAG:
			if hitbox:
				hitbox.queue_free()
				hitbox = null
			emit_signal("is_attacking", false)
			current_phase = AttackPhase.AVAILABLE
			
