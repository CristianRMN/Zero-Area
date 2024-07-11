extends Area2D

@onready var señalAbrir = $KeyboardV
@onready var anim = $Anim

var is_opened = false  # Variable para controlar si el cofre ya ha sido abierto

func _ready():
	# Conectar señales de entrada y salida
	self.connect("body_entered", Callable(self, "_on_body_entered"))
	self.connect("body_exited", Callable(self, "_on_body_exited"))
	señalAbrir.visible = false

func _on_body_entered(body):
	if body.name == "Player" and not is_opened:
		señalAbrir.visible = true

func _on_body_exited(body):
	if body.name == "Player":
		señalAbrir.visible = false

func _process(delta):
	if señalAbrir.visible  and Input.is_action_just_pressed("abrirLoQueSea") and not is_opened and Global.has_key:
		anim.play("apertura")
		señalAbrir.visible = false
		is_opened = true  # marcamos el cofre como abierto
