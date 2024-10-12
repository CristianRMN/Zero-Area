extends Area2D

@onready var señalSalir = $salir
@onready var areaSalir = self

func _ready():
	señalSalir.visible = false
	self.connect("on_body_entered",Callable(self, "on_body_entered"))
	self.connect("on_body_exited",Callable(self, "on_body_exited"))


func _process(delta):
	if señalSalir.visible and Input.is_action_just_pressed("abrirLoQueSea"):
		print("he salido")

func on_body_entered(body):
	if body.name == "Player":
		señalSalir.visible = true

func on_body_exited(body):
	if body.name == "Player":
		señalSalir.visible = false



