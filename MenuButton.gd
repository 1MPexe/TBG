extends ColorRect

onready var menus = $Tabs.get_children()
onready var buttons = $Buttons.get_children()

enum {PLAYER, SKILL, OPTIONS, MENU}

func _ready():
	for i in buttons.size():
		buttons[i].connect("button_up", self, "_on_button_pressed", [i])
	

	
func _on_button_pressed(idx: int):
	for i in menus.size():
		menus[i].visible = false
	if State.menu_state == idx : 
		State.menu_state = State.CLOSED
	else : 
		State.menu_state = idx
		menus[State.menu_state].visible = true
	

