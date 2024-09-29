extends Node2D

#jugador
@onready var player = $Player 
@onready var life = $vidaTerapagos/CanvasLayer/ProgressBar
@onready var animPlayer = $Player/AnimationPlayer
var initial_position = Vector2() 

#mariposas
@onready var mariposa1Anim = $mariposa/AnimationPlayer
@onready var mariposa2Anim = $mariposa2/AnimationPlayer
@onready var mariposa3Anim = $mariposa3/AnimationPlayer
@onready var mariposa4Anim = $mariposa4/AnimationPlayer
@onready var mariposa5Anim = $mariposa5/AnimationPlayer

#comida
@onready var señalKManzana = $manzana_recupera_vida/PulsaK
@onready var señalxManzana = $manzana_recupera_vida/PulsaX
@onready var señalKManzana2 = $manzana_recupera_vida2/PulsaK
@onready var señalxManzana2 = $manzana_recupera_vida2/PulsaX
@onready var señalKnaranja = $"naranjaRecuperaVida/señalComerK"
@onready var señalXnaranja = $"naranjaRecuperaVida/señalComerX"

#bolaPinchos
@onready var bolasPinchos = [
$bolaPinchoPecharuntVertical,
$bolaPinchoPecharuntVertical2,
$bolaPinchoPecharuntVertical3
]


#enemigos
@onready var hipopotamo1 = $hipopotamo
@onready var abeja1 = $enemigoAbeja
@onready var mofeta1ContactoSinPedo = $enemigoMofeta
@onready var mofeta1ContactoConPedo = $enemigoMofeta/areaPedo
@onready var serpiente1 = $enemigoSerpiente
@onready var puerco1 = $enemigoPuerco
@onready var puerco2 = $enemigoPuerco
@onready var araña1 = $"EnemigoAraña"
@onready var murcielago1 = $murcielago

#estacas
@onready var areaEstacas = $areaEstacas

#temporizador veneno abeja
@onready var timer = Timer.new()
var wait_time = 5
var poison = false

#bloquesAmarillos
@onready var bloquesAmarillos = $bloqueAmarilloCaidaRapida/zonaMuerte


#colision de suelo con el bloque amarillo
@onready var areaSueloBloqueAmarillo = $zonaColisionBloqueAmarillo

#bloquesGrises
@onready var bloquesGris = [
$bloqueCaidaGris/areaMuerte,
$bloqueCaidaGris2/areaMuerte
]


#colision de suelo con el bloque gris
@onready var areaSueloBloqueGris = $zonaColisionBloqueGris

#boolenas para verificar si el personaje es o no es aplastado por los bloques
var insideZonaColisionSueloAmarillo = false
var insideZonaColisionBloqueAmarillo = false
var insideZonaColisionSueloGris = false
var insideZonaColisionBloqueGris = false

func _ready():

#posicion del jugador
	initial_position = player.global_position
	if Global.player_position != Vector2():
		player.global_position = Global.player_position
		Global.player_position = Vector2()

#conexiones mariposas
	mariposa1Anim.play("volandoArriba")
	mariposa2Anim.play("volandoArriba")
	mariposa3Anim.play("volandoArriba")
	mariposa4Anim.play("volandoArriba")
	mariposa5Anim.play("volandoArriba")

#inicio temporizador
	timer.wait_time = wait_time
	timer.one_shot = true
	add_child(timer)

#conexion bola pinchos
	for bolaPincho in bolasPinchos:
		bolaPincho.connect("body_entered", Callable(self, "on_bola_pincho_on_body_entered"))

#conexiones enemigos
	hipopotamo1.connect("body_entered", Callable(self, "on_hipopotamo_on_body_entered"))
	abeja1.connect("body_entered", Callable(self, "on_abeja_on_body_entered"))
	mofeta1ContactoSinPedo.connect("body_entered", Callable(self, "on_mofeta_sin_pedo_on_body_entered"))
	mofeta1ContactoConPedo.connect("body_entered", Callable(self, "on_mofeta_con_pedo_on_body_entered"))
	serpiente1.connect("body_entered", Callable(self, "_on_serpiente_on_body_entered"))
	puerco1.connect("body_entered", Callable(self, "on_puerco_on_body_entered"))
	puerco2.connect("body_entered", Callable(self, "on_puerco_on_body_entered"))
	araña1.connect("body_entered", Callable(self, "_on_enemigo_araña_on_body_entered"))
	murcielago1.connect("body_entered", Callable(self, "on_murcielago_on_body_entered"))

