extends Area2D

@onready var entrarCasa = $entra
@onready var player = get_parent().get_node("Player")  

func _ready():
	# Conectar señales de entrada y salida
	self.connect("body_entered", Callable(self, "_on_body_entered"))
	self.connect("body_exited", Callable(self, "_on_body_exited"))
	entrarCasa.visible = false

func _on_body_entered(body):
	if body.name == "Player":
		entrarCasa.visible = true

func _on_body_exited(body):
	if body.name == "Player":
		entrarCasa.visible = false

func _process(delta):
	if entrarCasa.visible and Input.is_action_just_pressed("abrirLoQueSea"):
		entrarCasa.visible = false
		get_tree().change_scene_to_file("res://scenes/world7-10/casa_setas_escena_1_2.tscn")

