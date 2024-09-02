extends Node2D

#retorno a la escena 1
var previus_scene_path = "res://scenes/world7-10/wolrd_7_10_scene_1_5.tscn"

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
@onready var mofeta1ContactoSinPedo = $enemigoMofeta
@onready var mofeta1ContactoConPedo = $enemigoMofeta/areaPedo
@onready var mofeta2ContactoSinPedo = $enemigoMofeta2
@onready var mofeta2ContactoConPedo = $enemigoMofeta2/areaPedo
@onready var murcielago1 = $murcielago
@onready var araña1 = $"EnemigoAraña"
@onready var hipopotamo1 = $hipopotamo
@onready var mono1 = $enemigoMono
@onready var serpiente1 = $enemigoSerpiente

#bloquesAmarillos
@onready var bloqueAmarillo1 = $bloqueAmarilloCaidaRapida/zonaMuerte
@onready var bloqueAmarillo2 = $bloqueAmarilloCaidaRapida2/zonaMuerte


#colision de suelo con el bloque amarillo
@onready var areaSueloBloqueAmarillo = $zonaColisionSueloBloqueAmarillo

#bloquesGrises
@onready var bloqueGris1 = $bloqueCaidaGris/areaMuerte
@onready var bloqueGris2 = $bloqueCaidaGris2/areaMuerte

#colision de suelo con el bloque gris
@onready var areaSueloBloqueGris = $zonaColisionSueloBloqueGris

#boolenas para verificar si el personaje es o no es aplastado por los bloques
var insideZonaColisionSueloAmarillo = false
var insideZonaColisionBloqueAmarillo = false
var insideZonaColisionSueloGris = false
var insideZonaColisionBloqueGris = false


#caminosTroll
@onready var caminosTroll = $caminosTroll

#camino bueno
@onready var caminoVerdadero = $caminoBueno



func _ready():
#respawn del jugador
#posicion del jugador
	initial_position = player.global_position
	if Global.player_position != Vector2():
		player.global_position = Global.player_position
		Global.player_position = Vector2()

#conexiones de los enemigos
	hipopotamo1.connect("body_entered", Callable(self, "on_hipopotamo_on_body_entered"))
	murcielago1.connect("body_entered", Callable(self, "on_murcielago_on_body_entered"))
	araña1.connect("body_entered", Callable(self, "_on_enemigo_araña_on_body_entered"))
	mofeta1ContactoSinPedo.connect("body_entered", Callable(self, "on_mofeta_sin_pedo_on_body_entered"))
	mofeta1ContactoConPedo.connect("body_entered", Callable(self, "on_mofeta_con_pedo_on_body_entered"))
	mofeta2ContactoSinPedo.connect("body_entered", Callable(self, "on_mofeta_sin_pedo_on_body_entered"))
	mofeta2ContactoConPedo.connect("body_entered", Callable(self, "on_mofeta_con_pedo_on_body_entered"))
	serpiente1.connect("body_entered", Callable(self, "_on_serpiente_on_body_entered"))
	mono1.connect("body_entered", Callable(self, "_on_enemigo_mono_on_body_entered"))

#conexiones caminos
	caminosTroll.connect("body_entered", Callable(self, "on_camino_troll_on_body_entered"))

#conexiones bloque
	bloqueAmarillo1.connect("body_entered", Callable(self, "on_bloque_amarillo_on_body_entered"))
	bloqueAmarillo2.connect("body_entered", Callable(self, "on_bloque_amarillo_on_body_entered"))
	bloqueAmarillo1.connect("body_exited", Callable(self, "on_bloque_amarillo_on_body_exited"))
	bloqueAmarillo2.connect("body_exited", Callable(self, "on_bloque_amarillo_on_body_exited"))

	areaSueloBloqueAmarillo.connect("body_entered", Callable(self, "on_suelo_amarillo_on_body_entered"))
	areaSueloBloqueAmarillo.connect("body_exited", Callable(self, "on_suelo_amarillo_on_body_exited"))

	bloqueGris1.connect("body_entered", Callable(self, "on_bloque_gris_on_body_entered"))
	bloqueGris2.connect("body_entered", Callable(self, "on_bloque_gris_on_body_entered"))
	bloqueGris1.connect("body_exited", Callable(self, "on_bloque_gris_on_body_exited"))
	bloqueGris2.connect("body_exited", Callable(self, "on_bloque_gris_on_body_exited"))

	areaSueloBloqueGris.connect("body_entered", Callable(self, "on_suelo_gris_on_body_entered"))
	areaSueloBloqueGris.connect("body_exited", Callable(self, "on_suelo_gris_on_body_exited"))


func _process(delta):
	if player.global_position.y > 500: 
		respawn_player()

	damageBloqueAmarillo()
	damageBloqueGris()

#alimentacion
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

#funciones de los enemigos
func on_hipopotamo_on_body_entered(body):
	if body.name == "Player":
		life.damage(30)

func on_murcielago_on_body_entered(body):
	if body.name == "Player":
		life.damage(12)

func _on_serpiente_on_body_entered(body):
	if body.name == "Player":
		life.damage(15)


func _on_enemigo_araña_on_body_entered(body):
	if body.name == "Player":
		life.damage(8)

func _on_enemigo_mono_on_body_entered(body):
	if body.name == "Player":
		life.damage(15)

func on_mofeta_sin_pedo_on_body_entered(body):
	if body.name == "Player":
		life.damage(5)

func on_mofeta_con_pedo_on_body_entered(body):
	if body.name == "Player":
		life.damage(25)

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


func on_camino_troll_on_body_entered(body):
	if body.name == "Player":
		returnScene1()

func returnScene1():
	get_tree().change_scene_to_file(previus_scene_path)
