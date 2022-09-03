extends Node

# Prevents the command line from processing empty commands.
func process_command(input: String) -> String:
	var words = input.split(" ", false)
	if words.size() == 0:
		return "Error: no words were parsed."
		
	var first_word = words[0].to_lower()
	var second_word = ""
	if words.size() > 1:
		second_word = words[1].to_lower()

#  List of all available commands.
	match first_word:
		"go": 
			return go(second_word)
		"help":
			return help()
		"attack":
			return attack(second_word)
		"i'm":
			return im(second_word)
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


func attack(second_word: String) -> String:
	if second_word == "":
		return "Attack what?"
	
	return "You attack the %s!" % second_word
