extends Area2D


var speed = 2  # Velocidad a la que se mueve el viento
var limit_screen = 750  # Límite de la pantalla para mover el viento hacia la derecha
var start_position = Vector2(-1000, -400)  # Posición inicial del viento fuera de la pantalla


func _process(delta):
	# Mover el nodo hacia la derecha
	position.x += speed * delta

	# Resetear la posición y reiniciar la animación cuando se alcanza el límite
	if position.x > limit_screen:
		position = start_position

