extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Button101_pressed():
	get_tree().change_scene("Node.tscn")
	pass # Replace with function body.


func _on_Button102_pressed():
	$"Pos_p".visible = true
	pass # Replace with function body.


func _on_Button103_pressed():
	$"Pos_u".visible = true
	pass # Replace with function body.


func _on_Button1000_pressed():
	$"Pos_p".visible = false
	pass # Replace with function body.


func _on_ButtonNO_pressed():
	$"Pos_u".visible = false
	pass # Replace with function body.


func _on_ButtonYES_pressed():
	get_tree().quit()
	pass # Replace with function body.
