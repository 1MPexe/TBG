extends Node2D

var enemy_name = "Gobokin"
var max_health = 25
var health = 25
var max_attack_power = 10
var attack_margin = 5
var trip_chance = 10

func _ready():
	$EnemyHealthBar.max_value = max_health
	$EnemyHealthBar.value = health
	$EnemyHealthBar/EnemyHealth.text = "HP:%s/%s" % [health, max_health]

func run_anim():

	# Miss chance
	if Utility.percent_chance(trip_chance):
		$AnimationPlayer.play("trip")
		return Terminal.add_response("The Gobokin tripped and fell...")

	# Attack Chance
	if Utility.percent_chance(90):
		return $AnimationPlayer.play("attack")

	# Flee if all else fails
	Core.emit_signal('fled')
	flee()



func attack():
	# set attack power with a margin of error
	var attack_power = max_attack_power - Utility.random_number(attack_margin)
	Ply.health -= attack_power

	if attack_power <= 0:
		Terminal.add_response("The Gobokin hit you, but you're unphased")
	else: 
		Terminal.add_response("The Gobokin swings it's sword for %s damage!" % attack_power)

func damage(dmg:int):
	health -= dmg
	$EnemyHealthBar.value -= dmg
	$EnemyHealthBar/EnemyHealth.text = "HP:%s/%s" % [health, max_health]
	
	
	

func flee():
	Terminal.add_response("The Gobokin fled from battle!")
	Core.active_enemies["gobokin"].erase(self)
	self.queue_free()



func die():
	self.queue_free()
