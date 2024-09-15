extends Node2D


#jugador
@onready var player = $Player 
@onready var life = $vidaTerapagos/CanvasLayer/ProgressBar
@onready var animPlayer = $Player/AnimationPlayer
var initial_position = Vector2()

#comida
@onready var señalKnaranja = $"naranjaRecuperaVida/señalComerK"
@onready var señalXnaranja = $"naranjaRecuperaVida/señalComerX"
@onready var señalKPlatano = $platano_recupera_vida/BananaKeyboardK
@onready var señalxPlatano = $platano_recupera_vida/BananaKeyboardX

#zona de las estacas
@onready var estacas = $areaEstacas

#enemigos
@onready var hipopotamo1 = $hipopotamo
@onready var abeja1 = $enemigoAbeja
@onready var abeja2 = $enemigoAbeja2
@onready var mofeta1ContactoSinPedo = $enemigoMofeta
@onready var mofeta1ContactoConPedo = $enemigoMofeta/areaPedo
@onready var serpiente1 = $enemigoSerpiente
@onready var serpiente2 = $enemigoSerpiente2
@onready var mono1 = $enemigoMono
@onready var puerco1 = $enemigoPuerco


#temporizador veneno abeja
@onready var timer = Timer.new()
var wait_time = 5
var poison = false
 
#sierraTrampaMortal
@onready var sierraTrampa = $sierraTrampaMortal

#bolaPinchos
@onready var bolaPinchos1 = $bolaPinchoPecharuntVertical
@onready var bolaPinchos2 = $bolaPinchoPecharuntVertical2
@onready var bolaPinchos3 = $bolaPinchoPecharuntVertical3
@onready var bolaPinchos4 = $bolaPinchoPecharuntVertical4
@onready var bolaPinchos5 = $bolaPinchoPecharuntVertical5
@onready var bolaPinchos6 = $bolaPinchoPecharuntVertical6

func _ready():
#posicion del jugador
	initial_position = player.global_position
	if Global.player_position != Vector2():
		player.global_position = Global.player_position
		Global.player_position = Vector2()

#conexion estacas
	estacas.connect("body_entered", Callable(self, "_on_area_estacas_on_body_entered"))

#inicio temporizador
	timer.wait_time = wait_time
	timer.one_shot = true
	add_child(timer)

#conexiones enemigos
	hipopotamo1.connect("body_entered", Callable(self, "on_hipopotamo_on_body_entered"))
	abeja1.connect("body_entered", Callable(self, "on_abeja_on_body_entered"))
	abeja2.connect("body_entered", Callable(self, "on_abeja_on_body_entered"))
	mofeta1ContactoSinPedo.connect("body_entered", Callable(self, "on_mofeta_sin_pedo_on_body_entered"))
	mofeta1ContactoConPedo.connect("body_entered", Callable(self, "on_mofeta_con_pedo_on_body_entered"))
	serpiente1.connect("body_entered", Callable(self, "_on_serpiente_on_body_entered"))
	serpiente2.connect("body_entered", Callable(self, "_on_serpiente_on_body_entered"))
	mono1.connect("body_entered", Callable(self, "_on_enemigo_mono_on_body_entered"))
	puerco1.connect("body_entered", Callable(self, "on_puerco_on_body_entered"))

#conexion sierraMortal
	sierraTrampa.connect("body_entered", Callable(self, "on_sierra_mortal_on_body_entered"))

#conexion bola pinchos
	bolaPinchos1.connect("body_entered", Callable(self, "on_bola_pincho_on_body_entered"))
	bolaPinchos2.connect("body_entered", Callable(self, "on_bola_pincho_on_body_entered"))
	bolaPinchos3.connect("body_entered", Callable(self, "on_bola_pincho_on_body_entered"))
	bolaPinchos4.connect("body_entered", Callable(self, "on_bola_pincho_on_body_entered"))
	bolaPinchos5.connect("body_entered", Callable(self, "on_bola_pincho_on_body_entered"))
	bolaPinchos6.connect("body_entered", Callable(self, "on_bola_pincho_on_body_entered"))

func _process(delta):
#llamamos al respawn del jugador
	if player.global_position.y > 600: 
		respawn_player()

	hitBee()
	if poison:
		life.damage(1)
		

#funcion de comida del jugador
	if Input.is_action_just_pressed("alimentacion"):
		if is_instance_valid(señalKnaranja) and señalKnaranja.visible:
			life.heal(18)
			señalKnaranja.visible = false  
		elif is_instance_valid(señalXnaranja) and señalXnaranja.visible:
			life.heal(18)
			señalXnaranja.visible = false 

	if Input.is_action_just_pressed("alimentacion"):
		if is_instance_valid(señalKPlatano) and señalKPlatano.visible:
			life.heal(18)
			señalKPlatano.visible = false  
		elif is_instance_valid(señalxPlatano) and señalxPlatano.visible:
			life.heal(18)
			señalxPlatano.visible = false 


#funcion de respawn del jugador
func respawn_player():
	# Restaurar la posición del jugador a la posición inicial
	player.global_position = initial_position
	life.damage(10)

#funcion de estacas
func _on_area_estacas_on_body_entered(body):
	if body.name == "Player":
		life.damage(10)

#funciones enemigos
func on_hipopotamo_on_body_entered(body):
	if body.name == "Player":
		life.damage(30)

func on_abeja_on_body_entered(body):
	if body.name == "Player":
		timer.start()

func hitBee():
	if timer.is_stopped():
		poison = false
	
	else:
		poison = true

func on_mofeta_sin_pedo_on_body_entered(body):
	if body.name == "Player":
		life.damage(5)

func on_mofeta_con_pedo_on_body_entered(body):
	if body.name == "Player":
		life.damage(25)

func _on_serpiente_on_body_entered(body):
	if body.name == "Player":
		life.damage(15)


func _on_enemigo_mono_on_body_entered(body):
	if body.name == "Player":
		life.damage(15)

func on_puerco_on_body_entered(body):
	if body.name == "Player":
		life.damage(20)

func on_sierra_mortal_on_body_entered(body):
	if body.name == "Player":
		life.damage(3000)


#funciones de bolas de pinchos
func on_bola_pincho_on_body_entered(body):
	if body.name == "Player":
		life.damage(30)
