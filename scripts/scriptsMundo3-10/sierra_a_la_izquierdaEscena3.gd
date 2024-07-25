extends Area2D

var move_speed = 100 # Velocidad de movimiento de la sierra.
var move_distance = 460 # Distancia total de movimiento.
var start_position = Vector2.ZERO # Posición inicial de la sierra.
@onready var anim = $AnimationPlayer
@onready var areaMuerte = $AreaPeligro
@onready var sprite = $Sierra1

var is_active = false # Variable para controlar si la sierra debe moverse.
var initial_position

func _ready():
	initial_position = position
	areaMuerte.connect("body_entered", Callable(self, "_on_body_entered"))
	sprite.flip_h = true

func _process(delta):
	if is_active:
		position.x -= move_speed * delta
		anim.play("corteAIzquierda")
		# Detener al alcanzar la distancia máxima a la izquierda
		if position.x < initial_position.x - move_distance:
			position.x = initial_position.x - move_distance
			is_active = false
			anim.stop()

func _on_body_entered(body):
	if body.name == "Player":
		is_active = true
