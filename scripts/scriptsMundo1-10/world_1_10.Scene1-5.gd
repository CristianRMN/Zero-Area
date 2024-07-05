extends Node2D

@onready var player = $Player  # Asegúrate de ajustar el path si es necesario

func _ready():
	# Restaurar la posición del jugador si se ha almacenado una posición
	if Global.player_position != Vector2():
		player.global_position = Global.player_position
		# Resetea la posición para que no interfiera con futuros cambios de escena
		Global.player_position = Vector2()
