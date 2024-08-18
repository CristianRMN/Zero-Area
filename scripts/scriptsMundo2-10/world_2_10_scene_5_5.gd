extends Node2D

@onready var player = $Player 
@onready var life = $vidaTerapagos/CanvasLayer/ProgressBar
@onready var anim = $Player/AnimationPlayer

@onready var señalxManzana = $manzana_recupera_vida/PulsaX
@onready var señalKManzana = $manzana_recupera_vida/PulsaK

@onready var señalxPlatano = $platano_recupera_vida/BananaKeyboardX
@onready var señalKPlatano = $platano_recupera_vida/BananaKeyboardK

@onready var enemigoMono1 = $enemigoMono
@onready var enemigoMono2 = $enemigoMono

@onready var enemigoAraña = $"EnemigoAraña"
@onready var enemigoAraña2 = $"EnemigoAraña2"

@onready var bolaPinchosMagica1 = $zonaPinchosVertical

@onready var estacaMadera1 = $estacasMadera1
@onready var estacaMadera2 = $estacasMadera2

@onready var bloqueCaida = $bloqueCaidaGris/areaMuerte



var initial_position = Vector2()  # Variable para almacenar la posición inicial

func _ready():
	# Guardar la posición inicial del jugador
	initial_position = player.global_position
	
	bolaPinchosMagica1.connect("body_entered", Callable(self, "_on_bola_pincho_magica_on_body_entered"))
	enemigoAraña.connect("body_entered", Callable(self, "_on_enemigo_araña_on_body_entered"))
	enemigoAraña2.connect("body_entered", Callable(self, "_on_enemigo_araña_on_body_entered"))
	enemigoMono1.connect("body_entered", Callable(self, "_on_enemigo_mono_on_body_entered"))
	enemigoMono2.connect("body_entered", Callable(self, "_on_enemigo_mono_on_body_entered"))
	estacaMadera1.connect("body_entered", Callable(self, "_on_estaca_madera_on_body_entered"))
	estacaMadera2.connect("body_entered", Callable(self, "_on_estaca_madera_on_body_entered"))
	bloqueCaida.connect("body_entered", Callable(self, "_on_bloque_Caida_on_body_entered"))


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

func _on_bola_pincho_magica_on_body_entered(body):
	if body.name == "Player":
		life.damage(30)

func _on_estaca_madera_on_body_entered(body):
	if body.name == "Player":
		life.damage(10)

func _on_bloque_Caida_on_body_entered(body):
	if body.name == "Player":
		anim.play("aplastado")
		life.damage(100)





	


	
	
