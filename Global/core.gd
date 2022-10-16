extends Node

var enemy_count : int
var active_enemies = {
	"gobokin": [],
	"gangman": [],
}

func check_enemy_count() -> int:
  # Make an empty array
	var all_enemies = []
	
  # Combine the arrays
	for array in active_enemies.values():
		all_enemies.append_array(array)
	
	print(all_enemies)
	return all_enemies.size()
