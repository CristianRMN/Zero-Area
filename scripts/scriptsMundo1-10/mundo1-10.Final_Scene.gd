extends Node2D

@onready var player = $Player 
@onready var life = $vidaTerapagos/CanvasLayer/ProgressBar
@onready var señalxManzana = $manzana_recupera_vida/PulsaX
@onready var señalkManzana = $manzana_recupera_vida/PulsaK



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
	
	if Input.is_action_just_pressed("alimentacion"):
		if is_instance_valid(señalkManzana) and señalkManzana.visible:
			life.heal(20)
			señalkManzana.visible = false  
		elif is_instance_valid(señalxManzana) and señalxManzana.visible:
			life.heal(20)
			señalxManzana.visible = false 

func respawn_player():
	# Restaurar la posición del jugador a la posición inicial
	player.global_position = initial_position
	life.damage(10)

	


	
	
