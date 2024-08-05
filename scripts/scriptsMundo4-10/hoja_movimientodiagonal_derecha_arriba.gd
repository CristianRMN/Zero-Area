extends CharacterBody2D

var move_speed = 40 # Velocidad de movimiento de la plataforma.
var move_distance = 110 # Distancia total de movimiento.
var start_position = Vector2.ZERO # Posición inicial de la plataforma.

var direction = 1
var initial_position

func _ready():
	initial_position = position

func _process(delta):
	# Mover la plataforma hacia arriba y hacia la derecha
	position.y -= direction * move_speed * delta
	position.x += direction * move_speed * delta
	
	# Cambiar la dirección al alcanzar la distancia máxima
	if direction == 1 and (position.y <= initial_position.y - move_distance or position.x >= initial_position.x + move_distance):
		direction = -1
	elif direction == -1 and (position.y >= initial_position.y or position.x <= initial_position.x):
		direction = 1
