extends Node2D

#jugador
@onready var player = $Player 
@onready var life = $vidaTerapagos/CanvasLayer/ProgressBar
@onready var animPlayer = $Player/AnimationPlayer
var initial_position = Vector2() 

#temporizador veneno abeja
@onready var timer = Timer.new()
var wait_time = 5
var poison = false

#enemigos
@onready var abeja1 = $enemigoAbeja

func _ready():
#posicion del jugador
	initial_position = player.global_position
	if Global.player_position != Vector2():
		player.global_position = Global.player_position
		Global.player_position = Vector2()

#inicio temporizador
	timer.wait_time = wait_time
	timer.one_shot = true
	add_child(timer)

#conexiones enemigos
	abeja1.connect("body_entered", Callable(self, "on_abeja_on_body_entered"))



func _process(delta):
#llamamos al respawn del jugador
	if player.global_position.y > 600: 
		respawn_player()

	hitBee()
	if poison:
		life.damage(1)

#funcion de respawn del jugador
func respawn_player():
	# Restaurar la posición del jugador a la posición inicial
	player.global_position = initial_position
	life.damage(10)

#funcion timer abeja
func hitBee():
	if timer.is_stopped():
		poison = false
	
	else:
		poison = true

#funcion conexion abeja
func on_abeja_on_body_entered(body):
	if body.name == "Player":
		timer.start()
