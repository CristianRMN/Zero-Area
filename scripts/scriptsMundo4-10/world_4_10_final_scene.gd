extends Node2D

@onready var player = $Player 
@onready var life = $vidaTerapagos/ProgressBar
@onready var animPlayer = $Player/AnimationPlayer

@onready var bloqueGris = $bloqueCaidaGris/areaMuerte

@onready var bolaPincho = $bolaPinchosHorizontal


@onready var puerco = $enemigoPuerco
@onready var serpiente = $enemigoSerpiente

@onready var bloqueAmarillo = $bloqueAmarilloCaidaRapida/zonaMuerte


@onready var señalKPlatano = $platano_recupera_vida/BananaKeyboardK
@onready var señalxPlatano = $platano_recupera_vida/BananaKeyboardX

@onready var señalKnaranja = $"naranjaRecuperaVida/señalComerK"
@onready var señalXnaranja = $"naranjaRecuperaVida/señalComerX"

@onready var aplastamientoAreaAmarillo = $areaAplastar
@onready var aplastamientoGris = $areaGris





@onready var mono1 = $enemigoMono

var inside_area_amarillo = false
var inside_area_bloque_amarillo = false

var inside_area_gris = false
var inside_area_bloque_gris = false


var up = -10

var is_near_escalera = false

var initial_position = Vector2()  # Variable para almacenar la posición inicial

func _ready():
	# Guardar la posición inicial del jugador
	initial_position = player.global_position
	puerco.connect("body_entered", Callable(self, "on_puerco_on_body_entered"))
	serpiente.connect("body_entered", Callable(self, "_on_serpiente_on_body_entered"))
	
	bloqueAmarillo.connect("body_entered", Callable(self, "_on_bloque_Caida_Amarillo_on_body_entered"))
	bloqueAmarillo.connect("body_exited", Callable(self, "_on_bloque_Caida_Amarillo_on_body_exited"))
	
	aplastamientoAreaAmarillo.connect("body_entered", Callable(self, "_on_area_Amarillo_on_body_entered"))
	aplastamientoAreaAmarillo.connect("body_exited", Callable(self, "_on_area_Amarillo_on_body_exited"))
	
	bloqueGris.connect("body_entered", Callable(self, "_on_bloque_gris_on_body_entered"))
	bloqueGris.connect("body_exited", Callable(self, "_on_bloque_gris_on_body_exited"))
	
	aplastamientoGris.connect("body_entered", Callable(self, "_on_area_gris_on_body_entered"))
	aplastamientoGris.connect("body_exited", Callable(self, "_on_area_gris_on_body_exited"))
	
	mono1.connect("body_entered", Callable(self, "on_mono_on_body_entered"))
	
	bolaPincho.connect("body_entered", Callable(self, "on_bola_pincho_on_body_entered"))



	# Restaurar la posición del jugador si se ha almacenado una posición
	if Global.player_position != Vector2():
		player.global_position = Global.player_position
		# Resetea la posición para que no interfiera con futuros cambios de escena
		Global.player_position = Vector2()

func _physics_process(delta):
	# Verificar si el jugador ha caído por debajo de un umbral
	if player.global_position.y > 500: 
		respawn_player()
		
	if Input.is_action_just_pressed("alimentacion"):
		if is_instance_valid(señalKnaranja) and señalKnaranja.visible:
			life.heal(20)
			señalKnaranja.visible = false  
		elif is_instance_valid(señalXnaranja) and señalXnaranja.visible:
			life.heal(20)
			señalXnaranja.visible = false 
		
	if Input.is_action_just_pressed("alimentacion"):
		if is_instance_valid(señalKPlatano) and señalKPlatano.visible:
			life.heal(18)
			señalKPlatano.visible = false  
		elif is_instance_valid(señalxPlatano) and señalxPlatano.visible:
			life.heal(18)
			señalxPlatano.visible = false 
			
	if inside_area_amarillo and inside_area_bloque_amarillo:
		animPlayer.play("aplastado")
		life.damage(50)
		inside_area_bloque_amarillo = false
		
	if inside_area_gris and inside_area_bloque_gris:
		animPlayer.play("aplastado")
		life.damage(100)
		inside_area_bloque_gris = false


func respawn_player():
	# Restaurar la posición del jugador a la posición inicial
	player.global_position = initial_position
	life.damage(10)
	
func on_puerco_on_body_entered(body):
	if body.name == "Player":
		life.damage(20)
	


func _on_serpiente_on_body_entered(body):
	if body.name == "Player":
		life.damage(15)
		


func _on_bloque_Caida_Amarillo_on_body_entered(body):
	if body.name == "Player":
		inside_area_bloque_amarillo = true
		
func _on_bloque_Caida_Amarillo_on_body_exited(body):
	if body.name == "Player":
		inside_area_bloque_amarillo = false
		
func _on_area_Amarillo_on_body_entered(body):
	if body.name == "Player":
		inside_area_amarillo = true
		
func _on_bloque_area_amarillo_on_body_exited(body):
	if body.name == "Player":
		inside_area_amarillo = false

func _on_bloque_gris_on_body_entered(body):
	if body.name == "Player":
		inside_area_bloque_gris = true
		
func _on_bloque_gris_on_body_exited(body):
	if body.name == "Player":
		inside_area_bloque_gris = false
		
func _on_area_gris_on_body_entered(body):
	if body.name == "Player":
		inside_area_gris = true
		
func _on_area_gris_on_body_exited(body):
	if body.name == "Player":
		inside_area_gris = false
		


func on_mono_on_body_entered(body):
	if body.name == "Player":
		life.damage(15)
		
func on_bola_pincho_on_body_entered(body):
	if body.name == "Player":
		life.damage(30)

