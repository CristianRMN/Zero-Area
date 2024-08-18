extends Area2D

#La manzana dorada siempre te recuperará 100 de vida

@onready var señalComer1 = $pulsaK
@onready var señalComer2 = $pulsaX
@onready var apple = $ManzadaDorada
@onready var anim = $AnimationPlayer


func _ready():
	# Conectar señales de entrada y salida
	self.connect("body_entered", Callable(self, "_on_body_entered"))
	self.connect("body_exited", Callable(self, "_on_body_exited"))
	señalComer1.visible = false
	señalComer2.visible = false
	anim.play("brilloManzanaDorada")

func _on_body_entered(body):
	if body.name == "Player" and apple.visible:
		señalComer1.visible = true
		señalComer2.visible = true

func _on_body_exited(body):
	if body.name == "Player" and apple.visible:
		señalComer1.visible = false
		señalComer2.visible = false

func _process(delta):
	if (señalComer1.visible or señalComer2.visible) and Input.is_action_just_pressed("alimentacion"):
		señalComer1.visible = false
		señalComer2.visible = false
		apple.hide()  # Oculta la manzana
		anim.stop()
		call_deferred("queue_free")  # Elimina la manzana del árbol de nodos de forma segura
