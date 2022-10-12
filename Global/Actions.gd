extends Node

signal next_turn()

# Prevents the command line from processing empty commands.
func process_command(input: String) -> String:
	var words = input.split(" ", false)
	if words.size() == 0:
		return "Error: no words were parsed."
		
	var first_word = words[0].to_lower()
	
	var second_word
	if words.size() > 1:
		second_word = words[1].to_lower()
	
	var third_word 
	if words.size() > 2:
		third_word = words[2].to_lower()


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
			


func im(second_word: String) -> String:
	if second_word == "1mp":
		return "Hello creator!"
	elif second_word == "": 
		return "You're who?"

	return "Hello, %s!" % second_word


func go(second_word: String) -> String:
	if second_word == "":
		return "Go where?"

	return "You go %s." % second_word


func help() -> String:
	return "You can use these commands: 'go [location]' , 'help' , 'attack [thing]'"


enum {COMMAND,ENEMY,INDEX}

# Attack a specified enemy
func attack(words : Array) -> String:

	# Check if command prarmeters exist
	if words.size() == 1: return "Attack what?"
	if words.size() == 2: return "Enemy not specified"
	if words.size() > 3: return "Too many Parameters"

	# This is the number the player typed in -1
	var index = int(words[INDEX]) - 1

	# Check if the INDEX is a valid number.
	if index <= -1: return "Enemy not specified (Type a number)"

	# If the enemy the player wants to attack is not in the array of enemies
	if index > Core.active_enemies.size(): return "There is no %s %s" % [words[ENEMY], words[INDEX]]

	Core.active_enemies[index].attack(10)

	return "You attack the %s!" % words[ENEMY]
