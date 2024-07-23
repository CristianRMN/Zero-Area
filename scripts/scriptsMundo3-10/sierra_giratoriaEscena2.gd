extends Area2D

var move_speed = 100 # Velocidad de movimiento de los pinchos.
var move_distance = 300 # Distancia total de movimiento.
var start_position = Vector2.ZERO # Posición inicial de la sierra.
@onready var anim = $AnimationPlayer
@onready var areaMuerte = $zonaPeligro

var is_active = false # Variable para controlar si los pinchos deben moverse.
var initial_position

func _ready():
	initial_position = position
	areaMuerte.connect("body_entered", Callable(self, "_on_body_entered"))

func _process(delta):
	if is_active:
		position.x += move_speed * delta
		anim.play("corte")
		# Desaparecer al alcanzar la distancia máxima
		if position.x > initial_position.x + move_distance:
			position.x = initial_position.x + move_distance
			is_active = false
			anim.stop()

func _on_body_entered(body):
	if body.name == "Player":
		is_active = true
