extends Node2D

const head_spritesheet = {
	0 : preload("res://human/Trim.png"),
	1 : preload("res://human/Scruffy.png"),
	2 : preload("res://human/Cap.png")
}

const body_spritesheet = {
	0 : preload("res://human/Vest.png"),
	1 : preload("res://human/Shirt.png"),
	2 : preload("res://human/Suit.png"),
	3 : preload("res://human/Cloak.png")
}

const legs_spritesheet = {
	0 : preload("res://human/Shorts.png"),
	1 : preload("res://human/Trousers.png"),
	2 : preload("res://human/Dress.png")
}

@onready var skinSprite = $skin
@onready var eyesSprite = $eyes
@onready var headSprite = $head
@onready var bodySprite = $body
@onready var legsSprite = $legs

func set_head(index):
	if index == 3:
		headSprite.visible = false
	else:
		headSprite.visible = true
		headSprite.texture = head_spritesheet[index]

func set_body(index):
	bodySprite.texture = body_spritesheet[index]

func set_legs(index):
	legsSprite.texture = legs_spritesheet[index]

func set_skin_mod(mod):
	skinSprite.self_modulate = mod

func set_eyes_mod(mod):
	eyesSprite.self_modulate = mod

func set_head_mod(mod):
	headSprite.self_modulate = mod

func set_body_mod(mod):
	bodySprite.self_modulate = mod

func set_legs_mod(mod):
	legsSprite.self_modulate = mod
