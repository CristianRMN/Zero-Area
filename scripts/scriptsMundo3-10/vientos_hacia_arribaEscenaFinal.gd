extends Area2D

var move_speed = 160 # Velocidad de movimiento del viento.
var move_distance = 200 # Distancia total de movimiento.
var wait_time = 3 # Tiempo de espera en segundos.
var start_position = Vector2.ZERO # Posición inicial del viento.
@onready var anim = $AnimationPlayer
@onready var timer = Timer.new() # Crear un nuevo Timer
@onready var viento = $VientohaciaArriba1

var direction = 1
var initial_position

func _ready():
	initial_position = position
	start_position = position
	anim.play("haceViento")
	
	timer.wait_time = wait_time
	timer.one_shot = false
	timer.connect("timeout", Callable(self, "_on_timer_timeout"))
	add_child(timer)
	timer.start()


func _process(delta):
	if timer.is_stopped():
		viento.hide()
	else:
		position.y -= direction * move_speed * delta


func _on_timer_timeout():
	# Reiniciar el ciclo del viento
	position = start_position
	direction = 1
	timer.start(wait_time)
