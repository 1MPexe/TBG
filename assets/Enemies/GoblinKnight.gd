extends Control


var health = 20


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func die():
	self.queue_free()
