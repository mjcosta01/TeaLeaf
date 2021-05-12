extends Node2D

export var curr_health = 3
export var max_hp = 3
var hp_array = []
var curr = Sprite
func hello():
	print("hello!")
# Called when the node enters the scene tree for the first time.
func _ready():
	update_health(3)

func update_health(health):
	curr_health = health
	hp_array = get_children()
	for i in health:
		curr = hp_array[i] as Sprite
		curr.z_index = 1;
func lose_health(damage):
	curr_health -= damage
	hp_array = get_children()
	for i in range(max_hp - 1, 0, -1):
		curr = hp_array[i] as Sprite
		curr.visible = true


func _on_Johnny_took_damage(damage):
	
	curr_health -= damage
	hp_array = get_children()
	
	for i in hp_array:
		curr = i as Sprite
		curr.z_index = -1
		
	update_health(curr_health);
	pass # Replace with function body.


func _on_Johnny_healed_damage(damage):
	curr_health += damage;
	update_health(curr_health);
	pass # Replace with function body.


func _on_Johnny_update_hp(hp):
	_on_Johnny_took_damage(0);
	update_health(hp);
	pass # Replace with function body.
