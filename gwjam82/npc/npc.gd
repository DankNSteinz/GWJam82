extends CharacterBody2D

const SPEED =1250

var target_pos = null
var target_pos_list = []
var target_pos_index = 0

@onready var route = $route
@onready var sprites = $human_sprites
@onready var animationTree = $human_sprites/anim_tree
@onready var animationState = animationTree.get("parameters/playback")
@onready var player_detection = $player_detection
@onready var raycast = $raycast

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

func _physics_process(delta):
	if target_pos:
		var vec = Vector2(target_pos - global_position).normalized()
		velocity = vec * SPEED * delta
		if global_position.snapped(Vector2(20,20)) == target_pos.snapped(Vector2(20,20)):
			target_pos_index = (target_pos_index + 1) % target_pos_list.size()
			target_pos = target_pos_list[target_pos_index]
		animationTree.set("parameters/idle/blend_position", vec)
		animationTree.set("parameters/walk/blend_position", vec)
		animationState.travel("walk")
		player_detection.rotation = vec.angle() - 1.57
		move_and_slide()

func _on_near_area_body_entered(body):
	if body.is_in_group("player"):
		raycast.enabled = true
		raycast.target_position = body.global_position - global_position
		raycast.force_raycast_update()
		if raycast.get_collider() == body:
			body.player_caught()
