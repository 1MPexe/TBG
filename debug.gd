extends Control

func _ready():
	visible = false

func _input(event):
	if event.is_action_pressed("debug"):
		visible = !visible


func _physics_process(_delta):
	$ActiveEnemies.text = JSON.print(Core.active_enemies, "\t")
