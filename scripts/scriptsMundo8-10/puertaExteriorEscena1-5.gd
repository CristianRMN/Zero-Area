extends Area2D

@onready var salirArbol = $salir
@onready var cerrado = $Candado
@onready var player = get_parent().get_node("Player")  

func _ready():
	# Conectar señales de entrada y salida
	self.connect("body_entered", Callable(self, "_on_body_entered"))
	self.connect("body_exited", Callable(self, "_on_body_exited"))
	salirArbol.visible = false
	cerrado.visible = false

func _on_body_entered(body):
	if body.name == "Player":
		salirArbol.visible = true

func _on_body_exited(body):
	if body.name == "Player":
		salirArbol.visible = false
		cerrado.visible = false

func _process(delta):
	if salirArbol.visible and Input.is_action_just_pressed("abrirLoQueSea") and Global.secretKeyTree == false:
		cerrado.visible = true
		salirArbol.visible = false


