extends CharacterBody2D

var move_speed = 50 # Velocidad de movimiento de la plataforma.
var move_distance = 200 # Distancia total de movimiento.
var start_position = Vector2.ZERO # Posición inicial de la plataforma.

var direction = -1 # Comienza moviéndose hacia la izquierda.
var initial_position

func _ready():
	initial_position = position

func _process(delta):
	# Mover la plataforma hacia la izquierda y la derecha
	position.x += direction * move_speed * delta
	
	# Cambiar la dirección al alcanzar la distancia máxima
	if position.x > initial_position.x + move_distance:
		direction = -1
	elif position.x < initial_position.x - move_distance:
		direction = 1
