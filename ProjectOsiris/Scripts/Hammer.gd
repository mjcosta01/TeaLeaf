extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var direction = 0;
var gravity = 1200;
var throw_speed = 500;
var velocity = Vector2();
# Called when the node enters the scene tree for the first time.
func _ready():
	velocity.y -= -400;
	velocity.x += throw_speed;
	pass # Replace with function body.

func handle_collision(col: KinematicCollision2D):
	var obj = col.get_collider()
	if obj.is_in_group("Monsters"):
		obj.queue_free();
	if obj.is_in_group("Player"):
		pass;
	queue_free();

func _physics_process(delta):
	if direction == 0:
		rotate(0.19);
	else:
		throw_speed = -500;
		rotate(-0.19);
	velocity.y += gravity * delta;
	velocity = move_and_slide(velocity, Vector2(0,-1));
	for i in get_slide_count():
		var col = get_slide_collision(i)
		handle_collision(col)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
