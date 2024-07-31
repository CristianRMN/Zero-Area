extends Area2D

@onready var anim = $AnimationPlayer
@onready var sprite = $AveVerde1
var speed = 110  
var limit_screen = 800 
var start_position = Vector2(-890, -410)  

func _ready():
	anim.play("volar")

func _process(delta):
	# Mover el nodo hacia la derecha
	position.x += speed * delta
	# Resetear la posición y reiniciar la animación cuando se alcanza el límite
	if position.x > limit_screen:
		position = start_position
		anim.play("volar")
