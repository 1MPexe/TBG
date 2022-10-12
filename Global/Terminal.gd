extends Node

const response_prefab = preload("res://Response.tscn")

# Response Variables
var history_rows: VBoxContainer
var max_lines_remembered := 25

#Creates a new response within history row
func add_response(text: String):
	var new_response = response_prefab.instance()
	new_response.text = text
	history_rows.add_child(new_response)
	delete_history_beyond_limit()

#Removes past text beyond limit
func delete_history_beyond_limit():
	if history_rows.get_child_count() > max_lines_remembered:
		var rows_to_forget = history_rows.get_child_count() - max_lines_remembered
		for i in range(rows_to_forget):
			history_rows.get_child(i).queue_free()