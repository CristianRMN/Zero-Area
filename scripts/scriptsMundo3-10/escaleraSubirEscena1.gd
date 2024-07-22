extends Area2D

@onready var subir1 = $sube1
@onready var subir2 = $sube2



func _ready():
	# Conectar señales de entrada y salida
	self.connect("body_entered", Callable(self, "_on_body_entered"))
	self.connect("body_exited", Callable(self, "_on_body_exited"))
	subir1.visible = false
	subir2.visible = false


func _on_body_entered(body):
	if body.name == "Player":
		subir1.visible = true
		subir2.visible = true

func _on_body_exited(body):
	if body.name == "Player":
		subir1.visible = false
		subir2.visible = false
		
func _process(delta):
	if (subir1.visible or subir2.visible) and Input.is_action_pressed("subirAlgo"):
		subir1.visible = false
		subir2.visible = false
