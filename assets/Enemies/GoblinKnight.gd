extends Control

var enemy_name = "GoblinKnight"

var health = 50
var damage = 5

# Called when the node enters the scene tree for the first time.

func attack(dmg:int):
 $ProgressBar.value -= dmg



func die():
	self.queue_free()
