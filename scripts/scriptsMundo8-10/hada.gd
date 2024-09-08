extends Area2D

@onready var anim = $AnimationPlayer
@export var speed = 110  # Velocidad a la que se mueve la gaviota
@export var limit_screen = 1150  # Límite de la pantalla para mover el viento hacia la derecha
@export var start_position = Vector2(-880, -490)  

func _ready():
	anim.play("move")

func _process(delta):
	# Mover el nodo hacia la derecha
	position.x += speed * delta
	# Resetear la posición y reiniciar la animación cuando se alcanza el límite
	if position.x > limit_screen:
		position = start_position
		anim.play("move")
