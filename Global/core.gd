extends Node

signal update_hud()


onready var enemy_timer = Timer.new()

var enemy_index # The enemy that's supposed to do something
var active_enemies = {
	"gobokin": [],
	"gangman": [],
}

func _ready():
	if Ply.connect('action_done', self, '_on_action_done') == OK: pass	
	if enemy_timer.connect('timeout', self, '_on_timer_timeout') == OK: pass	

	add_child(enemy_timer)

func get_all_enemies() -> Array:
	var all_enemies = []
	# Combine the arrays
	for array in active_enemies.values():
		all_enemies.append_array(array)
	
	return all_enemies

func _on_action_done() -> void:
	Terminal.disable()
	# Start from the first enemy
	enemy_index = 0

	# Start timer
	enemy_timer.wait_time = 1.0
	enemy_timer.start()


func _on_timer_timeout():
	if Ply.health <=0:
		Lose()
		emit_signal("update_hud")
		enemy_timer.stop()
		return
	
	# Stop timer if all enemies are done doing stuff
	if enemy_index >= get_all_enemies().size():
		enemy_timer.stop()
		Actions.emit_signal("new_turn")
		Terminal.enable()
		emit_signal("update_hud")
		return
		


	# Make the next enemy do a thing
	get_all_enemies()[enemy_index].run_anim()
	enemy_index += 1

	
	emit_signal("update_hud")
	


func Win():
	if State.game_state == State.IDLE: return
	else:
		State.set_game_state(State.WIN)
		Terminal.add_response("You Won!")
		
		print(State.game_state)


func Lose():
	State.set_game_state(State.LOSS)
	Terminal.add_response("YOU LOST!")
	return
