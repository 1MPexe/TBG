extends Node

enum {IDLE,BATTLE,WIN,LOSS,PLAYER,SKILLS,MENU,OPTIONS}

var current_state = IDLE



func set_state(state):
	current_state = state
	


