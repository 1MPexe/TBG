extends Node


#Ply for calling player.gd


var health = 100
var max_health = 100
var mana = 150
var max_mana = 150
var desire = 150
var alignment = 100
var power = 10
func damage(amount):
	health -= amount

