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
signal play_jump();
signal play_walk();
signal play_hit();
signal update_hp(hp);
signal play_coin();
signal play_purchase();
signal took_damage(damage);
signal healed_damage(damage);
signal gain_coin(coin);
signal lose_coin(coin);
signal buy_hammer(hammer);
signal launch_hammer(inst ,hammer);
var jumping = false
################################################
var shop = 0;
###############################################
var action;
#object collision handler
func handle_collision(col: KinematicCollision2D):
	var par = col.get_collider()
	if par.is_in_group("Monsters"):
		if col.position.y > position.y + 12:
			if !in_trance:
				emit_signal("play_hit");
				par.queue_free();
				vel.y = -300;
				return;
		elif !in_trance:
			get_hurt();
			vel.y = -500;
	elif par.is_in_group("OneShot"):
		if col.position.y > position.y + 12:
			if !in_trance:
				emit_signal("play_hit");
				die();
				return;
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
	Global.coins = coins;
	emit_signal("play_coin");
	emit_signal("gain_coin",1);
	return
func handle_shop(shopnum):
	shop = shopnum;
	if shop == 0 || !action:
		return;
	if action && shop == 1:
		if coins >= 3:
			coins -= 3;
			Global.coins -= 3;
			ammo += 1;
			Global.hammers += 1;
			emit_signal("lose_coin",3);
			emit_signal("buy_hammer",1);
	elif action && shop == 2:
		if coins >= 5 && curr_health < max_health:
			coins -= 5;
			Global.coins -= 5;
			curr_health += 1;
			Global.health += 1
			emit_signal("healed_damage",1);
			emit_signal("lose_coin",5);
	elif action && shop == 3:
		if coins >= 10:
			runspeed += 30;
			Global.movespeed += 30;
			coins -= 10;
			Global.coins -= 10;
			emit_signal("lose_coin",10);
	emit_signal("play_purchase");
func throw_hammer():
	if ammo > 0:
		var ham = HAMMER_TIME.instance();
		ham.global_position = global_position;
		if direction == 0:
			ham.position.x += 8
		else:
			ham.position.x += 8
		get_parent().add_child(ham);
		ham.direction = direction;
		ammo -= 1;
		Global.hammers -= 1;
		emit_signal("launch_hammer", ham, direction);
		emit_signal("play_walk");
		
#handle keyboard inputs
func get_input():
	vel.x = 0
	var right = Input.is_action_pressed("right")
	var left = Input.is_action_pressed("left")
	var jump = Input.is_action_just_pressed("jump")
	var attack = Input.is_action_just_pressed("attack");
	action = Input.is_action_just_pressed("action");
	if right:
		get_node("SpriteStuff").set_flip_h(false)
		vel.x += runspeed
		direction = 0;
	if left: 
		get_node("SpriteStuff").set_flip_h(true)
		vel.x -= runspeed
		direction = 1;
	#making jumping a bit more consistent
	if jump and (is_on_floor() || (get_floor_normal().y - vel.y >= 0 and get_floor_normal().y - vel.y < 0.1)):
		jumping = true
		vel.y = jump_speed
		emit_signal("play_jump");
	if attack:
		throw_hammer();
	if action:
		handle_shop(shop);
func _ready():
	curr_health = Global.health;
	coins = Global.coins;
	ammo = Global.hammers;
	runspeed = Global.movespeed;
	emit_signal("update_hp",curr_health);
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
	if vel.y > 4000:
		lose_health(max_health);
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
	curr_health -= hp;
	Global.health = curr_health;
	emit_signal("took_damage", hp);
	if curr_health <= 0:
		die()
		curr_health = 0
		
func die():
	Global.health = 3;
	Global.goto_scene("res://Scenes/Trial/Level1.tscn");
	pass
