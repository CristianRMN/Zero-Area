extends Area2D

@export var speed = 400 # Velocidad del jugador (pixeles/segundo).
@export var jump_force = -600 # Fuerza del salto (negativa para moverse hacia arriba).
@export var gravedad = 1200 # Gravedad (positiva para moverse hacia abajo).

var screen_size # Tamaño de la ventana del juego.
var velocity = Vector2.ZERO # Vector de movimiento del jugador.
var is_on_floor = true # Variable para saber si el personaje está en el suelo.

@export var fireball_scene: PackedScene # Escena de la bola de fuego


func _ready():
	screen_size = get_viewport_rect().size
	

func _process(delta):
	# Reiniciar la velocidad horizontal en cada frame
	velocity.x = 0 

	# Movimiento a la derecha
	if Input.is_action_pressed("caminar_derecha"):
		velocity.x += speed
		$AnimatedSprite2D.flip_h = false # No voltear cuando se mueve a la derecha.
		$AnimatedSprite2D.play("caminar")

	# Movimiento a la izquierda
	elif Input.is_action_pressed("caminar_izquierda"):
		velocity.x -= speed
		$AnimatedSprite2D.flip_h = true # Voltear cuando se mueve a la izquierda.
		$AnimatedSprite2D.play("caminar")

	# Acciones adicionales (protegerse, atacar, comer, dormir)
	elif Input.is_action_just_pressed("protegerse"):
		$AnimatedSprite2D.play("proteccion")
	
	elif Input.is_action_just_pressed("ataque"):
		$AnimatedSprite2D.play("atacar")
		
		_disparar_bola_de_fuego() # Llamar a la función para disparar la bola de fuego
	
	elif Input.is_action_just_pressed("alimentacion"):
		$AnimatedSprite2D.play("comer")
	
	elif Input.is_action_just_pressed("mimir"):
		$AnimatedSprite2D.play("dormir")
	
	# Manejar el salto
	if Input.is_action_just_pressed("saltar") and is_on_floor:
		velocity.y = jump_force # Aplicar la fuerza de salto.
		is_on_floor = false # El personaje ya no está en el suelo
	
	# Aplicar la gravedad
	if not is_on_floor:
		velocity.y += gravedad * delta

	# Mover al personaje
	position += velocity * delta

	# Limitar la posición del personaje dentro de la pantalla
	position = position.clamp(Vector2.ZERO, screen_size)

	# Limitar la posición vertical para que no salga de la pantalla
	if position.y >= screen_size.y:
		position.y = screen_size.y
		velocity.y = 0 # Resetear la velocidad vertical al tocar el suelo
		is_on_floor = true # El personaje está en el suelo

func _disparar_bola_de_fuego():
	var fireball_instance = fireball_scene.instantiate()
	
	# Determinar la posición de inicio de la bola de fuego
	fireball_instance.position = position + Vector2(-357, -105) if not $AnimatedSprite2D.flip_h else position + Vector2(-357, -105)
	
	# Configurar la velocidad de la bola de fuego
	if $AnimatedSprite2D.flip_h:
		fireball_instance.velocity = Vector2.LEFT * 600
		fireball_instance.setup("left")

	else:
		fireball_instance.velocity = Vector2.RIGHT * 600
		fireball_instance.setup("right")


	get_parent().add_child(fireball_instance)
