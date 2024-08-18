extends Node2D

@onready var player = $Player 
@onready var life = $vidaTerapagos/CanvasLayer/ProgressBar
@onready var anim = $Player/AnimationPlayer
@onready var nuevaPosicionHacha = $Player/Marker2D3


@onready var araña1 = $"EnemigoAraña"


@onready var sierra = $sierraALaIzquierda
@onready var sierraAnim = $sierraALaIzquierda/AnimationPlayer

@onready var señalKPlatano = $platano_recupera_vida/BananaKeyboardK
@onready var señalxPlatano = $platano_recupera_vida/BananaKeyboardX

@onready var señalKManzana = $manzana_recupera_vida/PulsaK
@onready var señalxManzana = $manzana_recupera_vida/PulsaX


@onready var enemigoMurcielago1 = $murcielago


@onready var mono1 = $enemigoMono

@onready var bloqueAmarillo1 = $bloqueAmarilloCaidaRapida/zonaMuerte
@onready var bloqueGris = $bloqueCaidaGris/areaMuerte


@onready var zonaPinchos1 = $zonaPinchos1
@onready var zonaPinchos2 = $zonaPinchos2

@onready var serpiente1 = $enemigoSerpiente
@onready var serpiente2 = $enemigoSerpiente2
@onready var serpiente3 = $enemigoSerpiente3

@onready var armaHacha = $hacha
@onready var armaHachaAnim = $hacha/AnimationPlayer

@onready var arbolCaeArea = $arbolCaido/Area2D
@onready var arbolCaeAnim = $arbolCaido/AnimationPlayer
@onready var arbolCaeColisionShape1 = $arbolCaido/CollisionShape2D
@onready var arbolCaeColisionShape2 = $arbolCaido/CollisionShape2D2
@onready var arbolCaeSignoV = $arbolCaido/Area2D/corta


var axeZone = false
var haveTheAxe = false
var cutZone = false



var up = -10

var is_near_escalera = false

var initial_position = Vector2()  # Variable para almacenar la posición inicial

func _ready():
	# Guardar la posición inicial del jugador
	initial_position = Vector2(-510,245)
	
	araña1.connect("body_entered", Callable(self, "_on_enemigo_araña_on_body_entered"))
	mono1.connect("body_entered", Callable(self, "_on_enemigo_mono_on_body_entered"))

	
	sierra.connect("body_entered", Callable(self, "_on_sierra_on_body_entered"))

	bloqueAmarillo1.connect("body_entered", Callable(self, "_on_bloque_Caida_Amarillo_on_body_entered"))

	
	enemigoMurcielago1.connect("body_entered", Callable(self, "_on_enemigo_murcielago_on_body_entered"))

	
	zonaPinchos1.connect("body_entered", Callable(self, "_on_zona_pinchos_on_body_entered"))
	zonaPinchos2.connect("body_entered", Callable(self, "_on_zona_pinchos_on_body_entered"))

	serpiente1.connect("body_entered", Callable(self, "_on_enemigo_serpiente_on_body_entered"))
	serpiente2.connect("body_entered", Callable(self, "_on_enemigo_serpiente_on_body_entered"))
	serpiente3.connect("body_entered", Callable(self, "_on_enemigo_serpiente_on_body_entered"))

	bloqueGris.connect("body_entered", Callable(self, "_on_bloque_gris_on_body_entered"))

	armaHacha.connect("body_entered", Callable(self, "_on_hacha_on_body_entered"))
	armaHacha.connect("body_exited", Callable(self, "_on_hacha_on_body_exited"))
	
	arbolCaeArea.connect("body_entered", Callable(self, "_on_arbol_cae_on_body_entered"))
	arbolCaeArea.connect("body_exited", Callable(self, "_on_arbol_cae_on_body_exited"))
	




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
			
	if axeZone and Input.is_action_just_pressed("abrirLoQueSea"):
		haveTheAxe = true

	if haveTheAxe:
		armaHacha.global_position = nuevaPosicionHacha.global_position
		
	if haveTheAxe and cutZone and Input.is_action_just_pressed("abrirLoQueSea"):
		armaHachaAnim.play("cortar")
		arbolCaeAnim.play("arbolVaaaa")
		arbolCaeColisionShape1.disabled = true
		arbolCaeColisionShape2.disabled = false
		
	if arbolCaeColisionShape1.disabled:
		cutZone = false
		arbolCaeSignoV.hide()
		if armaHachaAnim.is_playing():
			armaHacha.visible = true
		else:
			armaHacha.visible = false



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

func _on_bloque_gris_on_body_entered(body):
	if body.name == "Player":
		anim.play("aplastado")
		life.damage(100)
		

func _on_sierra_on_body_entered(body):
	if body.name == "Player":
		if sierraAnim.is_playing():
			life.damage(30)
			

func _on_enemigo_murcielago_on_body_entered(body):
	if body.name == "Player":
		life.damage(12)
		
func _on_zona_pinchos_on_body_entered(body):
	if body.name == "Player":
		life.damage(30)
		
func _on_enemigo_serpiente_on_body_entered(body):
	if body.name == "Player":
		life.damage(15)
		
		
func _on_hacha_on_body_entered(body):
	if body.name == "Player":
		axeZone = true
		
func _on_hacha_on_body_exited(body):
	if body.name == "Player":
		axeZone = false
		
func _on_arbol_cae_on_body_entered(body):
	if body.name == "Player":
		cutZone = true
		
func _on_arbol_cae_on_body_exited(body):
	if body.name == "Player":
		cutZone = false




