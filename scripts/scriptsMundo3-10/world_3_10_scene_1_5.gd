extends Node2D

@onready var player = $Player 
@onready var life = $vidaTerapagos/CanvasLayer/ProgressBar
@onready var anim = $Player/AnimationPlayer

@onready var araña1 = $"EnemigoAraña"
@onready var bloqueGris = $bloqueCaidaGris/areaMuerte

@onready var señalKPlatano = $platano_recupera_vida/BananaKeyboardK
@onready var señalxPlatano = $platano_recupera_vida/BananaKeyboardX

@onready var señalKManzana = $manzana_recupera_vida/PulsaK
@onready var señalxManzana = $manzana_recupera_vida/PulsaX

@onready var mono1 = $enemigoMono

@onready var bloqueAmarillo1 = $bloqueAmarilloCaidaRapida/zonaMuerte
@onready var bloqueAmarillo2 = $bloqueAmarilloCaidaRapida2/zonaMuerte
@onready var bloqueAmarillo3 = $bloqueAmarilloCaidaRapida3/zonaMuerte
@onready var bloqueAmarillo4 = $bloqueAmarilloCaidaRapida4/zonaMuerte




var up = -10
var is_near_escalera = false

var initial_position = Vector2()  # Variable para almacenar la posición inicial

func _ready():
	# Guardar la posición inicial del jugador
	initial_position = player.global_position
	
	araña1.connect("body_entered", Callable(self, "_on_enemigo_araña_on_body_entered"))
	mono1.connect("body_entered", Callable(self, "_on_enemigo_mono_on_body_entered"))
	bloqueGris.connect("body_entered", Callable(self, "_on_bloque_Caida_on_body_entered"))

	bloqueAmarillo1.connect("body_entered", Callable(self, "_on_bloque_Caida_Amarillo_on_body_entered"))
	bloqueAmarillo2.connect("body_entered", Callable(self, "_on_bloque_Caida_Amarillo_on_body_entered"))
	bloqueAmarillo3.connect("body_entered", Callable(self, "_on_bloque_Caida_Amarillo_on_body_entered"))
	bloqueAmarillo4.connect("body_entered", Callable(self, "_on_bloque_Caida_Amarillo_on_body_entered"))
	


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
		if is_instance_valid(señalKPlatano) and señalKPlatano.visible:
			life.heal(15)
			señalKPlatano.visible = false  
		elif is_instance_valid(señalxPlatano) and señalxPlatano.visible:
			life.heal(15)
			señalxPlatano.visible = false 



func respawn_player():
	# Restaurar la posición del jugador a la posición inicial
	player.global_position = initial_position
	life.damage(10)
	
func _on_enemigo_mono_on_body_entered(body):
	if body.name == "Player":
		life.damage(15)
		
func _on_enemigo_araña_on_body_entered(body):
	if body.name == "Player":
		life.damage(8)

func _on_bloque_Caida_Amarillo_on_body_entered(body):
	if body.name == "Player":
		anim.play("aplastado")
		life.damage(50)

func _on_bloque_Caida_on_body_entered(body):
	if body.name == "Player":
		anim.play("aplastado")
		life.damage(100)
		

