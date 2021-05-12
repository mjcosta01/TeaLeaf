extends Area2D


export var levelID = 0
export var path = "res://Scenes/Trial/Level2.tscn";
var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	Global.current_levelID = levelID


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

#When the Player collides with the door, roll the random number and go to the next level, except the hub, not sure about the proper syntax, so it will be in comments for now
#func _level_progress():
#	pass




func _on_Area2D_body_entered(body):
	if !body.is_in_group("Player"):
		return;
	Global.goto_scene(path);
	
