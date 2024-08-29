extends CharacterBody2D


var move_speed = 50 # Velocidad de movimiento de la plataforma.
var move_distance = 150 # Distancia total de movimiento.
var start_position = Vector2.ZERO # Posición inicial de la plataforma.
@onready var anim = $AnimationPlayer

var direction = -1
var initial_position

func _ready():
	initial_position = position
	anim.play("move")

func _process(delta):
	# Mover la plataforma hacia arriba y hacia abajo
	position.y += direction * move_speed * delta
	
	# Cambiar la dirección al alcanzar la distancia máxima
	if position.y > initial_position.y + move_distance:
		direction = -1
		move_speed = 50
	elif position.y < initial_position.y - move_distance:
		direction = 1
		move_speed = 200
