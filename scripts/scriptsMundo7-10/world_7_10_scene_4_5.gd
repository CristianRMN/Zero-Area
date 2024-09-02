extends Node2D

#retorno a la escena 1
var previus_scene_path = "res://scenes/world7-10/wolrd_7_10_scene_1_5.tscn"

#jugador
@onready var player = $Player 
@onready var life = $vidaTerapagos/CanvasLayer/ProgressBar
@onready var animPlayer = $Player/AnimationPlayer
var initial_position = Vector2() 

#mariposas
@onready var mariposa1 = $mariposa/AnimationPlayer
@onready var mariposa2 = $mariposa2/AnimationPlayer
@onready var mariposa3 = $mariposa3/AnimationPlayer

#bolaPinchos
@onready var bolaPinchos1 = $bolaPinchoPecharuntVertical
@onready var bolaPinchos2 = $bolaPinchoPecharuntVertical2

#ventiladores
@onready var ventilador1 = $ventiladoresMortales
@onready var ventilador1Anim = $ventiladoresMortales/AnimationPlayer
@onready var ventilador2 = $ventiladoresMortales2
@onready var ventilador2Anim = $ventiladoresMortales2/AnimationPlayer
@onready var ventilador3 = $ventiladoresMortales3
@onready var ventilador3Anim = $ventiladoresMortales3/AnimationPlayer
@onready var ventilador4 = $ventiladoresMortales4
@onready var ventilador4Anim = $ventiladoresMortales4/AnimationPlayer
@onready var ventilador5 = $ventiladoresMortales5
@onready var ventilador5Anim = $ventiladoresMortales5/AnimationPlayer
@onready var ventilador6 = $ventiladoresMortales6
@onready var ventilador6Anim = $ventiladoresMortales6/AnimationPlayer
@onready var ventilador7 = $ventiladoresMortales7
@onready var ventilador7Anim = $ventiladoresMortales7/AnimationPlayer
@onready var ventilador8 = $ventiladoresMortales8
@onready var ventilador8Anim = $ventiladoresMortales8/AnimationPlayer

#enemigos
@onready var hipopotamo1 = $hipopotamo
@onready var hipopotamo2 = $hipopotamo2
@onready var murcielago1 = $murcielago
@onready var puerco1 = $enemigoPuerco
@onready var puerco2 = $enemigoPuerco2

#comida
@onready var manzanaRecuperaTodaVidaSeñalK = $manzanaRecuperaTodaVida/pulsaK
@onready var manzanaRecuperaTodaVidaSeñalX = $manzanaRecuperaTodaVida/pulsaX

#caminosTroll
@onready var caminosTroll = $caminosTroll

#camino bueno
@onready var caminoVerdadero = $caminoBueno

func _ready():
#posicion del jugador
	initial_position = player.global_position
	if Global.player_position != Vector2():
		player.global_position = Global.player_position
		Global.player_position = Vector2()

#conexiones mariposa
	mariposa1.play("volandoArriba")
	mariposa2.play("volandoArriba")
	mariposa3.play("volandoArriba")

#conexiones enemigos
	hipopotamo1.connect("body_entered", Callable(self, "on_hipopotamo_on_body_entered"))
	hipopotamo2.connect("body_entered", Callable(self, "on_hipopotamo_on_body_entered"))
	puerco1.connect("body_entered", Callable(self, "on_puerco_on_body_entered"))
	puerco2.connect("body_entered", Callable(self, "on_puerco_on_body_entered"))
	murcielago1.connect("body_entered", Callable(self, "on_murcielago_on_body_entered"))

#conexiones quitan vida
	bolaPinchos1.connect("body_entered", Callable(self, "on_bola_pincho_on_body_entered"))
	bolaPinchos2.connect("body_entered", Callable(self, "on_bola_pincho_on_body_entered"))

	ventilador1.connect("body_entered", Callable(self, "_on_ventilador_on_body_entered"))
	ventilador2.connect("body_entered", Callable(self, "_on_ventilador_on_body_entered"))
	ventilador3.connect("body_entered", Callable(self, "_on_ventilador_on_body_entered"))
	ventilador4.connect("body_entered", Callable(self, "_on_ventilador_on_body_entered"))
	ventilador5.connect("body_entered", Callable(self, "_on_ventilador_on_body_entered"))
	ventilador6.connect("body_entered", Callable(self, "_on_ventilador_on_body_entered"))
	ventilador7.connect("body_entered", Callable(self, "_on_ventilador_on_body_entered"))
	ventilador8.connect("body_entered", Callable(self, "_on_ventilador_on_body_entered"))

#conexiones caminos
	caminosTroll.connect("body_entered", Callable(self, "on_camino_troll_on_body_entered"))

func _process(delta):
	if player.global_position.y > 500: 
		respawn_player()

	if Input.is_action_just_pressed("alimentacion"):
		if is_instance_valid(manzanaRecuperaTodaVidaSeñalK) and manzanaRecuperaTodaVidaSeñalK.visible:
			life.heal(3000)
			manzanaRecuperaTodaVidaSeñalK.visible = false  
		elif is_instance_valid(manzanaRecuperaTodaVidaSeñalX) and manzanaRecuperaTodaVidaSeñalX.visible:
			life.heal(3000)
			manzanaRecuperaTodaVidaSeñalX.visible = false 

#funcion de respawn del jugador
func respawn_player():
	# Restaurar la posición del jugador a la posición inicial
	player.global_position = initial_position
	life.damage(10)

#funciones de bolas de pinchos y ventiladores
func on_bola_pincho_on_body_entered(body):
	if body.name == "Player":
		life.damage(30)

func _on_ventilador_on_body_entered(body):
	if body.name == "Player":
		if ventilador1Anim.is_playing():
			life.damage(100)
		if ventilador2Anim.is_playing():
			life.damage(100)
		if ventilador3Anim.is_playing():
			life.damage(100)
		if ventilador4Anim.is_playing():
			life.damage(100)
		if ventilador5Anim.is_playing():
			life.damage(100)
		if ventilador6Anim.is_playing():
			life.damage(100)
		if ventilador7Anim.is_playing():
			life.damage(100)
		if ventilador8Anim.is_playing():
			life.damage(100)

#funciones enemigos
func on_hipopotamo_on_body_entered(body):
	if body.name == "Player":
		life.damage(30)

func on_murcielago_on_body_entered(body):
	if body.name == "Player":
		life.damage(12)


func on_puerco_on_body_entered(body):
	if body.name == "Player":
		life.damage(20)

#funcion del camino troll
func on_camino_troll_on_body_entered(body):
	if body.name == "Player":
		returnScene1()

func returnScene1():
	get_tree().change_scene_to_file(previus_scene_path)
