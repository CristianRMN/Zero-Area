extends Node2D

#jugador
@onready var player = $Player 
@onready var life = $vidaTerapagos/CanvasLayer/ProgressBar
@onready var animPlayer = $Player/AnimationPlayer
var initial_position = Vector2() 

#comida
@onready var señalKnaranja = $"naranjaRecuperaVida/señalComerK"
@onready var señalXnaranja = $"naranjaRecuperaVida/señalComerX"

#mariposas
@onready var mariposa1Anim = $mariposa/AnimationPlayer
@onready var mariposa2Anim = $mariposa2/AnimationPlayer
@onready var mariposa3Anim = $mariposa3/AnimationPlayer
@onready var mariposa4Anim = $mariposa4/AnimationPlayer

#ventiladores y bloques amarillos
@onready var ventilador1 = $ventiladoresMortales
@onready var ventilador1Anim = $ventiladoresMortales/AnimationPlayer
@onready var bloqueAmarillo1 = $bloqueAmarilloCaidaRapida/zonaMuerte
@onready var bloqueAmarillo2 = $bloqueAmarilloCaidaRapida2/zonaMuerte
@onready var bloqueAmarillo3 = $bloqueAmarilloCaidaRapida3/zonaMuerte

#colision de suelo con el bloque amarillo
@onready var areaSueloBloqueAmarillo = $zonaColisionSueloBloqueAmarillo


#boolenas para verificar si el personaje es o no es aplastado por los bloques
var insideZonaColisionSueloAmarillo = false
var insideZonaColisionBloqueAmarillo = false

#enemigos
@onready var mofeta1ContactoSinPedo = $enemigoMofeta
@onready var mofeta1ContactoConPedo = $enemigoMofeta/areaPedo
@onready var hipopotamo1 = $hipopotamo
@onready var hipopotamo2 = $hipopotamo2
@onready var puerco1 = $enemigoPuerco
@onready var serpiente1 = $enemigoSerpiente



func _ready():
	mariposa1Anim.play("volandoArriba")
	mariposa2Anim.play("volandoArriba")
	mariposa3Anim.play("volandoArriba")
	mariposa4Anim.play("volandoAbajo")

#conexion ventilador
	ventilador1.connect("body_entered", Callable(self, "_on_ventilador_on_body_entered"))

#conexiones bloque
	bloqueAmarillo1.connect("body_entered", Callable(self, "on_bloque_amarillo_on_body_entered"))
	bloqueAmarillo1.connect("body_exited", Callable(self, "on_bloque_amarillo_on_body_exited"))
	bloqueAmarillo2.connect("body_entered", Callable(self, "on_bloque_amarillo_on_body_entered"))
	bloqueAmarillo2.connect("body_exited", Callable(self, "on_bloque_amarillo_on_body_exited"))
	bloqueAmarillo3.connect("body_entered", Callable(self, "on_bloque_amarillo_on_body_entered"))
	bloqueAmarillo3.connect("body_exited", Callable(self, "on_bloque_amarillo_on_body_exited"))

	areaSueloBloqueAmarillo.connect("body_entered", Callable(self, "on_suelo_amarillo_on_body_entered"))
	areaSueloBloqueAmarillo.connect("body_exited", Callable(self, "on_suelo_amarillo_on_body_exited"))
	
	#enemigos
	puerco1.connect("body_entered", Callable(self, "on_puerco_on_body_entered"))
	hipopotamo1.connect("body_entered", Callable(self, "on_hipopotamo_on_body_entered"))
	mofeta1ContactoSinPedo.connect("body_entered", Callable(self, "on_mofeta_sin_pedo_on_body_entered"))
	mofeta1ContactoConPedo.connect("body_entered", Callable(self, "on_mofeta_con_pedo_on_body_entered"))
	serpiente1.connect("body_entered", Callable(self, "_on_serpiente_on_body_entered"))
	hipopotamo2.connect("body_entered", Callable(self, "on_hipopotamo_on_body_entered"))


func _process(delta):

#llamamos a la funcion de respawn del personaje
	if player.global_position.y > 500: 
		respawn_player()

	damageBloqueAmarillo()

#funcion de la naranja
	if Input.is_action_just_pressed("alimentacion"):
		if is_instance_valid(señalKnaranja) and señalKnaranja.visible:
			life.heal(18)
			señalKnaranja.visible = false  
		elif is_instance_valid(señalXnaranja) and señalXnaranja.visible:
			life.heal(18)
			señalXnaranja.visible = false 


#funcion de respawn
func respawn_player():
	# Restaurar la posición del jugador a la posición inicial
	player.global_position = initial_position
	life.damage(10)

func _on_ventilador_on_body_entered(body):
	if body.name == "Player":
		if ventilador1Anim.is_playing():
			life.damage(100)

#funciones de los bloques

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

#funciones enemigos
func on_hipopotamo_on_body_entered(body):
	if body.name == "Player":
		life.damage(30)

func on_mofeta_sin_pedo_on_body_entered(body):
	if body.name == "Player":
		life.damage(5)

func on_mofeta_con_pedo_on_body_entered(body):
	if body.name == "Player":
		life.damage(25)

func _on_serpiente_on_body_entered(body):
	if body.name == "Player":
		life.damage(15)

func on_puerco_on_body_entered(body):
	if body.name == "Player":
		life.damage(20)



