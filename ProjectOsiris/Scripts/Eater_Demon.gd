extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var movespeed = 50
export var is_monster = true
export var gravity = 500
var dir = false
var flag = false
var vel = Vector2()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
func get_direction():
	if dir == false:
		get_node("SpriteStuff").set_flip_h(false)
		vel.x = movespeed
	else:
		get_node("SpriteStuff").set_flip_h(true)
		vel.x = -movespeed
	if is_on_wall():
		if flag == false:
			dir = !dir
			flag = true
		else: 
			yield(get_tree().create_timer(0.1), "timeout")
			flag = false
		
func _physics_process(delta):
	vel.y += gravity * delta
	if vel.x == 0:
		get_node("SpriteStuff").set_animation("Standby")
	else:
		get_node("SpriteStuff").set_animation("Walking")
	get_direction()
	vel = move_and_slide(vel, Vector2(0,-1))
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
