extends Camera2D

var www = 0
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	
	pass # Replace with function body.

func _physics_process(delta):
	self.position=$"../KinematicBody2D".position
	var v = get_viewport_rect().size
	self.position -= v/2
	pass



