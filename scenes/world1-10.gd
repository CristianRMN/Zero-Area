extends Area2D

@export var player_scene: PackedScene # Arrastra y suelta la escena del jugador en el inspector

func _ready():
	# Instanciar el jugador
	var player_instance = player_scene.instantiate()
	# Establecer la posición inicial del jugador
	player_instance.position = Vector2(100, 100) # Ajusta esto según sea necesario
	# Añadir el jugador a la escena principal
	add_child(player_instance)
