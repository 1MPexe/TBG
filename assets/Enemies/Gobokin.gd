extends Control

var enemy_name = "Gobokin"
var max_health = 25
var health = 25
var max_attack_power = 10
var attack_margin = 5
var miss_chance = 100

func _ready():
	$EnemyHealthBar.max_value = max_health
	$EnemyHealthBar.value = health
	$EnemyHealthBar/EnemyHealth.text = "HP:%s/%s" % [health, max_health]
	rect_scale = Vector2(448,280)

func run_anim():
	var chance : int
	chance = Utility.random_number(100)
	if chance > 10:
		$AnimationPlayer.play("attack")
	else:
		Core.emit_signal('fled')
		flee()

	







func attack():
	# Percent chace to miss out of 100
	if Utility.random_number(100) < miss_chance:
		$AnimationPlayer.play("trip")
		return Terminal.add_response("The Gobokin tripped and fell...")

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
