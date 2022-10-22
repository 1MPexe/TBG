extends Control

var enemy_name = "Gobokin"
var max_health = 25
var health = 25
var hit = 5

 





func _ready():
	$EnemyHealthBar.max_value = max_health
	$EnemyHealthBar.value = health
	$EnemyHealthBar/EnemyHealth.text = "HP:%s/%s" % [health, max_health]

# Reading the "next_turn" signal
	if Actions.connect('new_turn', self, 'on_next_turn') == OK:
		pass




# Function to run
func on_next_turn():
	var chance : int
	print("bop")
	check_health()
	chance = Utility.random_number(100)
	if chance > 10:
		attack()
	else:
		flee()



func check_health():
	if health <= 0:
		die()
	else:
		pass


func attack():
	
	var my_number = Utility.random_number(hit)
	Ply.health -= my_number
	print(Ply.health)
	if my_number == 0:
		Terminal.add_response("The Gobokin tripped and fell...")
	else: 
		Terminal.add_response("The Gobokin swings it's sword for %s damage!" % my_number)

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
