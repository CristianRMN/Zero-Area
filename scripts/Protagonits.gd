extends Area2D

@export var speed = 400 # Velocidad del jugador (pixeles/segundo).
@export var jump_force = -600 # Fuerza del salto (negativa para moverse hacia arriba).
@export var gravedad = 1200 # Gravedad (positiva para moverse hacia abajo).

var screen_size # Tamaño de la ventana del juego.
var velocity = Vector2.ZERO # Vector de movimiento del jugador.
var is_on_floor = true # Variable para saber si el personaje está en el suelo.

func _ready():
	screen_size = get_viewport_rect().size

func _process(delta):
	# Reiniciar la velocidad horizontal en cada frame
	velocity.x = 0 

	if Input.is_action_pressed("caminar_derecha"):
		velocity.x += speed
		$AnimatedSprite2D.flip_h = false # No voltear cuando se mueve a la derecha.

	if Input.is_action_pressed("caminar_izquierda"):
		velocity.x -= speed
		$AnimatedSprite2D.flip_h = true # Voltear cuando se mueve a la izquierda.

	# Manejar el salto
	if Input.is_action_just_pressed("saltar") and is_on_floor:
		velocity.y = jump_force # Aplicar la fuerza de salto.
		is_on_floor = false # El personaje ya no está en el suelo

	# Aplicar la gravedad
	if not is_on_floor:
		velocity.y += gravedad * delta

	# Normalizar y aplicar la velocidad horizontal
	if velocity.x != 0:
		$AnimatedSprite2D.play()
	else:
		$AnimatedSprite2D.stop()
	
	position += velocity * delta

	# Limitar la posición del personaje dentro de la pantalla
	position = position.clamp(Vector2.ZERO, screen_size)

	# Limitar la posición vertical para que no salga de la pantalla
	if position.y >= screen_size.y:
		position.y = screen_size.y
		velocity.y = 0 # Resetear la velocidad vertical al tocar el suelo
		is_on_floor = true # El personaje está en el suelo
