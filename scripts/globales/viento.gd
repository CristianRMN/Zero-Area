extends Area2D

@onready var anim = $AnimViento
@export var speed = 100  # Velocidad a la que se mueve el viento
@export var limit_screen = 400  # Límite de la pantalla para mover el viento hacia la derecha
@export var start_position = Vector2(-474, -118)  # Posición inicial del viento fuera de la pantalla

func _ready():
	anim.play("haceViento")

func _process(delta):
	# Mover el nodo hacia la derecha
	position.x += speed * delta

	# Resetear la posición y reiniciar la animación cuando se alcanza el límite
	if position.x > limit_screen:
		position = start_position
		anim.play("haceViento")
