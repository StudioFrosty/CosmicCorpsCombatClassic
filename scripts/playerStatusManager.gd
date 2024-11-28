extends Node

var P1_health = 100
var P2_health = 100

func take_damage(damage, player):
	if player == "P1":
		P1_health -= damage
	else:
		P2_health -= damage
		
	if P1_health <= 0:
		P1_die()
	if P2_health <= 0:
		P2_die()
		
func P1_die():
	pass
	
func P2_die():
	pass
