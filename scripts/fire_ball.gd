# Nodo principal de la bola de fuego
extends CharacterBody2D

@export var speed = 200
@onready var animation = $AnimationPlayer
@onready var sprite = $Sprite




func _ready():
	pass
	
func _physics_process(delta):
	velocity.x = speed * delta
	translate(velocity)
	animation.play("shoot_fire_ball")
	
func setup(direction):
	if direction == "right":
		sprite.flip_h = false
		
	elif direction == "left":
		sprite.flip_h = true

