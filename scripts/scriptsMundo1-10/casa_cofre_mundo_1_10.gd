extends Area2D

@onready var label = $Label

func _ready():
	# Conectar señales de entrada y salida
	self.connect("body_entered", Callable(self, "_on_body_entered"))
	self.connect("body_exited", Callable(self, "_on_body_exited"))
	label.visible = false

func _on_body_entered(body):
	if body.name == "Player":
		label.text = "Pulsa 'V' para entrar"
		label.visible = true

func _on_body_exited(body):
	if body.name == "Player":
		label.visible = false

func _process(delta):
	if label.visible and Input.is_action_just_pressed("abrirLoQueSea"):
		get_tree().change_scene_to_file("res://scenes/world1-10/casa_nivel_secreto_con_cristal_mundo_1_10.tscn")
