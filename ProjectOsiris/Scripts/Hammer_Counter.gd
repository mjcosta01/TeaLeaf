extends Label


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var hammer_count = 3;

# Called when the node enters the scene tree for the first time.
func _ready():
	text = "x " + String(hammer_count);
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Johnny_buy_hammer(hammer):
	hammer_count += 1;
	text = "x " + String(hammer_count);


func _on_Johnny_launch_hammer(hammer):
	hammer_count -= 1;
	text = "x " + String(hammer_count);
