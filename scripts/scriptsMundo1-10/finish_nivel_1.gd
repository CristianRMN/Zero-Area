extends Area2D

@onready var pilla_bandera = $PulsaV
@onready var anim = $movimientoBandera


func _ready():
	# Conectar señales de entrada y salida
	self.connect("body_entered", Callable(self, "_on_body_entered"))
	self.connect("body_exited", Callable(self, "_on_body_exited"))
	pilla_bandera.visible = false


func _on_body_entered(body):
	if body.name == "Player":
		pilla_bandera.visible = true


func _on_body_exited(body):
	if body.name == "Player":
		pilla_bandera.visible = false


func _process(delta):
	anim.play("mover_bandera")
	if pilla_bandera and Input.is_action_just_pressed("abrirLoQueSea"):
		pilla_bandera.visible = false

