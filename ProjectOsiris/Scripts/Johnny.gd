extends KinematicBody2D

export var jump_speed = -400;
export var runspeed = 100;
export var gravity = 1200;
#var Spr = get_node("SpriteStuff");
var vel = Vector2()

var jumping = false
func get_input():
	vel.x = 0
	var right = Input.is_action_pressed("right")
	var left = Input.is_action_pressed("left")
	var jump = Input.is_action_just_pressed("jump")
	
	if jump and is_on_floor():
		jumping = true
		vel.y = jump_speed
	if right:
		get_node("SpriteStuff").set_flip_h(false)
		vel.x += runspeed
	if left: 
		get_node("SpriteStuff").set_flip_h(true)
		vel.x -= runspeed

func _physics_process(delta):
	if vel.x == 0:
		get_node("SpriteStuff").set_animation("Standby")
	else:
		get_node("SpriteStuff").set_animation("running")
	if (vel.y < 0):
		get_node("SpriteStuff").set_animation("jumping")
	get_input()
	vel.y += gravity * delta
	if jumping and is_on_floor():
		jumping = false
	vel = move_and_slide(vel, Vector2(0,-1))	
