extends Node2D

#jugador
@onready var player = $Player 
@onready var life = $vidaTerapagos/CanvasLayer/ProgressBar
@onready var animPlayer = $Player/AnimationPlayer
var initial_position = Vector2() 

#comida
@onready var señalKManzana = $manzana_recupera_vida/PulsaK
@onready var señalxManzana = $manzana_recupera_vida/PulsaX

#mariposas
@onready var mariposaAnim1 = $mariposa/AnimationPlayer

#enemigos
@onready var mono1 = $enemigoMono
@onready var puerco1 = $enemigoPuerco
@onready var murcielago1 = $murcielago


func _ready():

#posicion del jugador
	initial_position = player.global_position
	if Global.player_position != Vector2():
		player.global_position = Global.player_position
		Global.player_position = Vector2()

#conexion mariposas
	mariposaAnim1.play("volandoRectoIzquierda")

#conexiones enemigos
	mono1.connect("body_entered", Callable(self, "_on_enemigo_mono_on_body_entered"))
	puerco1.connect("body_entered", Callable(self, "on_puerco_on_body_entered"))
	murcielago1.connect("body_entered", Callable(self, "on_murcielago_on_body_entered"))



func _process(delta):
#llamamos al respawn del jugador
	if player.global_position.y > 600: 
		respawn_player()


#funcion alimentacion
	if Input.is_action_just_pressed("alimentacion"):
		if is_instance_valid(señalKManzana) and señalKManzana.visible:
			life.heal(20)
			señalKManzana.visible = false  
		elif is_instance_valid(señalxManzana) and señalxManzana.visible:
			life.heal(20)
			señalxManzana.visible = false 


#funcion de respawn del jugador
func respawn_player():
	# Restaurar la posición del jugador a la posición inicial
	player.global_position = initial_position
	life.damage(10)


#funciones enemigos
func _on_enemigo_mono_on_body_entered(body):
	if body.name == "Player":
		life.damage(15)

func on_puerco_on_body_entered(body):
	if body.name == "Player":
		life.damage(20)

func on_murcielago_on_body_entered(body):
	if body.name == "Player":
		life.damage(12)
