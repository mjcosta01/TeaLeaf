extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export var taken = false;
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Coin_body_entered(body):
	if taken == true:
		return;
	taken = true;
	get_tree().call_group("Player","handle_coin");
	queue_free();
