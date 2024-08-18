extends Node2D

@onready var player = $Player 
@onready var life = $vidaTerapagos/CanvasLayer/ProgressBar
@onready var anim = $Player/AnimationPlayer



@onready var araña1 = $"EnemigoAraña"
@onready var araña2 = $"EnemigoAraña2"
@onready var araña3 = $"EnemigoAraña3"
@onready var araña4 = $"EnemigoAraña4"

@onready var sierra = $sierraGiratoria
@onready var sierraAnim = $sierraGiratoria/AnimationPlayer

@onready var enemigo_murcielago1 = $murcielago
@onready var enemigo_murcielago2 = $murcielago2
@onready var enemigo_murcielago3 = $murcielago3

@onready var señalKPlatano = $platano_recupera_vida/BananaKeyboardK
@onready var señalxPlatano = $platano_recupera_vida/BananaKeyboardX

@onready var señalKManzana = $manzana_recupera_vida/PulsaK
@onready var señalxManzana = $manzana_recupera_vida/PulsaX

@onready var señalKPlatano2 = $platano_recupera_vida2/BananaKeyboardK
@onready var señalxPlatano2 = $platano_recupera_vida2/BananaKeyboardX

@onready var señalKManzana2 = $manzana_recupera_vida2/PulsaK
@onready var señalxManzana2 = $manzana_recupera_vida2/PulsaX

@onready var señalKManzana3 = $manzana_recupera_vida3/PulsaK
@onready var señalxManzana3 = $manzana_recupera_vida3/PulsaX


@onready var bloqueAmarillo1 = $bloqueAmarilloCaidaRapida/zonaMuerte

@onready var sierraIzquierda = $sierraALaIzquierda
@onready var sierraIzquierdaAnim = $sierraALaIzquierda/AnimationPlayer

@onready var serpiente1 = $enemigoSerpiente
@onready var serpiente2 = $enemigoSerpiente2
@onready var serpiente3 = $enemigoSerpiente3

@onready var bloqueAzul1 = $bloqueMovimientoIzquierda/zonaMuerte
@onready var bloqueAzul2 = $bloqueMovimientoIzquierda2/zonaMuerte
@onready var bloqueAzul3 = $bloqueMovimientoDerechaEscena4/zonaMuerte







var up = -10

var is_near_escalera = false

var initial_position = Vector2()  # Variable para almacenar la posición inicial

func _ready():
	# Guardar la posición inicial del jugador
	initial_position = player.global_position
	
	araña1.connect("body_entered", Callable(self, "_on_enemigo_araña_on_body_entered"))
	araña2.connect("body_entered", Callable(self, "_on_enemigo_araña_on_body_entered"))
	araña3.connect("body_entered", Callable(self, "_on_enemigo_araña_on_body_entered"))
	araña4.connect("body_entered", Callable(self, "_on_enemigo_araña_on_body_entered"))


	
	sierra.connect("body_entered", Callable(self, "_on_sierra_on_body_entered"))

	bloqueAmarillo1.connect("body_entered", Callable(self, "_on_bloque_Caida_Amarillo_on_body_entered"))

	
	enemigo_murcielago1.connect("body_entered", Callable(self, "_on_enemigo_murcielago_on_body_entered"))
	enemigo_murcielago2.connect("body_entered", Callable(self, "_on_enemigo_murcielago_on_body_entered"))
	enemigo_murcielago3.connect("body_entered", Callable(self, "_on_enemigo_murcielago_on_body_entered"))
	
	

	serpiente1.connect("body_entered", Callable(self, "_on_enemigo_serpiente_on_body_entered"))
	serpiente2.connect("body_entered", Callable(self, "_on_enemigo_serpiente_on_body_entered"))
	serpiente3.connect("body_entered", Callable(self, "_on_enemigo_serpiente_on_body_entered"))

	sierraIzquierda.connect("body_entered", Callable(self, "_on_sierra_izquierda_on_body_entered"))
	
	bloqueAzul1.connect("body_entered", Callable(self, "_on_bloque_azul_on_body_entered"))
	bloqueAzul2.connect("body_entered", Callable(self, "_on_bloque_azul_on_body_entered"))
	bloqueAzul3.connect("body_entered", Callable(self, "_on_bloque_azul_on_body_entered"))
	




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


	if Input.is_action_just_pressed("alimentacion"):
		if is_instance_valid(señalKPlatano2) and señalKPlatano2.visible:
			life.heal(15)
			señalKPlatano2.visible = false  
		elif is_instance_valid(señalxPlatano2) and señalxPlatano2.visible:
			life.heal(15)
			señalxPlatano2.visible = false 

	if Input.is_action_just_pressed("alimentacion"):
		if is_instance_valid(señalKManzana3) and señalKManzana3.visible:
			life.heal(20)
			señalKManzana3.visible = false  
		elif is_instance_valid(señalxManzana3) and señalxManzana3.visible:
			life.heal(20)
			señalxManzana3.visible = false 


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


func _on_sierra_on_body_entered(body):
	if body.name == "Player":
		if sierraAnim.is_playing():
			life.damage(30)
			

func _on_enemigo_murcielago_on_body_entered(body):
	if body.name == "Player":
		life.damage(12)
		

func _on_enemigo_serpiente_on_body_entered(body):
	if body.name == "Player":
		life.damage(15)
		
func _on_sierra_izquierda_on_body_entered(body):
	if body.name == "Player":
		if sierraIzquierdaAnim.is_playing():
			life.damage(30)
			
func _on_bloque_azul_on_body_entered(body):
	if body.name == "Player":
		anim.play("AplastadoIzquierda")
		life.damage(40)




