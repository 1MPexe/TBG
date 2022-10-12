extends Node

enum {IDLE,BATTLE,WIN,LOSS,PLAYER,SKILLS,MENU,OPTIONS}
  #     0     1     2   3     4     5      6      7
var current_state = IDLE


func set_state(state):
	current_state = state


