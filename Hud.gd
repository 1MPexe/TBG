extends Control

onready var tween = Tween.new()


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if Core.connect('update_hud', self, '_on_update_hud') == OK: pass

	add_child(tween)


func _on_update_hud():
	# $PlayerInfo/HealthBar.value = Ply.health
	$PlayerInfo/HealthBar/PlayerHealth.text = "Health : %d/%d" % [Ply.health, Ply.max_health]
	tween.interpolate_property($PlayerInfo/HealthBar, 'value', $PlayerInfo/HealthBar.value, Ply.health, 0.5, Tween.TRANS_CUBIC, Tween.EASE_IN_OUT)
	tween.start()
	print("Health : %d/%d" % [Ply.health, Ply.max_health])
