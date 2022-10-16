extends Control

var enemy_name = "Gobokin"
var max_health = 50
var health = 50
var hit = 5

func _ready():
	$EnemyHealthBar.value = health
	$EnemyHealthBar/EnemyHealth.text = "HP:%s/%s" % [health, max_health]


func attack():
	Ply.health -= hit
	Terminal.add_response("The Gobokin swings it's sword for %s damage!" % hit)





func damage(dmg:int):
	health -= dmg
	$EnemyHealthBar.value -= dmg
	$EnemyHealthBar/EnemyHealth.text = "HP:%s/%s" % [health, max_health]
	

func die():
		self.queue_free()
