extends Polygon2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export var cost1 = 3;
export var cost2 = 5;
export var cost3 = 10;
var shop_array = [];

# Called when the node enters the scene tree for the first time.
func _ready():
	shop_array = get_children();
	pass # Replace with function body.

func add_hp(cost):
	
	return
	
func add_hammer(cost):
	return
func add_haste(cost):
	return
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Johnny_buy1():
	pass # Replace with function body.


func _on_Johnny_buy2():
	pass # Replace with function body.


func _on_Johnny_buy3():
	pass # Replace with function body.


func _on_B1_body_entered(body):
	get_tree().call_group("Player","handle_shop",1);
	pass # Replace with function body.


func _on_B2_body_entered(body):
	get_tree().call_group("Player","handle_shop",2);
	pass # Replace with function body.


func _on_B3_body_entered(body):
	get_tree().call_group("Player","handle_shop",3);
	pass # Replace with function body.


func _on_B1_body_exited(body):
	get_tree().call_group("Player","handle_shop",0);
	pass # Replace with function body.


func _on_B2_body_exited(body):
	get_tree().call_group("Player","handle_shop",0);
	pass # Replace with function body.


func _on_B3_body_exited(body):
	get_tree().call_group("Player","handle_shop",0);
	pass # Replace with function body.
