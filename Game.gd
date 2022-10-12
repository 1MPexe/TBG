extends Control

#Spawns text within command line text area
const InputResponse = preload("res://InputResponse.tscn")

#Enemy preloads
const goblin_knight_prefab = preload("res://assets/Enemies/GoblinKnight.tscn")


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
	Actions.connect("next_turn", self, "on_next_turn")



func _physics_process(_delta):
	$PlayerFrame/HealthBar.value = Ply.health
	get_node("PlayerFrame/HealthBar/PlayerHealth").text = "Health : %d/%d" % [Ply.health, Ply.max_health]
	



#sets command line scroll length
func handle_scrollbar_changed():
	if max_scroll_length != scrollbar.max_value:
		max_scroll_length = scrollbar.max_value
		scroll.scroll_vertical = max_scroll_length


func _on_Input_text_entered(new_text: String) -> void:
	if new_text.empty():
		return

	var input_response = InputResponse.instance()
	var response = Actions.process_command(new_text)
	input_response.set_text(new_text, response)
	Terminal.history_rows.add_child(input_response)






# Starts a battle
func start_battle():
	# Don't start a battle if a battle is already running.
	if State.current_state == State.BATTLE: return

	State.set_state(State.BATTLE)
	Ply.health = 100

	# Spawns 3 goblins
	for i in 3:
		var new_goblinknight = goblin_knight_prefab.instance()
		$Battle/Enemies.add_child(new_goblinknight)
		Core.active_enemies["goblinknight"].append(new_goblinknight)
	
	#Puts each goblin into the active_enemies dictionary
	for enemy in Core.active_enemies["goblinknight"] : 
		Terminal.add_response("A %s appeared!" % enemy.enemy_name)

# Clears enemies on screen and enemies in the dictionary
func end_battle():
	State.set_state(State.IDLE)
	for enemy in $Battle/Enemies.get_children():
		enemy.queue_free()
	for array in Core.active_enemies.values() :
		array.clear()
	print(Core.active_enemies)

func on_next_turn():
	print("it's a new turn!")

func Game_Over():
	if Ply.health == 0:
		pass
