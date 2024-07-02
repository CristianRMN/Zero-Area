extends Area2D

@onready var señalComer1 = $BananaKeyboardK
@onready var señalComer2 = $BananaKeyboardX
@onready var banana_sprite = $Banana

func _ready():
	# Conectar señales de entrada y salida
	connect("body_entered", Callable(self, "_on_body_entered"))
	connect("body_exited", Callable(self, "_on_body_exited"))
	señalComer1.visible = false
	señalComer2.visible = false

func _on_body_entered(body):
	if body.name == "Player" and banana_sprite.visible:
		señalComer1.visible = true
		señalComer2.visible = true

func _on_body_exited(body):
	if body.name == "Player" and banana_sprite.visible:
		señalComer1.visible = false
		señalComer2.visible = false

func _process(delta):
	if (señalComer1.visible or señalComer2.visible) and Input.is_action_just_pressed("alimentacion"):
		señalComer1.visible = false
		señalComer2.visible = false
		banana_sprite.hide()  # Oculta la banana
		call_deferred("queue_free")  # Elimina la banana del árbol de nodos de forma segura
