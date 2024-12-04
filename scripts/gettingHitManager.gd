extends Node

var P1_is_actionable = true
var P2_is_actionable = true


func hit_stop(duration):
	Engine.time_scale = 0
	print("stopped!")
	await get_tree().create_timer(duration, true, false, true).timeout
	Engine.time_scale = 1
	
	
func hit_stun(hit_stun_duration, player):
	if player == "P1":
		P1_is_actionable = false
	else:
		P2_is_actionable = false
	await get_tree().create_timer(hit_stun_duration).timeout
	if player == "P1":
		P1_is_actionable = true
	else:
		P2_is_actionable = true
	
	
func block_stun(block_stun_duration, player):
	if player == "player1":
		P1_is_actionable = false
	else:
		P2_is_actionable = false
	await get_tree().create_timer(block_stun_duration).timeout
	if player == "player1":
		P1_is_actionable = true
	else:
		P2_is_actionable = true
	
	
func knock_back():
	pass
