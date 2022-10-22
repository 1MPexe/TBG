extends Node

const response_prefab = preload("res://Response.tscn")
const input_response_prefab = preload("res://InputResponse.tscn")

# Response Variables
var history_rows: VBoxContainer
var max_lines_remembered := 25
var last_user_input: String  #The last thing the user has input
var line_edit: LineEdit

#Creates a new response within history row
func add_response(text: String):
	var new_response = response_prefab.instance()
	new_response.text = text
	history_rows.add_child(new_response)
	delete_history_beyond_limit()

#Removes past text beyond limitZ
func delete_history_beyond_limit():
	if history_rows.get_child_count() > max_lines_remembered:
		var rows_to_forget = history_rows.get_child_count() - max_lines_remembered
		for i in range(rows_to_forget):
			history_rows.get_child(i).queue_free()


func add_input_response(response: String):
	var new_input_response = input_response_prefab.instance()
	# Changed this to set_text() to access function <3
	new_input_response.set_text(last_user_input, response)

	history_rows.add_child(new_input_response)
	delete_history_beyond_limit()

func disable():
	line_edit.editable = false

func enable():
	line_edit.editable = true