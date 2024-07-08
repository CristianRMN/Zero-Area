extends Area2D

@onready var entrar = $Entra
@onready var player = get_parent().get_node("Player")  # Asegúrate de ajustar el path si es necesario

func _ready():
	# Conectar señales de entrada y salida
	self.connect("body_entered", Callable(self, "_on_body_entered"))
	self.connect("body_exited", Callable(self, "_on_body_exited"))
	entrar.visible = false

func _on_body_entered(body):
	if body.name == "Player":
		entrar.visible = true

func _on_body_exited(body):
	if body.name == "Player":
		entrar.visible = false

func _process(delta):
	if entrar.visible and Input.is_action_just_pressed("abrirLoQueSea"):
		Global.player_position = player.global_position
		get_tree().change_scene_to_file("res://scenes/world1-10/casa_nivel_secreto_con_cristal_mundo_1_10.tscn")
