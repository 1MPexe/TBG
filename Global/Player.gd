extends Node

signal action_done()

var health = 50
var max_health = 50
var mana = 150
var max_mana = 150
var desire = 150
var alignment = 100
var power = 10




func damage(amount):
	health -= amount

func temp():
	emit_signal('action_done')
	
