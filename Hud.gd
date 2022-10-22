extends Control




# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	if Actions.connect('new_turn', self, '_on_new_turn') == OK:
		pass


func _on_new_turn():
	$PlayerInfo/HealthBar.value = Ply.health
	$PlayerInfo/HealthBar/PlayerHealth.text = "Health : %d/%d" % [Ply.health, Ply.max_health]
