extends Area2D


@onready var coger = $cogeHacha



func _ready():
	# Conectar señales de entrada y salida
	self.connect("body_entered", Callable(self, "_on_body_entered"))
	self.connect("body_exited", Callable(self, "_on_body_exited"))
	coger.visible = false


func _on_body_entered(body):
	if body.name == "Player":
		coger.visible = true


func _on_body_exited(body):
	if body.name == "Player":
		coger.visible = false


func _process(delta):
	if (coger.visible) and Input.is_action_just_pressed("abrirLoQueSea"):
		coger.visible = false
		
