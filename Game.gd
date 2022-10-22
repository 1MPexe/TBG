extends Control

#Max lines remembered in history row
var max_scroll_length := 0

onready var scroll = $TextArea/GameInfo/Scroll
onready var scrollbar = scroll.get_v_scrollbar()


#sets up command line
func _ready() -> void:
	Terminal.history_rows = $TextArea/GameInfo/Scroll/HistoryRows

	scrollbar.connect("changed", self, "handle_scrollbar_changed")
	max_scroll_length = scrollbar.max_value
	
	Terminal.add_response("You find yourself in a strange new world. You can type 'help' to view the available commands.")
	
	if Actions.connect('new_turn', self, '_on_new_turn') == OK:
		pass
	if Actions.connect('loss_battle', self, 'Game_Over') == OK:
		pass






#sets command line scroll length
func handle_scrollbar_changed():
	if max_scroll_length != scrollbar.max_value:
		max_scroll_length = scrollbar.max_value
		scroll.scroll_vertical = max_scroll_length


func _on_Input_text_entered(new_text: String):
	if new_text.empty():
		return

	Actions.process_command(new_text)








# Starts a battle
func start_battle():
	# Don't start a battle if a battle is already running.
	if State.game_state == State.BATTLE: return

	State.set_game_state(State.BATTLE)
	
	# Spawns 3 goblins
	for i in 3:
		var new_gobokin = Enemies.gobokin.instance()
		$Battle/Enemies.add_child(new_gobokin)
		Core.active_enemies["gobokin"].append(new_gobokin)
	
	#Puts each goblin into the active_enemies dictionary
	for enemy in Core.active_enemies["gobokin"] : 
		Terminal.add_response("A %s appeared!" % enemy.enemy_name)
	
	print(Core.get_all_enemies().size())


# Clears enemies on screen and enemies in the dictionary
func end_battle():
	State.set_game_state(State.IDLE)
	for enemy in $Battle/Enemies.get_children():
		enemy.queue_free()
	for array in Core.active_enemies.values() :
		array.clear()
	print(Core.active_enemies)


#update player stats every turn
func _on_new_turn():
	print("it's a new turn!")

func Game_Over():
	if Ply.health <= 0:
		State.set_game_state(State.LOSS)
		Terminal.add_response("YOU LOST!")
		return

