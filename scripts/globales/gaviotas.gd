extends Area2D

@onready var anim = $AnimationPlayer
@onready var sprite = $Ave1
@export var speed = 200  # Velocidad a la que se mueve la gaviota
@export var limit_screen = 700  # Límite de la pantalla para mover el viento hacia la derecha
@export var start_position = Vector2(-890, -350)  

func _ready():
	anim.play("vuelo")

func _process(delta):
	# Mover el nodo hacia la derecha
	position.x += speed * delta
	sprite.flip_h = true
	# Resetear la posición y reiniciar la animación cuando se alcanza el límite
	if position.x > limit_screen:
		position = start_position
		anim.play("vuelo")
