extends Area2D

@onready var señalAbrir = $KeyboardV
@onready var anim = $Anim

func _ready():
	# Conectar señales de entrada y salida
	self.connect("body_entered", Callable(self, "_on_body_entered"))
	self.connect("body_exited", Callable(self, "_on_body_exited"))
	señalAbrir.visible = false

func _on_body_entered(body):
	if body.name == "Player":
		señalAbrir.visible = true

func _on_body_exited(body):
	if body.name == "Player":
		señalAbrir.visible = false

func _process(delta):
	if señalAbrir.visible and Input.is_action_just_pressed("abrirLoQueSea"):
		anim.play("apertura")
		señalAbrir.visible = false
