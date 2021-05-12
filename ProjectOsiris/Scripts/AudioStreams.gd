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


func _on_Johnny_play_coin():
	get_node("Gain").play()
	pass # Replace with function body.


func _on_Johnny_play_hit():
	get_node("Hit").play()
	pass # Replace with function body.


func _on_Johnny_play_jump():
	get_node("Jump").play()
	pass # Replace with function body.


func _on_Johnny_play_purchase():
	get_node("Purchase").play()
	pass # Replace with function body.


func _on_Johnny_play_walk():
	get_node("Walk").play()
	pass # Replace with function body.
