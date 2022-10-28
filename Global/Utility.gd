extends Node


# Rolls The Dice... Outputs true based on a percent chance you specify
func percent_chance(percent_chance : int) -> bool:
	randomize()
	return (randi() % 100 < percent_chance)

func random_number(max_num : int):
	randomize()
	return randi() % max_num
   
