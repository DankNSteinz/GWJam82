extends CharacterBody2D

const SPEED = 0.01

var target_pos = null
var target_pos_list = []
var target_pos_index = 0

@onready var route = $route
@onready var sprites = $human_sprites

func _ready():
	set_sprites()
	for node in route.get_children():
		target_pos_list.append(node.global_position)
	target_pos = target_pos_list[0]

func set_sprites():
	sprites.set_skin_mod(Color("a2777b"))
	sprites.set_eyes_mod(Color("f0ebeb"))
	sprites.set_head_mod(Color("0b0b22"))
	sprites.set_body_mod(Color("9a4485"))
	sprites.set_legs_mod(Color("4d2c50"))
	sprites.set_head([0,1,3].pick_random())
	sprites.set_body([1,2,3].pick_random())
	sprites.set_legs([1,2].pick_random())


func _physics_process(_delta):
	if target_pos:
		global_position = lerp(global_position, target_pos, SPEED)
		if global_position.snapped(Vector2(20,20)) == target_pos.snapped(Vector2(20,20)):
			target_pos_index = (target_pos_index + 1) % target_pos_list.size()
			target_pos = target_pos_list[target_pos_index]
