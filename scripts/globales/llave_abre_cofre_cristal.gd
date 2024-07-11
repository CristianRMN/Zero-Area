extends Area2D

@onready var señalCoger = $cogeLaLlave
@onready var anim = $animLlave
@onready var llave = $Llave


func _ready():
	# Conectar señales de entrada y salida
	self.connect("body_entered", Callable(self, "_on_body_entered"))
	self.connect("body_exited", Callable(self, "_on_body_exited"))
	señalCoger.visible = false
	anim.play("llaveMovimiento")

func _on_body_entered(body):
	if body.name == "Player":
		señalCoger.visible = true

func _on_body_exited(body):
	if body.name == "Player":
		señalCoger.visible = false

func _process(delta):
	if señalCoger.visible and Input.is_action_just_pressed("abrirLoQueSea"):
		Global.has_key = true
		señalCoger.visible = false
		llave.hide()
		call_deferred("queue_free")
