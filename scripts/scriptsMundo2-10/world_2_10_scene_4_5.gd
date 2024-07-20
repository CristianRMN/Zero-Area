extends Node2D

@onready var player = $TileMap/Player 
@onready var life = $TileMap/vidaTerapagos/ProgressBar

@onready var señalxManzana = $TileMap/manzana_recupera_vida/PulsaX
@onready var señalKManzana = $TileMap/manzana_recupera_vida/PulsaK

@onready var enemigoMono1 = $TileMap/enemigoMono
@onready var enemigoAraña1 = $"TileMap/EnemigoAraña"
@onready var enemigoAraña2 = $"TileMap/EnemigoAraña2"

@onready var bolaPinchosMagica1 = $TileMap/AreaPinchoMovimientoHorizontal
@onready var bolaPinchosMagica2 = $TileMap/zonaBolaPinchosVertical






var initial_position = Vector2()  # Variable para almacenar la posición inicial

func _ready():
	# Guardar la posición inicial del jugador
	initial_position = player.global_position
	
	bolaPinchosMagica1.connect("body_entered", Callable(self, "_on_bola_pincho_magica_on_body_entered"))
	bolaPinchosMagica2.connect("body_entered", Callable(self, "_on_bola_pincho_magica_on_body_entered"))


	# Restaurar la posición del jugador si se ha almacenado una posición
	if Global.player_position != Vector2():
		player.global_position = Global.player_position
		# Resetea la posición para que no interfiera con futuros cambios de escena
		Global.player_position = Vector2()
	


	
	enemigoMono1.connect("body_entered", Callable(self, "_on_enemigo_mono_on_body_entered"))


	
	enemigoAraña1.connect("body_entered", Callable(self, "_on_enemigo_araña_on_body_entered"))
	enemigoAraña2.connect("body_entered", Callable(self, "_on_enemigo_araña_on_body_entered"))

	
	

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


	


	
	