#conexion estacas
	areaEstacas.connect("body_entered", Callable(self, "on_area_estacas_on_body_entered"))


	bloquesAmarillos.connect("body_entered",Callable(self, "on_bloue_amarillo_on_body_entered"))
	bloquesAmarillos.connect("body_exited",Callable(self, "on_bloue_amarillo_on_body_exited"))

	areaSueloBloqueAmarillo.connect("body_entered", Callable(self, "on_suelo_amarillo_on_body_entered"))
	areaSueloBloqueAmarillo.connect("body_exited", Callable(self, "on_suelo_amarillo_on_body_exited"))

	for bloqueGris in bloquesGris:
		bloqueGris.connect("body_entered", Callable(self, "on_bloque_gris_on_body_entered"))
		bloqueGris.connect("body_exited", Callable(self, "on_bloque_gris_on_body_exited"))

	areaSueloBloqueGris.connect("body_entered", Callable(self, "on_suelo_gris_on_body_entered"))
	areaSueloBloqueGris.connect("body_exited", Callable(self, "on_suelo_gris_on_body_exited"))

func _process(delta):
#llamamos al respawn del jugador
	if player.global_position.y > 600: 
		respawn_player()

	hitBee()
	if poison:
		life.damage(1)

	damageBloqueAmarillo()
	damageBloqueGris()

#funcion alimentacion
	if Input.is_action_just_pressed("alimentacion"):
		if is_instance_valid(señalKManzana) and señalKManzana.visible:
			life.heal(20)
			señalKManzana.visible = false  
		elif is_instance_valid(señalxManzana) and señalxManzana.visible:
			life.heal(20)
			señalxManzana.visible = false 

	if Input.is_action_just_pressed("alimentacion"):
		if is_instance_valid(señalKManzana2) and señalKManzana2.visible:
			life.heal(20)
			señalKManzana2.visible = false  
		elif is_instance_valid(señalxManzana2) and señalxManzana2.visible:
			life.heal(20)
			señalxManzana2.visible = false 

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

#funciones de bolas de pinchos y ventiladores
func on_bola_pincho_on_body_entered(body):
	if body.name == "Player":
		life.damage(30)


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

func on_murcielago_on_body_entered(body):
	if body.name == "Player":
		life.damage(12)

#funcion estacas
func on_area_estacas_on_body_entered(body):
	if body.name == "Player":
		life.damage(10)

#funciones bloques

func on_bloque_amarillo_on_body_entered(body):
	if body.name == "Player":
		insideZonaColisionBloqueAmarillo = true

func on_bloque_amarillo_on_body_exited(body):
	if body.name == "Player":
		insideZonaColisionBloqueAmarillo = false


func on_suelo_amarillo_on_body_entered(body):
	if body.name == "Player":
		insideZonaColisionSueloAmarillo = true

func on_suelo_amarillo_on_body_exited(body):
	if body.name == "Player":
		insideZonaColisionSueloAmarillo = false

func damageBloqueAmarillo():
	if insideZonaColisionBloqueAmarillo and insideZonaColisionSueloAmarillo:
		animPlayer.play("aplastado")
		life.damage(50)
		insideZonaColisionSueloAmarillo = false
		insideZonaColisionBloqueAmarillo = false

func on_bloque_gris_on_body_entered(body):
	if body.name == "Player":
		insideZonaColisionBloqueGris = true

func on_bloque_gris_on_body_exited(body):
	if body.name == "Player":
		insideZonaColisionBloqueGris = false


func on_suelo_gris_on_body_entered(body):
	if body.name == "Player":
		insideZonaColisionSueloGris = true

func on_suelo_gris_on_body_exited(body):
	if body.name == "Player":
		insideZonaColisionSueloGris = false

func damageBloqueGris():
	if insideZonaColisionBloqueGris and insideZonaColisionSueloGris:
		animPlayer.play("aplastado")
		life.damage(100)
		insideZonaColisionSueloGris = false
		insideZonaColisionBloqueGris = false
