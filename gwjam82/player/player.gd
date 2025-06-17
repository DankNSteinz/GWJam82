extends CharacterBody2D

const WALK_SPEED = 75
const SPRINT_SPEED = 125
const ACCELERATION = 800
const FRICTION = 700

var input = Vector2.ZERO
var stamina = 100
var is_exploded = false
var is_caught = false

@onready var sprites = $human_sprites
@onready var animationTree = $human_sprites/anim_tree
@onready var animationState = animationTree.get("parameters/playback")

func _ready():
	set_sprites()

func _physics_process(delta):
	if not is_exploded and not is_caught:
		input = get_movement_input()
		player_movement(delta)
		if stamina <= 0:
			player_explode()

func set_sprites():
	sprites.set_skin_mod(Color.PEACH_PUFF)
	sprites.set_eyes_mod(Color.WHITE)
	sprites.set_head_mod(Color.RED)
	sprites.set_body_mod(Color.DARK_GREEN)
	sprites.set_legs_mod(Color.DARK_SLATE_GRAY)
	sprites.set_head(2)
	sprites.set_body(1)
	sprites.set_legs(1)

func get_movement_input():
	input.x = int(Input.is_action_pressed("move_right")) - int(Input.is_action_pressed("move_left"))
	input.y = int(Input.is_action_pressed("move_down")) - int(Input.is_action_pressed("move_up"))
	#input = input + get_parent().get_parent().get_node("joystick").get_joystick_dir()
	return input.normalized()

func player_movement(delta):
	if input != Vector2.ZERO:
		animationTree.set("parameters/idle/blend_position", input)
		animationTree.set("parameters/walk/blend_position", input)
		animationState.travel("walk")
		velocity += (input * ACCELERATION * delta)
		if Input.is_action_pressed("sprint") and stamina > 0:
			velocity = velocity.limit_length(SPRINT_SPEED)
			stamina -= 1
		else:
			velocity = velocity.limit_length(WALK_SPEED)
	else:
		animationState.travel("idle")
		if velocity.length() > (FRICTION * delta):
			velocity -= velocity.normalized() * (FRICTION * delta)
		else:
			velocity = Vector2.ZERO
	move_and_slide()

func player_explode():
	is_exploded = true
	sprites.visible = false
	print("dead")
