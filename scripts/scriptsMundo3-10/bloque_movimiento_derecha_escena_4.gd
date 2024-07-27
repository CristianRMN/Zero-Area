extends CharacterBody2D
# Este bloque quita siempre 40 de vida

var move_speed_fast = 180 # Velocidad rápida de movimiento.
var move_speed_slow = 50 # Velocidad lenta de movimiento.
var move_distance = 110 # Distancia total de movimiento.
var start_position = Vector2.ZERO # Posición inicial de la plataforma.
@onready var anim = $AnimationPlayer

var direction = 1
var initial_position

func _ready():
	initial_position = position
	anim.play("seMueveDerecha")

func _process(delta):
	# Mover la plataforma hacia la izquierda rápidamente y hacia la derecha lentamente
	if direction == -1:
		position.x -= move_speed_slow * delta
	else:
		position.x += move_speed_fast * delta
	
	# Cambiar la dirección al alcanzar la distancia máxima
	if position.x > initial_position.x + move_distance:
		direction = -1
	elif position.x < initial_position.x - move_distance:
		direction = 1
