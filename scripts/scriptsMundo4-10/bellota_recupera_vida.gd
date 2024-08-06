extends Area2D

#La bellota te recupera 8 de vida

@onready var señalComer1 = $comeK
@onready var señalComer2 = $comeX



func _ready():
	# Conectar señales de entrada y salida
	self.connect("body_entered", Callable(self, "_on_body_entered"))
	self.connect("body_exited", Callable(self, "_on_body_exited"))
	señalComer1.visible = false
	señalComer2.visible = false


func _on_body_entered(body):
	if body.name == "Player":
		señalComer1.visible = true
		señalComer2.visible = true

func _on_body_exited(body):
	if body.name == "Player":
		señalComer1.visible = false
		señalComer2.visible = false

func _process(delta):
	if (señalComer1.visible or señalComer2.visible) and Input.is_action_just_pressed("alimentacion"):
		señalComer1.visible = false
		señalComer2.visible = false
		call_deferred("queue_free")  # Elimina la bellota del árbol de nodos de forma segura
