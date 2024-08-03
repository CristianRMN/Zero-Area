extends Area2D

var move_speed = 60 # Velocidad de movimiento de los pinchos.
var move_distance = 125 # Distancia total de movimiento.
var start_position = Vector2.ZERO # Posición inicial de los pinchos.
@onready var anim = $AnimationPlayer
@onready var areaMuerte = $Area2D

var is_active = false # Variable para controlar si los pinchos deben moverse.
var initial_position

func _ready():
	initial_position = position
	areaMuerte.connect("body_entered", Callable(self, "_on_body_entered"))

func _process(delta):
	if is_active:
		anim.play("zass")
		position.y += move_speed * delta

		# Desaparecer al alcanzar la distancia máxima
		if position.y > initial_position.y + move_distance:
			move_speed = 0
			anim.stop()

func _on_body_entered(body):
	if body.name == "Player":
		is_active = true
