extends Area2D

var move_speed = 50 # Velocidad de movimiento de la plataforma.
var move_distance = 100 # Distancia total de movimiento.
var start_position = Vector2.ZERO # Posición inicial de la plataforma.

var direction = 1
var initial_position

func _ready():
	initial_position = position

func _process(delta):
	# Mover la plataforma hacia arriba y hacia abajo
	position.y += direction * move_speed * delta
	
	# Cambiar la dirección al alcanzar la distancia máxima
	if position.y > initial_position.y + move_distance:
		direction = -1
	elif position.y < initial_position.y - move_distance:
		direction = 1
