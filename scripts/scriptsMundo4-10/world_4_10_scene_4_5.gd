extends Node2D

@onready var player = $Player 
@onready var life = $vidaTerapagos/ProgressBar
@onready var animPlayer = $Player/AnimationPlayer

@onready var bolaPincho = $bolaPinchoPecharuntVertical


@onready var puerco = $enemigoPuerco
@onready var puerco2 = $enemigoPuerco2
@onready var serpiente = $enemigoSerpiente

@onready var bloqueAmarillo = $bloqueAmarilloCaidaRapida/zonaMuerte


@onready var señalKManzana = $manzana_recupera_vida/PulsaK
@onready var señalxManzana = $manzana_recupera_vida/PulsaX

@onready var señalKnaranja = $"naranjaRecuperaVida/señalComerK"
@onready var señalXnaranja = $"naranjaRecuperaVida/señalComerX"
@onready var señalKnaranja2 = $"naranjaRecuperaVida2/señalComerK"
@onready var señalXnaranja2 = $"naranjaRecuperaVida2/señalComerX"


@onready var araña1 = $"EnemigoAraña"
@onready var mono1 = $enemigoMono




var up = -10

var is_near_escalera = false

var initial_position = Vector2()  # Variable para almacenar la posición inicial

func _ready():
	# Guardar la posición inicial del jugador
	initial_position = player.global_position
	puerco.connect("body_entered", Callable(self, "on_puerco_on_body_entered"))
	puerco2.connect("body_entered", Callable(self, "on_puerco_on_body_entered"))
	serpiente.connect("body_entered", Callable(self, "_on_serpiente_on_body_entered"))
	
	bloqueAmarillo.connect("body_entered", Callable(self, "_on_bloque_Caida_Amarillo_on_body_entered"))
	araña1.connect("body_entered", Callable(self, "_on_enemigo_araña_on_body_entered"))
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
			
	if Input.is_action_just_pressed("alimentacion"):
		if is_instance_valid(señalKnaranja2) and señalKnaranja2.visible:
			life.heal(18)
			señalKnaranja2.visible = false  
		elif is_instance_valid(señalXnaranja2) and señalXnaranja2.visible:
			life.heal(18)
			señalXnaranja2.visible = false 

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
		animPlayer.play("aplastado")
		life.damage(50)
		
		
func _on_enemigo_araña_on_body_entered(body):
	if body.name == "Player":
		life.damage(8)
		
func on_mono_on_body_entered(body):
	if body.name == "Player":
		life.damage(15)
		
func on_bola_pincho_on_body_entered(body):
	if body.name == "Player":
		life.damage(30)

