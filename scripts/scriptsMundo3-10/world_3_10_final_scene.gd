extends Node2D

@onready var player = $Player 
@onready var life = $vidaTerapagos/ProgressBar
@onready var anim = $Player/AnimationPlayer


@onready var araña1 = $"EnemigoAraña"
@onready var araña2 = $"EnemigoAraña2"

@onready var mono1 = $enemigoMono

@onready var serpiente1 = $enemigoSerpiente

@onready var murcielago1 = $murcielago

@onready var bolaPinchos = $bolaPinchoPecharuntVertical2

@onready var señalKPlatano = $platano_recupera_vida/BananaKeyboardK
@onready var señalxPlatano = $platano_recupera_vida/BananaKeyboardX
@onready var señalKManzana = $manzana_recupera_vida/PulsaK
@onready var señalxManzana = $manzana_recupera_vida/PulsaX
@onready var señalKManzana2 = $manzana_recupera_vida2/PulsaK
@onready var señalxManzana2 = $manzana_recupera_vida2/PulsaX

@onready var bloqueAmarillo1 = $bloqueAmarilloCaidaRapida/zonaMuerte
@onready var bloqueAmarillo2 = $bloqueAmarilloCaidaRapida2/zonaMuerte
@onready var bloqueAmarillo3 = $bloqueAmarilloCaidaRapida3/zonaMuerte
@onready var bloqueAmarillo4 = $bloqueAmarilloCaidaRapida4/zonaMuerte

@onready var bloqueAzulDerecha1 = $bloqueMovimientoDerechaEscena4/zonaMuerte
@onready var bloqueAzulDerecha2 = $bloqueMovimientoDerechaEscena5/zonaMuerte
@onready var bloqueAzulDerecha3 = $bloqueMovimientoDerechaEscena6/zonaMuerte
@onready var bloqueAzulDerecha4 = $bloqueMovimientoDerechaEscena7/zonaMuerte
@onready var bloqueAzulDerecha5 = $bloqueMovimientoDerechaEscena8/zonaMuerte
@onready var bloqueAzulDerecha6 = $bloqueMovimientoDerechaEscena9/zonaMuerte
@onready var bloqueAzulDerecha7 = $bloqueMovimientoDerechaEscena10/zonaMuerte

@onready var bloqueAzulIzquierda1 = $bloqueMovimientoIzquierda/zonaMuerte
@onready var bloqueAzulIzquierda2 = $bloqueMovimientoIzquierda2/zonaMuerte
@onready var bloqueAzulIzquierda3 = $bloqueMovimientoIzquierda3/zonaMuerte
@onready var bloqueAzulIzquierda4 = $bloqueMovimientoIzquierda4/zonaMuerte
@onready var bloqueAzulIzquierda5 = $bloqueMovimientoIzquierda5/zonaMuerte
@onready var bloqueAzulIzquierda6 = $bloqueMovimientoIzquierda6/zonaMuerte
@onready var bloqueAzulIzquierda7 = $bloqueMovimientoIzquierda7/zonaMuerte

var up = -10

var is_near_escalera = false

var initial_position = Vector2()  # Variable para almacenar la posición inicial

func _ready():
	# Guardar la posición inicial del jugador
	initial_position = player.global_position
	
	araña1.connect("body_entered", Callable(self, "_on_enemigo_araña_on_body_entered"))
	araña2.connect("body_entered", Callable(self, "_on_enemigo_araña_on_body_entered"))
	
	mono1.connect("body_entered", Callable(self, "_on_enemigo_mono_on_body_entered"))
	
	bolaPinchos.connect("body_entered", Callable(self, "_on_bola_pincho_magica_on_body_entered"))

	bloqueAmarillo1.connect("body_entered", Callable(self, "_on_bloque_Caida_Amarillo_on_body_entered"))
	bloqueAmarillo2.connect("body_entered", Callable(self, "_on_bloque_Caida_Amarillo_on_body_entered"))
	bloqueAmarillo3.connect("body_entered", Callable(self, "_on_bloque_Caida_Amarillo_on_body_entered"))
	bloqueAmarillo4.connect("body_entered", Callable(self, "_on_bloque_Caida_Amarillo_on_body_entered"))
	
	murcielago1.connect("body_entered", Callable(self, "_on_enemigo_murcielago_on_body_entered"))

	serpiente1.connect("body_entered", Callable(self, "_on_enemigo_serpiente_on_body_entered"))

	bloqueAzulIzquierda1.connect("body_entered", Callable(self, "_on_bloque_azul_on_body_entered"))
	bloqueAzulIzquierda2.connect("body_entered", Callable(self, "_on_bloque_azul_on_body_entered"))
	bloqueAzulIzquierda3.connect("body_entered", Callable(self, "_on_bloque_azul_on_body_entered"))
	bloqueAzulIzquierda4.connect("body_entered", Callable(self, "_on_bloque_azul_on_body_entered"))
	bloqueAzulIzquierda5.connect("body_entered", Callable(self, "_on_bloque_azul_on_body_entered"))
	bloqueAzulIzquierda6.connect("body_entered", Callable(self, "_on_bloque_azul_on_body_entered"))
	bloqueAzulIzquierda7.connect("body_entered", Callable(self, "_on_bloque_azul_on_body_entered"))
	
	bloqueAzulDerecha1.connect("body_entered", Callable(self, "_on_bloque_azul_on_body_entered"))
	bloqueAzulDerecha2.connect("body_entered", Callable(self, "_on_bloque_azul_on_body_entered"))
	bloqueAzulDerecha3.connect("body_entered", Callable(self, "_on_bloque_azul_on_body_entered"))
	bloqueAzulDerecha4.connect("body_entered", Callable(self, "_on_bloque_azul_on_body_entered"))
	bloqueAzulDerecha5.connect("body_entered", Callable(self, "_on_bloque_azul_on_body_entered"))
	bloqueAzulDerecha6.connect("body_entered", Callable(self, "_on_bloque_azul_on_body_entered"))
	bloqueAzulDerecha7.connect("body_entered", Callable(self, "_on_bloque_azul_on_body_entered"))
	




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
	


func _on_enemigo_araña_on_body_entered(body):
	if body.name == "Player":
		life.damage(8)


func _on_bloque_Caida_Amarillo_on_body_entered(body):
	if body.name == "Player":
		anim.play("aplastado")
		life.damage(50)


func _on_enemigo_murcielago_on_body_entered(body):
	if body.name == "Player":
		life.damage(12)
		


func _on_enemigo_serpiente_on_body_entered(body):
	if body.name == "Player":
		life.damage(15)
		


func _on_bloque_azul_on_body_entered(body):
	if body.name == "Player":
		anim.play("AplastadoIzquierda")
		life.damage(40)


func _on_enemigo_mono_on_body_entered(body):
	if body.name == "Player":
		life.damage(15)


func _on_bola_pincho_magica_on_body_entered(body):
	if body.name == "Player":
		life.damage(30)



