extends Control

var enemy_name = "Gobokin"
var max_health = 25
var health = 25
var hit = 5





func flee():
	Terminal.add_response("The Gobokin fled from battle!")
	self.queue_free()


func _ready():
	$EnemyHealthBar.max_value = max_health
	$EnemyHealthBar.value = health
	$EnemyHealthBar/EnemyHealth.text = "HP:%s/%s" % [health, max_health]

# Reading the "next_turn" signal
	if get_parent().connect('next_turn', self, '_on_next_turn') == OK: pass





# Function to run
func _on_next_turn(index: int):
	 pass




func attack():
	
	var my_number = Utility.random_number(hit)
	Ply.health -= my_number
	Terminal.add_response("The Gobokin swings it's sword for %s damage!" % my_number)


func damage(dmg:int):
	health -= dmg
	$EnemyHealthBar.value -= dmg
	$EnemyHealthBar/EnemyHealth.text = "HP:%s/%s" % [health, max_health]
	

func die():
		self.queue_free()
