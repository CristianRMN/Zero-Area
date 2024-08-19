extends Area2D

var move_speed = 1
var move_distance = 20
var start_position = Vector2.ZERO 
var direction = 1
var initial_position

func _ready():
	initial_position = position

func _process(delta):
	# Mover la plataforma hacia arriba y hacia abajo
	position.y += direction * move_speed * delta
	
	# Cambiar la dirección al alcanzar la distancia máxima
	if position.y > initial_position.y + move_distance:
		move_speed = 0
