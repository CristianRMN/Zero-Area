extends CharacterBody2D
#Estos bloques te quitan siempre 50 de vida
var move_speed = 300 # Velocidad de movimiento de la plataforma.
var move_distance = 62 # Distancia total de movimiento.
var start_position = Vector2.ZERO # Posición inicial de la plataforma.
@onready var anim = $AnimationPlayer

var direction = 1
var initial_position

func _ready():
	initial_position = position
	anim.play("movimiento")

func _process(delta):
	# Mover la plataforma hacia arriba y hacia abajo
	position.y += direction * move_speed * delta
	
	# Cambiar la dirección al alcanzar la distancia máxima
	if position.y > initial_position.y + move_distance:
		direction = -1
		move_speed = 50
	elif position.y < initial_position.y - move_distance:
		direction = 1
		move_speed = 300
