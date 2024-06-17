extends Area2D

@export var speed = 600 # Velocidad de la bola de fuego.
var velocity = Vector2.ZERO # Vector de movimiento de la bola de fuego

func _ready():
	$AnimatedSprite2D.play("bolaDeFuego")

func _process(delta):
	# Mover la bola de fuego
	position += velocity * delta
	
	# Eliminar la bola de fuego cuando sale de la pantalla
	if position.x > get_viewport_rect().size.x or position.x < 0:
		queue_free()

# Método para configurar la dirección y velocidad de la bola de fuego
func setup(direction):
	if direction == "right":
		$AnimatedSprite2D.flip_h = false
	elif direction == "left":
		$AnimatedSprite2D.flip_h = true
