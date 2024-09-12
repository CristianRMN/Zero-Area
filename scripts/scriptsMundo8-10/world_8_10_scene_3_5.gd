extends Node2D

#jugador
@onready var player = $Player 
@onready var life = $vidaTerapagos/CanvasLayer/ProgressBar
@onready var animPlayer = $Player/AnimationPlayer
var initial_position = Vector2() 

#mariposas
@onready var mariposaAnim1 = $mariposa/AnimationPlayer

#sierra
@onready var sierraIzquierda = $sierraALaIzquierda
@onready var sierraIzquierdaAnim = $sierraALaIzquierda/AnimationPlayer

#comida
@onready var señalKnaranja = $"naranjaRecuperaVida/señalComerK"
@onready var señalXnaranja = $"naranjaRecuperaVida/señalComerX"
@onready var señalKManzana = $manzana_recupera_vida/PulsaK
@onready var señalxManzana = $manzana_recupera_vida/PulsaX

#enemigos
@onready var hipopotamo1 = $hipopotamo
@onready var mofeta1ContactoSinPedo = $enemigoMofeta
@onready var mofeta1ContactoConPedo = $enemigoMofeta/areaPedo
@onready var araña1 = $"EnemigoAraña"
@onready var serpiente1 = $enemigoSerpiente
@onready var mono1 = $enemigoMono
@onready var puerco1 = $enemigoPuerco
@onready var abeja1 = $enemigoAbeja

#ventiladores
@onready var ventilador1 = $ventiladoresMortales
@onready var ventilador1Anim = $ventiladoresMortales/AnimationPlayer

#bolaPinchos
@onready var bolaPinchos1 = $bolaPinchoPecharuntVertical
@onready var bolaPinchos2 = $bolaPinchoPecharuntVertical2

#sierraTrampaMortal
@onready var sierraTrampa = $sierraTrampaMortal

func _ready():
#posicion del jugador
	initial_position = player.global_position
	if Global.player_position != Vector2():
		player.global_position = Global.player_position
		Global.player_position = Vector2()

#conexiones mariposa
	mariposaAnim1.play("volandoArriba")

#conexion sierra
	sierraIzquierda.connect("body_entered", Callable(self, "_on_sierra_izquierda_on_body_entered"))

#conexiones enemigos
	hipopotamo1.connect("body_entered", Callable(self, "on_hipopotamo_on_body_entered"))
	araña1.connect("body_entered", Callable(self, "_on_enemigo_araña_on_body_entered"))
	mofeta1ContactoSinPedo.connect("body_entered", Callable(self, "on_mofeta_sin_pedo_on_body_entered"))
	mofeta1ContactoConPedo.connect("body_entered", Callable(self, "on_mofeta_con_pedo_on_body_entered"))
	serpiente1.connect("body_entered", Callable(self, "_on_serpiente_on_body_entered"))
	mono1.connect("body_entered", Callable(self, "_on_enemigo_mono_on_body_entered"))
	puerco1.connect("body_entered", Callable(self, "on_puerco_on_body_entered"))
	abeja1.connect("body_entered", Callable(self, "on_abeja_on_body_entered"))
	
#conexion ventilador
	ventilador1.connect("body_entered", Callable(self, "_on_ventilador_on_body_entered"))

#conexion bola pinchos
	bolaPinchos1.connect("body_entered", Callable(self, "on_bola_pincho_on_body_entered"))
	bolaPinchos2.connect("body_entered", Callable(self, "on_bola_pincho_on_body_entered"))

#conexion sierra trampa mortal
	sierraTrampa.connect("body_entered", Callable(self, "on_sierra_mortal_on_body_entered"))



func _process(delta):
#llamamos al respawn del jugador
	if player.global_position.y > 600: 
		respawn_player()

	if Input.is_action_just_pressed("alimentacion"):
		if is_instance_valid(señalKnaranja) and señalKnaranja.visible:
			life.heal(18)
			señalKnaranja.visible = false  
		elif is_instance_valid(señalXnaranja) and señalXnaranja.visible:
			life.heal(18)
			señalXnaranja.visible = false 

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


#funciones de bolas de pinchos y ventiladores
func on_bola_pincho_on_body_entered(body):
	if body.name == "Player":
		life.damage(30)


#funcion sierra
func _on_sierra_izquierda_on_body_entered(body):
	if body.name == "Player":
		if sierraIzquierdaAnim.is_playing():
			life.damage(30)

#funcion ventilador
func _on_ventilador_on_body_entered(body):
	if body.name == "Player":
		if ventilador1Anim.is_playing():
			life.damage(100)

#funciones enemigos
func on_hipopotamo_on_body_entered(body):
	if body.name == "Player":
		life.damage(30)


func _on_enemigo_araña_on_body_entered(body):
	if body.name == "Player":
		life.damage(8)


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

func on_abeja_on_body_entered(body):
	if body.name == "Player":
		life.damage(10)

func on_sierra_mortal_on_body_entered(body):
	if body.name == "Player":
		life.damage(3000)
