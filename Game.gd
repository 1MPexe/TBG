extends Control


const InputResponse = preload("res://InputResponse.tscn")
const Response = preload("res://Response.tscn")


export (int) var max_lines_remembered := 25

var max_scroll_length := 0

onready var history_rows = $BackGround/TextArea/GameInfo/Scroll/HistoryRows
onready var scroll = $BackGround/TextArea/GameInfo/Scroll
onready var scrollbar = scroll.get_v_scrollbar()


func _ready() -> void:
	scrollbar.connect("changed", self, "handle_scrollbar_changed")
	max_scroll_length = scrollbar.max_value
	var starting_message = Response.instance()
	starting_message.text = "You find yourself in a strange new world. You can type 'help' to view the available commands."
	add_response_to_game(starting_message)

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
