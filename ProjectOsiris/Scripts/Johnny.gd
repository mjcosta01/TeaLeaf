extends KinematicBody2D

#constants
export var jump_speed = -400;
export var runspeed = 100;
export var gravity = 1200;
const HAMMER_TIME = preload("res://Objects/Hammer.tscn");
#parts of the game
var curr_health = 3;
var max_health = 3;
var max_frames = 1200;
#collectors
var coins = 0;
var ammo = 3;
#manage iframes
var in_trance = false
var iframes = max_frames;
#manage physics
var vel = Vector2()
var direction = 0;
#manage signals
signal took_damage(damage);
signal gain_coin(coin);
signal lose_coin(coin);
signal buy_hammer(hammer);
signal launch_hammer(inst ,hammer);
var jumping = false
################################################
signal buy1()
signal buy2()
signal buy3()
###############################################
#object collision handler
func handle_collision(col: KinematicCollision2D):
	var par = col.get_collider()
	if par.is_in_group("Monsters"):
		if col.position.y > position.y + 12:
			if !in_trance:
				par.queue_free();
				vel.y = -300;
				return;
		elif !in_trance:
			print("boop");
			get_hurt();
			vel.y = -500;
	elif par.is_in_group("Coin"):
		if(!par.taken):
			coins += 1;
			emit_signal("gain_coin",1);
			par.taken = true;
		pass
		par.queue_free();
	return
#while there are iframes still left, do not take more damage, otherwise take damage
func get_hurt():
	if in_trance:
		return
	lose_health(1)
	iframes = 0
	get_node("SpriteStuff").visible = false
	in_trance = true;

func handle_coin():
	coins += 1;
	emit_signal("gain_coin",1);
	return
func throw_hammer():
	if ammo > 0:
		var ham = HAMMER_TIME.instance();
		ham.global_position = global_position;
		if direction == 0:
			ham.position.x += 16
		else:
			ham.position.x += 16
		get_parent().add_child(ham);
		ammo -= 1;
		emit_signal("launch_hammer", ham, direction);
		
#handle keyboard inputs
func get_input():
	vel.x = 0
	var right = Input.is_action_pressed("right")
	var left = Input.is_action_pressed("left")
	var jump = Input.is_action_just_pressed("jump")
	var attack = Input.is_action_just_pressed("attack");
	
	if right:
		get_node("SpriteStuff").set_flip_h(false)
		vel.x += runspeed
		direction = 0;
	if left: 
		get_node("SpriteStuff").set_flip_h(true)
		vel.x -= runspeed
		direction = 1;
	if jump and is_on_floor():
		jumping = true
		vel.y = jump_speed
	if attack:
		throw_hammer();
		

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
