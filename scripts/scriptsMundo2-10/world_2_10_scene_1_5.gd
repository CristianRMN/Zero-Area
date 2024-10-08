extends Node2D

@onready var player = $Player 
@onready var life = $vidaTerapagos/CanvasLayer/ProgressBar
@onready var enemigoMono1 = $enemigoMono
@onready var enemigoMono2 = $enemigoMono2
@onready var enemigoAraña1 = $"EnemigoAraña"
@onready var enemigoAraña2 = $"EnemigoAraña2"



var initial_position = Vector2()  # Variable para almacenar la posición inicial



func _ready():
	# Guardar la posición inicial del jugador
	initial_position = player.global_position
	
	enemigoAraña1.connect("body_entered", Callable(self, "_on_enemigo_araña_on_body_entered"))
	enemigoAraña2.connect("body_entered", Callable(self, "_on_enemigo_araña_on_body_entered"))
	
	enemigoMono1.connect("body_entered", Callable(self, "_on_enemigo_mono_on_body_entered"))
	enemigoMono2.connect("body_entered", Callable(self, "_on_enemigo_mono_on_body_entered"))




	# Restaurar la posición del jugador si se ha almacenado una posición
	if Global.player_position != Vector2():
		player.global_position = Global.player_position
		# Resetea la posición para que no interfiera con futuros cambios de escena
		Global.player_position = Vector2()

func _physics_process(delta):
	# Verificar si el jugador ha caído por debajo de un umbral
	if player.global_position.y > 500: 
		respawn_player()

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


	


	
	
