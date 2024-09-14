extends Node2D

#jugador
@onready var player = $Player 
@onready var life = $vidaTerapagos/CanvasLayer/ProgressBar
@onready var animPlayer = $Player/AnimationPlayer
var initial_position = Vector2() 

#comida
@onready var señalKManzana = $manzana_recupera_vida/PulsaK
@onready var señalxManzana = $manzana_recupera_vida/PulsaX

#enemigos
@onready var hipopotamo1 = $hipopotamo
@onready var abeja1 = $enemigoAbeja


#ventiladores
@onready var ventilador1 = $ventiladoresMortales
@onready var ventilador1Anim = $ventiladoresMortales/AnimationPlayer
@onready var ventilador2 = $ventiladoresMortales2
@onready var ventilador2Anim = $ventiladoresMortales2/AnimationPlayer


#bloquesAmarillos
@onready var bloqueAmarillo1 = $bloqueAmarilloCaidaRapida/zonaMuerte
@onready var bloqueAmarillo2 = $bloqueAmarilloCaidaRapida2/zonaMuerte
@onready var bloqueAmarillo3 = $bloqueAmarilloCaidaRapida3/zonaMuerte


#colision de suelo con el bloque amarillo
@onready var areaSueloBloqueAmarillo = $colisionAreaSueloBloqueAmarillo

#bloquesGrises
@onready var bloqueGris1 = $bloqueCaidaGris/areaMuerte
@onready var bloqueGris2 = $bloqueCaidaGris2/areaMuerte

#colision de suelo con el bloque gris
@onready var areaSueloBloqueGris = $colisionAreaSueloBloqueGris

#boolenas para verificar si el personaje es o no es aplastado por los bloques
var insideZonaColisionSueloAmarillo = false
var insideZonaColisionBloqueAmarillo = false
var insideZonaColisionSueloGris = false
var insideZonaColisionBloqueGris = false

#temporizador veneno abeja
@onready var timer = Timer.new()
var wait_time = 5
var poison = false


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

#conexion ventilador
	ventilador1.connect("body_entered", Callable(self, "_on_ventilador_on_body_entered"))
	ventilador2.connect("body_entered", Callable(self, "_on_ventilador_on_body_entered"))

#conexion bloques
	bloqueAmarillo1.connect("body_entered", Callable(self, "on_bloque_amarillo_on_body_entered"))
	bloqueAmarillo1.connect("body_exited", Callable(self, "on_bloque_amarillo_on_body_exited"))
	bloqueAmarillo2.connect("body_entered", Callable(self, "on_bloque_amarillo_on_body_entered"))
	bloqueAmarillo2.connect("body_exited", Callable(self, "on_bloque_amarillo_on_body_exited"))
	bloqueAmarillo3.connect("body_entered", Callable(self, "on_bloque_amarillo_on_body_entered"))
	bloqueAmarillo3.connect("body_exited", Callable(self, "on_bloque_amarillo_on_body_exited"))

	areaSueloBloqueAmarillo.connect("body_entered", Callable(self, "on_suelo_amarillo_on_body_entered"))
	areaSueloBloqueAmarillo.connect("body_exited", Callable(self, "on_suelo_amarillo_on_body_exited"))

	bloqueGris1.connect("body_entered", Callable(self, "on_bloque_gris_on_body_entered"))
	bloqueGris1.connect("body_exited", Callable(self, "on_bloque_gris_on_body_exited"))
	bloqueGris2.connect("body_entered", Callable(self, "on_bloque_gris_on_body_entered"))
	bloqueGris2.connect("body_exited", Callable(self, "on_bloque_gris_on_body_exited"))

	areaSueloBloqueGris.connect("body_entered", Callable(self, "on_suelo_gris_on_body_entered"))
	areaSueloBloqueGris.connect("body_exited", Callable(self, "on_suelo_gris_on_body_exited"))


func _process(delta):
#llamamos al respawn del jugador
	if player.global_position.y > 600: 
		respawn_player()
	
	damageBloqueAmarillo()
	damageBloqueGris()
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

#funcion ventilador
func _on_ventilador_on_body_entered(body):
	if body.name == "Player":
		if ventilador1Anim.is_playing():
			life.damage(100)
		if ventilador2Anim.is_playing():
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

