extends CharacterBody2D


@onready var spriteMariposa = $SpritesMariposas
@onready var animMariposas = $AnimationPlayer
var move_speed = 90
var move_distance = 80 
var direction = 1
var initial_position

var volandoRectoDerecha = false
var volandoRectoIzquierda = false
var volandoAbajo = false
var volandoArriba = false
var volandoDiagonalSuperiorDerecha = false
var volandoDiagonalInferiorDerecha = false
var volandoDiagonalSuperiorIzquierda = false
var volandoDiagonalInferiorIzquierda = false

func _ready():
	initial_position = position
	

func _process(delta):
	if animMariposas.current_animation == "volandoRectoDerecha":
		position.x += direction * move_speed * delta
		if position.x > initial_position.x + move_distance:
			direction = -1
		elif position.x < initial_position.x - move_distance:
			direction = 1




