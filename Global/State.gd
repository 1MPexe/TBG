extends Node

enum{PLAYER,SKILLS,MENU,OPTIONS,CLOSED}

enum {IDLE,BATTLE,WIN,LOSS}

var game_state = IDLE
var menu_state = CLOSED

func set_game_state(state):
	game_state = state

func set_menu_state(state):
	menu_state = state
