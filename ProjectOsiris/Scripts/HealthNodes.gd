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
		curr.visible = true
func lose_health(damage):
	curr_health -= damage
	hp_array = get_children()
	for i in range(max_hp - 1, 0, -1):
		curr = hp_array[i] as Sprite
		curr.visible = true
