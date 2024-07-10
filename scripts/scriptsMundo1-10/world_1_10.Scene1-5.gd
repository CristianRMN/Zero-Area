extends Node2D

@onready var player = $Player 
@onready var life = $vidaTerapagos/ProgressBar



var initial_position = Vector2()  # Variable para almacenar la posición inicial



func _ready():
	# Guardar la posición inicial del jugador
	initial_position = player.global_position



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


	


	
	
