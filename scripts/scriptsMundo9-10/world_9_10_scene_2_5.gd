extends Node2D

#jugador
@onready var player = $Player 
@onready var life = $vidaTerapagos/CanvasLayer/ProgressBar
@onready var animPlayer = $Player/AnimationPlayer
var initial_position = Vector2() 

#comida
@onready var señalKManzana = $manzana_recupera_vida/PulsaK
@onready var señalxManzana = $manzana_recupera_vida/PulsaX
@onready var señalKnaranja = $"naranjaRecuperaVida/señalComerK"
@onready var señalXnaranja = $"naranjaRecuperaVida/señalComerX"

#enemigos
@onready var hipopotamo1 = $hipopotamo
@onready var abeja1 = $enemigoAbeja
@onready var mofeta1ContactoSinPedo = $enemigoMofeta
@onready var mofeta1ContactoConPedo = $enemigoMofeta/areaPedo
@onready var serpiente1 = $enemigoSerpiente
@onready var puerco1 = $enemigoPuerco
@onready var araña1 = $"EnemigoAraña"

#temporizador veneno abeja
@onready var timer = Timer.new()
var wait_time = 5
var poison = false

#ventiladores
@onready var ventilador1 = $ventiladoresMortales
@onready var ventilador1Anim = $ventiladoresMortales/AnimationPlayer
@onready var ventilador2 = $ventiladoresMortales2
@onready var ventilador2Anim = $ventiladoresMortales2/AnimationPlayer

#bolaPinchos
@onready var bolaPinchos1 = $bolaPinchoPecharuntVertical

#sierraTrampaMortal
@onready var sierraTrampa = $sierraTrampaMortal
@onready var sierraTrampa2 = $sierraTrampaMortal2
@onready var sierraTrampa3 = $sierraTrampaMortal3
@onready var sierraTrampa4 = $sierraTrampaMortal4
@onready var sierraTrampa5 = $sierraTrampaMortal5

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
	hipopotamo1.connect("body_entered", Callable(self, "on_hipopotamo_on_body_entered"))
	abeja1.connect("body_entered", Callable(self, "on_abeja_on_body_entered"))
	mofeta1ContactoSinPedo.connect("body_entered", Callable(self, "on_mofeta_sin_pedo_on_body_entered"))
	mofeta1ContactoConPedo.connect("body_entered", Callable(self, "on_mofeta_con_pedo_on_body_entered"))
	serpiente1.connect("body_entered", Callable(self, "_on_serpiente_on_body_entered"))
	puerco1.connect("body_entered", Callable(self, "on_puerco_on_body_entered"))
	araña1.connect("body_entered", Callable(self, "_on_enemigo_araña_on_body_entered"))

	
#conexion ventilador
	ventilador1.connect("body_entered", Callable(self, "_on_ventilador_on_body_entered"))
	ventilador2.connect("body_entered", Callable(self, "_on_ventilador_on_body_entered"))

#conexion bola pinchos
	bolaPinchos1.connect("body_entered", Callable(self, "on_bola_pincho_on_body_entered"))

#conexion sierra trampa mortal
	sierraTrampa.connect("body_entered", Callable(self, "on_sierra_mortal_on_body_entered"))
	sierraTrampa2.connect("body_entered", Callable(self, "on_sierra_mortal_on_body_entered"))
	sierraTrampa3.connect("body_entered", Callable(self, "on_sierra_mortal_on_body_entered"))
	sierraTrampa4.connect("body_entered", Callable(self, "on_sierra_mortal_on_body_entered"))
	sierraTrampa5.connect("body_entered", Callable(self, "on_sierra_mortal_on_body_entered"))


func _process(delta):
#llamamos al respawn del jugador
	if player.global_position.y > 600: 
		respawn_player()

	hitBee()
	if poison:
		life.damage(1)
		

#funcion alimentacion
	if Input.is_action_just_pressed("alimentacion"):
		if is_instance_valid(señalKManzana) and señalKManzana.visible:
			life.heal(20)
			señalKManzana.visible = false  
		elif is_instance_valid(señalxManzana) and señalxManzana.visible:
			life.heal(20)
			señalxManzana.visible = false 

	if Input.is_action_just_pressed("alimentacion"):
		if is_instance_valid(señalKnaranja) and señalKnaranja.visible:
			life.heal(18)
			señalKnaranja.visible = false  
		elif is_instance_valid(señalXnaranja) and señalXnaranja.visible:
			life.heal(18)
			señalXnaranja.visible = false 

#funcion de respawn del jugador
func respawn_player():
	# Restaurar la posición del jugador a la posición inicial
	player.global_position = initial_position
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

func _on_enemigo_araña_on_body_entered(body):
	if body.name == "Player":
		life.damage(8)

#funciones de bolas de pinchos y ventiladores
func on_bola_pincho_on_body_entered(body):
	if body.name == "Player":
		life.damage(30)

#funcion ventilador
func _on_ventilador_on_body_entered(body):
	if body.name == "Player":
		if ventilador1Anim.is_playing():
			life.damage(100)
		if ventilador2Anim.is_playing():
			life.damage(100)

#funcion sierra mortal
func on_sierra_mortal_on_body_entered(body):
	if body.name == "Player":
		life.damage(3000)
