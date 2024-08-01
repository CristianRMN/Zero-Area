extends Area2D

@onready var leerCartel = $leer
@onready var player = get_parent().get_node("Player")  # Asegúrate de ajustar el path si es necesario

func _ready():
	# Conectar señales de entrada y salida
	self.connect("body_entered", Callable(self, "_on_body_entered"))
	self.connect("body_exited", Callable(self, "_on_body_exited"))
	leerCartel.visible = false

func _on_body_entered(body):
	if body.name == "Player":
		leerCartel.visible = true

func _on_body_exited(body):
	if body.name == "Player":
		leerCartel.visible = false

func _process(delta):
	if leerCartel.visible and Input.is_action_just_pressed("abrirLoQueSea"):
		leerCartel.visible = false
		# Almacenar la posición del jugador antes de cambiar de escena
		Global.player_position = player.global_position
		#get_tree().change_scene_to_file("res://scenes/world3-10/area_info_cartek_world_3_10.tscn")
