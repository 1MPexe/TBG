extends Node

signal next_turn()



# Prevents the command line from processing empty commands.
func process_command(input: String):

	# lets the terminal know what the user has just input
	Terminal.last_user_input = input 

	var words = input.split(" ", false)
	if words.size() == 0:
		return "Error: no words were parsed."
		
	var first_word = words[0].to_lower()
	

#  List of all available commands.
	match first_word:
		"go": 
			emit_signal("next_turn") 
			return go(words[1])
		"help":
			emit_signal("next_turn") 
			return help()
		"attack":
			emit_signal("next_turn") 
			return attack(words)
		"i'm":
			emit_signal("next_turn") 
			return im(words[1])
		_:
			return "Unrecognized command."
			


func im(person: String):
	if person == "1mp":
		return Terminal.add_input_response("Hello creator!")
	elif person == "": 
		return Terminal.add_input_response("You're who?")

	return Terminal.add_input_response("Hello, %s!" % person)


func go(place: String):
	if place == "":
		return Terminal.add_input_response("Go where?")

	return Terminal.add_input_response("You go %s." % place)


func help():
	return Terminal.add_input_response("You can use these commands: 'go [location]' , 'help' , 'attack [thing]'")


enum {COMMAND,ENEMY,INDEX}

# Attack a specified enemy
func attack(words : Array):
	
	# Ignore this function if a battle is not happening
	if State.game_state != State.BATTLE: return Terminal.add_input_response("You're not in a battle")
	# If no enemy is specified
	if words.size() == 1: return Terminal.add_input_response("Attack what?")
	
	# check if the enemy type exists
	if !Core.active_enemies.has(words[ENEMY]): return Terminal.add_input_response("%s isn't an enemy" % [words[ENEMY]])
	if Core.active_enemies[words[ENEMY]].empty(): return Terminal.add_input_response("There is no %s in this battle" % [words[ENEMY]])

	# Check if command prarmeters exist
	
	if words.size() == 2: return Terminal.add_input_response("Which %s" % words[ENEMY])
	if words.size() > 3: return Terminal.add_input_response("Too many Parameters")

	# This is the number the player typed in -1
	var index = int(words[INDEX]) - 1
	
	#var wr = weakref()   
	
	# Check if the INDEX is a valid number.
	if index < -1: return Terminal.add_input_response("Enemy not specified (Type a number)")
	
	# If the enemy the player wants to attack is not in the array of enemies
	if index > Core.active_enemies.size(): return Terminal.add_input_response("There is no %s %s" % [words[ENEMY], words[INDEX]])
	
	
	#if index 
	
	
	
	# Player damages enemy health
	var my_number : int
	var player_attack = Ply.power
	
	#rolls a random number between the players max power
	my_number = Utility.random_number(player_attack)
	
	if my_number == 0:
		Terminal.add_response("You attack the %s but stumble and miss!" % [words[ENEMY]])
	else:
		Core.active_enemies[words[ENEMY]][index].damage(my_number)
		Terminal.add_response("The %s was struck for %s damage!" % [words[ENEMY], my_number])
	
	
	
	
	# Enemy damages player health
	
	
	#removes enemy from the scene when defeated
	if Core.active_enemies[words[ENEMY]][index].get("health") <= 0:
		Terminal.add_response("The enemy %s was slain!" % [words[ENEMY]])
		Core.active_enemies[words[ENEMY]][index].die()
		Core.active_enemies[words[ENEMY]].remove(index)
	
	#If there are no more enemies run the win function
	if Core.check_enemy_count() == 0:
		Win()
		
	return ""



	
	
	
func Win():
	if State.game_state == State.IDLE: return
	else:
		State.set_game_state(State.WIN)
		Terminal.add_response("You Won!")
		
		print(State.game_state)

