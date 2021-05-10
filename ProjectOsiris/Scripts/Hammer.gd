extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var direction = 0;
#var gravity = 1200;
var throw_speed = 100;
var velocity = Vector2();
# Called when the node enters the scene tree for the first time.
func _ready():
	velocity.y -= 500;
	velocity.x += throw_speed;
	pass # Replace with function body.

func handle_collision(col: KinematicCollision2D):
	var obj = col.get_collider()
	if obj.is_in_group("Monsters"):
		obj.queue_free();
		queue_free();
	if obj.is_in_group("Player"):
		pass;


func _physics_process(delta):
	if direction == 0:
		rotate(0.19);
	else:
		throw_speed = -500;
		rotate(-0.19);
	velocity.y += gravity * delta;
	position += velocity *delta;


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass




func _on_Hammer_Time_body_entered(body):
	if body.is_in_group("Monsters"):
		body.queue_free();
		queue_free();
	if body.is_in_group("Player"):
		pass;
	queue_free();
