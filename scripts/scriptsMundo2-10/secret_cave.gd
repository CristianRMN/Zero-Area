extends Node2D

@onready var player = $Player 
@onready var life = $vidaTerapagos/ProgressBar
@onready var anim = $Player/AnimationPlayer

@onready var señalxManzana1 = $manzana_recupera_vida/PulsaX
@onready var señalKManzana1 = $manzana_recupera_vida/PulsaK

@onready var señalxManzana2 = $manzana_recupera_vida2/PulsaX
@onready var señalKManzana2 = $manzana_recupera_vida2/PulsaK

@onready var murcielago1 = $murcielago
@onready var murcielago2 = $murcielago2
@onready var murcielago3 = $murcielago3

@onready var enemigoAraña = $"EnemigoAraña"
@onready var enemigoAraña2 = $"EnemigoAraña2"

@onready var zonaPinchosCaen = $"zonaCaidaPinchos/zonaDaño"

@onready var bolaPinchosMagica1 = $bolaPinchoPecharuntVertical
@onready var bolaPinchosMagica2 = $bolaPinchoPecharuntVertical2
@onready var bolaPinchosMagica3 = $bolaPinchoPecharuntVertical3

@onready var bloqueCaida = $bloqueCaidaGris/areaMuerte
@onready var bloqueAmarilloCaida1 = $bloqueAmarilloGiratorio/zonaMuerte
@onready var bloqueAmarilloCaida2 = $bloqueAmarilloGiratorio2/zonaMuerte



var initial_position = Vector2()  # Variable para almacenar la posición inicial

func _ready():
	# Guardar la posición inicial del jugador
	initial_position = player.global_position
	
	bolaPinchosMagica1.connect("body_entered", Callable(self, "_on_bola_pincho_magica_on_body_entered"))
	bolaPinchosMagica2.connect("body_entered", Callable(self, "_on_bola_pincho_magica_on_body_entered"))
	bolaPinchosMagica3.connect("body_entered", Callable(self, "_on_bola_pincho_magica_on_body_entered"))
	
	enemigoAraña.connect("body_entered", Callable(self, "_on_enemigo_araña_on_body_entered"))
	enemigoAraña2.connect("body_entered", Callable(self, "_on_enemigo_araña_on_body_entered"))
	
	murcielago1.connect("body_entered", Callable(self, "_on_murcielago_on_body_entered"))
	murcielago2.connect("body_entered", Callable(self, "_on_murcielago_on_body_entered"))
	murcielago3.connect("body_entered", Callable(self, "_on_murcielago_on_body_entered"))
	
	zonaPinchosCaen.connect("body_entered", Callable(self, "_on_pinchos_caen_on_body_entered"))
	

	bloqueCaida.connect("body_entered", Callable(self, "_on_bloque_Caida_on_body_entered"))
	bloqueAmarilloCaida1.connect("body_entered", Callable(self, "_on_bloque_Caida_amarillo_on_body_entered"))
	bloqueAmarilloCaida2.connect("body_entered", Callable(self, "_on_bloque_Caida_amarillo_on_body_entered"))

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
		if is_instance_valid(señalKManzana1) and señalKManzana1.visible:
			life.heal(20)
			señalKManzana1.visible = false  
		elif is_instance_valid(señalxManzana1) and señalxManzana1.visible:
			life.heal(20)
			señalxManzana1.visible = false 
			
	if Input.is_action_just_pressed("alimentacion"):
		if is_instance_valid(señalKManzana2) and señalKManzana2.visible:
			life.heal(20)
			señalKManzana2.visible = false  
		elif is_instance_valid(señalxManzana2) and señalxManzana2.visible:
			life.heal(20)
			señalxManzana2.visible = false 

		
		


func respawn_player():
	# Restaurar la posición del jugador a la posición inicial
	player.global_position = initial_position
	life.damage(10)
	

		
func _on_murcielago_on_body_entered(body):
	if body.name == "Player":
		life.damage(12)
		
func _on_enemigo_araña_on_body_entered(body):
	if body.name == "Player":
		life.damage(8)

func _on_bola_pincho_magica_on_body_entered(body):
	if body.name == "Player":
		life.damage(30)

func _on_pinchos_caen_on_body_entered(body):
	if body.name == "Player":
		life.damage(30)

func _on_bloque_Caida_on_body_entered(body):
	if body.name == "Player":
		anim.play("aplastado")
		life.damage(100)
		
func _on_bloque_Caida_amarillo_on_body_entered(body):
	if body.name == "Player":
		anim.play("aplastado")
		life.damage(50)





	


	
	
