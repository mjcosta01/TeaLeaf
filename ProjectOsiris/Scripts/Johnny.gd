extends KinematicBody2D


export var jump_speed = -400;
export var runspeed = 100;
export var gravity = 1200;
var curr_health = 3;
var max_health = 3;
var max_frames = 1200;
var in_trance = false
var iframes = max_frames;
#var Spr = get_node("SpriteStuff");
var vel = Vector2()
signal took_damage(damage)
var jumping = false

func handle_collision(col: KinematicCollision2D):
	var par = col.get_collider()
	if par.is_in_group("Monsters"):
		if col.position.y > position.y + 12:
			if !in_trance:
				par.queue_free();
				vel.y = -300;
				pass;
		elif !in_trance:
			print("boop");
			get_hurt();
			vel.y = -500;
	return
#while there are iframes still left, do not take more damage, otherwise take damage
func get_hurt():
	if in_trance:
		pass
	lose_health(1)
	iframes = 0
	get_node("SpriteStuff").visible = false
	in_trance = true;

#handle keyboard inputs
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

#physic loop for the player
func _physics_process(delta):
	if vel.x == 0:
		get_node("SpriteStuff").set_animation("Standby")
	else:
		get_node("SpriteStuff").set_animation("running")
	if (vel.y < 0):
		if is_on_floor() == false:
			get_node("SpriteStuff").set_animation("jumping")
	get_input()
	if not is_on_floor():
		vel.y += gravity * delta
	if jumping and is_on_floor():
		jumping = false
	vel = move_and_slide(vel, Vector2(0,-1))	
	for i in get_slide_count():
		var col = get_slide_collision(i)
		handle_collision(col)
		
func _process(delta):
	if in_trance:
		pass;
	if iframes != max_frames:
		for i in 10:
			yield(get_tree().create_timer(0.1), "timeout")
			get_node("SpriteStuff").visible = !get_node("SpriteStuff").visible
			in_trance = true;
		iframes = max_frames
		in_trance = false;
	else:
		get_node("SpriteStuff").visible = true

#gaining health raises hp
func gain_health(hp):
	curr_health += hp
	if curr_health > max_health:
		curr_health = max_health
		
#lose health function emits damage signal so UI can handle and subtracts HP by damage
func lose_health(hp):
	curr_health -= hp
	emit_signal("took_damage", hp)
	if curr_health <= 0:
		die()
		curr_health = 0
		
func die():
	print("I died")
	pass
