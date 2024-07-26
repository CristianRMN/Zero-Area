extends Area2D

var move_speed = 100 # Velocidad de movimiento de los pinchos.
var move_distance = 100 # Distancia total de movimiento.
var start_position = Vector2.ZERO # Posición inicial de los pinchos.
@onready var areaPeligro = $zonaPeligro

var is_active = false # Variable para controlar si los pinchos deben moverse.
var initial_position

func _ready():
	initial_position = position
	areaPeligro.connect("body_entered", Callable(self, "_on_body_entered"))

func _process(delta):
	if is_active:
		position.y += move_speed * delta

		# Desaparecer al alcanzar la distancia máxima
		if position.y > initial_position.y + move_distance:
			queue_free()

func _on_body_entered(body):
	if body.name == "Player":
		is_active = true
