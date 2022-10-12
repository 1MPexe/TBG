extends Control

#Spawns text within command line text area
const InputResponse = preload("res://InputResponse.tscn")
const Response = preload("res://Response.tscn")

#Enemy preloads
const goblin_knight_prefab = preload("res://assets/Enemies/GoblinKnight.tscn")


#Max lines remembered in history row
export (int) var max_lines_remembered := 25

var max_scroll_length := 0


onready var history_rows = $TextArea/GameInfo/Scroll/HistoryRows
onready var scroll = $TextArea/GameInfo/Scroll
onready var scrollbar = scroll.get_v_scrollbar()




#sets up command line
func _ready() -> void:
	scrollbar.connect("changed", self, "handle_scrollbar_changed")
	max_scroll_length = scrollbar.max_value
	var starting_message = Response.instance()
	starting_message.text = "You find yourself in a strange new world. You can type 'help' to view the available commands."
	add_response_to_game(starting_message)
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

	var input_response =InputResponse.instance()
	var response = Actions.process_command(new_text)
	input_response.set_text(new_text, response)
	history_rows.add_child(input_response)

#Creates a new response within history row
func add_response_to_game(response: Control):
	history_rows.add_child(response)
	delete_history_beyond_limit()

#Removes past text beyond limit
func delete_history_beyond_limit():
	if history_rows.get_child_count() > max_lines_remembered:
		var rows_to_forget = history_rows.get_child_count() - max_lines_remembered
		for i in range(rows_to_forget):
			history_rows.get_child(i).queue_free()





#Battle script
func Battle():
	var max_enemies = 3
	var new_goblinknight = goblin_knight_prefab.instance()
	var battle_message = Response.instance()
	
	State.set_state(1)
	print(State.current_state)
	Ply.health = 100
	
	Core.enemy_count = $Battle/Enemies.get_child_count()
	if Core.enemy_count == max_enemies:
		return
	elif Core.enemy_count < max_enemies:
		$Battle/Enemies.add_child(new_goblinknight)
		Core.active_enemies["goblinknight"].append(new_goblinknight)
		
		print(Core.active_enemies)
		for enemy in Core.active_enemies["goblinknight"] : 
			battle_message.text = "A %s appeared!" % enemy.enemy_name
			add_response_to_game(battle_message)



func on_next_turn():
	print("it's a new turn!")

func Game_Over():
	if Ply.health == 0:
		pass
