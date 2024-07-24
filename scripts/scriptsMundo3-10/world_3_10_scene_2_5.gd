extends Node2D

@onready var player = $Player 
@onready var life = $vidaTerapagos/ProgressBar
@onready var anim = $Player/AnimationPlayer

@onready var araña1 = $"EnemigoAraña"
@onready var bolaPinchoVertical = $bolaPinchoPecharuntVertical

@onready var sierra = $sierraGiratoria
@onready var sierraAnim = $sierraGiratoria/AnimationPlayer

@onready var señalKPlatano = $platano_recupera_vida/BananaKeyboardK
@onready var señalxPlatano = $platano_recupera_vida/BananaKeyboardX

@onready var señalKManzana = $manzana_recupera_vida/PulsaK
@onready var señalxManzana = $manzana_recupera_vida/PulsaX

@onready var señalKManzana2 = $manzana_recupera_vida2/PulsaK
@onready var señalxManzana2 = $manzana_recupera_vida2/PulsaX

@onready var enemigoMurcielago1 = $murcielago
@onready var enemigoMurcielago2 = $murcielago2
@onready var enemigoMurcielago3 = $murcielago3

@onready var mono1 = $enemigoMono

@onready var bloqueAmarillo1 = $bloqueAmarilloCaidaRapida/zonaMuerte
@onready var bloqueAmarillo2 = $bloqueAmarilloCaidaRapida2/zonaMuerte
@onready var bloqueAmarillo3 = $bloqueAmarilloCaidaRapida3/zonaMuerte

@onready var zonaPinchos1 = $"zonaPinchosMedianos1/areaDaño"
@onready var zonaPinchos2 = $"zonaPinchosMedianos2/areaDaño"

@onready var serpiente1 = $enemigoSerpiente
@onready var serpiente2 = $enemigoSerpiente2

@onready var bolaHorizontal = $bolapinchosPecharuntHorizontal

@onready var areaEstacas = $zonaEstacas


var up = -10
var is_near_escalera = false

var initial_position = Vector2()  # Variable para almacenar la posición inicial

func _ready():
	# Guardar la posición inicial del jugador
	initial_position = player.global_position
	
	araña1.connect("body_entered", Callable(self, "_on_enemigo_araña_on_body_entered"))
	mono1.connect("body_entered", Callable(self, "_on_enemigo_mono_on_body_entered"))
	bolaPinchoVertical.connect("body_entered", Callable(self, "_on_bola_pincho_vertical_on_body_entered"))
	
	sierra.connect("body_entered", Callable(self, "_on_sierra_on_body_entered"))

	bloqueAmarillo1.connect("body_entered", Callable(self, "_on_bloque_Caida_Amarillo_on_body_entered"))
	bloqueAmarillo2.connect("body_entered", Callable(self, "_on_bloque_Caida_Amarillo_on_body_entered"))
	bloqueAmarillo3.connect("body_entered", Callable(self, "_on_bloque_Caida_Amarillo_on_body_entered"))
	
	enemigoMurcielago1.connect("body_entered", Callable(self, "_on_enemigo_murcielago_on_body_entered"))
	enemigoMurcielago2.connect("body_entered", Callable(self, "_on_enemigo_murcielago_on_body_entered"))
	enemigoMurcielago3.connect("body_entered", Callable(self, "_on_enemigo_murcielago_on_body_entered"))
	
	zonaPinchos1.connect("body_entered", Callable(self, "_on_zona_pinchos_on_body_entered"))
	zonaPinchos2.connect("body_entered", Callable(self, "_on_zona_pinchos_on_body_entered"))

	serpiente1.connect("body_entered", Callable(self, "_on_enemigo_serpiente_on_body_entered"))
	serpiente2.connect("body_entered", Callable(self, "_on_enemigo_serpiente_on_body_entered"))

	bolaHorizontal.connect("body_entered", Callable(self, "_on_bola_horizontal_on_body_entered"))
	areaEstacas.connect("body_entered", Callable(self, "_on_area_estacas_on_body_entered"))

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
		if is_instance_valid(señalKManzana2) and señalKManzana2.visible:
			life.heal(20)
			señalKManzana2.visible = false  
		elif is_instance_valid(señalxManzana2) and señalxManzana2.visible:
			life.heal(20)
			señalxManzana2.visible = false 

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

func _on_bola_pincho_vertical_on_body_entered(body):
	if body.name == "Player":
		life.damage(30)
		

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
		
func _on_bola_horizontal_on_body_entered(body):
	if body.name == "Player":
		life.damage(30)
		
func _on_area_estacas_on_body_entered(body):
	if body.name == "Player":
		life.damage(10)

