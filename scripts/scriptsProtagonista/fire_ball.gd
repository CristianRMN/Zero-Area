extends CharacterBody2D

@export var speed = 200
@onready var animation = $AnimationPlayer
@onready var sprite = $Sprite

func _ready():
	# Configuración inicial
	pass

func _physics_process(delta):
	velocity.x = speed * delta 
	# Mueve la bola de fuego y detecta colisiones
	var collision = move_and_collide(velocity)
	if collision:
		_on_collision(collision)

	animation.play("shoot_fire_ball")

func _on_collision(collision):
	# Maneja lo que sucede cuando la bola de fuego colisiona
	queue_free()  # Elimina la bola de fuego al colisionar

func setup(direction):
	if direction == "right":
		sprite.flip_h = false
	elif direction == "left":
		sprite.flip_h = true
