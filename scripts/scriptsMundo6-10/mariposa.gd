extends CharacterBody2D

@onready var spriteMariposa = $SpritesMariposas
@onready var animMariposas = $AnimationPlayer

var move_speed = 90
var move_distance = 100
var direction = 1
var directionIzquierda = -1
var initial_position: Vector2
var move_distance_diagonal = 80

func _ready():
	initial_position = position

func _process(delta):
	# Verifica la animación actual y ejecuta la función de movimiento correspondiente
	match animMariposas.current_animation:
		"volandoRectoDerecha":
			volandoRectoDerecha(delta)
		"volandoRectoIzquierda":
			volandoRectoIzquierda(delta)
		"volandoArriba":
			volandoArriba(delta)
		"volandoAbajo":
			volandoAbajo(delta)
		"volandoDiagonalSuperiorDerecha":
			volandoDiagonalSuperiorDerecha(delta)
		"volandoDiagonalSuperiorIzquierda":
			volandoDiagonalSuperiorIzquierda(delta)

func volandoRectoDerecha(delta):
	position.x += direction * move_speed * delta
	if position.x > initial_position.x + move_distance:
		spriteMariposa.flip_h = false
		direction = -1
	elif position.x < initial_position.x - move_distance:
		direction = 1
		spriteMariposa.flip_h = true

func volandoRectoIzquierda(delta):
	position.x += directionIzquierda * move_speed * delta
	if position.x > initial_position.x + move_distance:
		directionIzquierda = -1
		spriteMariposa.flip_h = false  
	elif position.x < initial_position.x - move_distance:
		directionIzquierda = 1
		spriteMariposa.flip_h = true 

func volandoArriba(delta):
	position.y += directionIzquierda * move_speed * delta
	if position.y < initial_position.y - move_distance:
		directionIzquierda = 1
	elif position.y > initial_position.y + move_distance:
		directionIzquierda = -1

func volandoAbajo(delta):
	position.y += direction * move_speed * delta
	if position.y > initial_position.y + move_distance:
		direction = -1
	elif position.y < initial_position.y - move_distance:
		direction = 1

func volandoDiagonalSuperiorDerecha(delta):
	position.y -= direction * move_speed * delta
	position.x += direction * move_speed * delta
	if direction == 1 and (position.y <= initial_position.y - move_distance_diagonal or position.x >= initial_position.x + move_distance_diagonal):
		spriteMariposa.flip_h = false  
		direction = -1
	elif direction == -1 and (position.y >= initial_position.y + move_distance_diagonal or position.x <= initial_position.x - move_distance_diagonal):
		spriteMariposa.flip_h = true  
		direction = 1

func volandoDiagonalSuperiorIzquierda(delta):
	position.y -= direction * move_speed * delta  
	position.x -= direction * move_speed * delta 
	if direction == 1 and (position.y <= initial_position.y - move_distance_diagonal or position.x <= initial_position.x - move_distance_diagonal):
		spriteMariposa.flip_h = true 
		direction = -1  
	elif direction == -1 and (position.y >= initial_position.y + move_distance_diagonal or position.x >= initial_position.x + move_distance_diagonal):
		spriteMariposa.flip_h = false 
		direction = 1  
