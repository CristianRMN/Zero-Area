extends Area2D

@onready var cogePiezaCorazon = $recoge
@onready var hearth = $PiezaAumentoVida
@onready var anim = $AnimationPlayer

func _ready():
	# Conectar señales de entrada y salida
	self.connect("body_entered", Callable(self, "_on_body_entered"))
	self.connect("body_exited", Callable(self, "_on_body_exited"))
	cogePiezaCorazon.visible = false
	anim.play("brillo")

func _on_body_entered(body):
	if body.name == "Player" and hearth.visible:
		cogePiezaCorazon.visible = true


func _on_body_exited(body):
	if body.name == "Player" and hearth.visible:
		cogePiezaCorazon.visible = false


func _process(delta):
	if (cogePiezaCorazon.visible) and Input.is_action_just_pressed("abrirLoQueSea"):
		Global.num_hearts_life_terapagos = Global.num_hearts_life_terapagos + 1
		cogePiezaCorazon.visible = false
		anim.stop()
		call_deferred("queue_free") 
