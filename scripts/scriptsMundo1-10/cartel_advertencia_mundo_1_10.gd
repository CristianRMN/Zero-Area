extends Area2D

@onready var leerCartel = $leer



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
	if leerCartel and Input.is_action_just_pressed("abrirLoQueSea"):
		leerCartel.visible = false

