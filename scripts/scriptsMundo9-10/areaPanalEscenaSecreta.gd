extends Area2D

@onready var areaPanalAbeja = self
@onready var señal_entra = $entra

func _ready():
	señal_entra.visible = false
	self.connect("body_entered",Callable(self, "on_body_entered"))
	self.connect("body_exited",Callable(self, "on_body_exited"))

func _process(delta):
	if señal_entra and Input.is_action_just_pressed("abrirLoQueSea"):
		print("Funciona")

func on_body_entered(body):
	if body.name == "Player":
		señal_entra.visible = true

func on_body_exited(body):
	if body.name == "Player":
		señal_entra.visible = false
