extends CharacterBody2D

@onready var roca = self
@onready var areaEmpuje = $zonaEmpujeRoca
@onready var señalEmpuje = $"zonaEmpujeRoca/señalEmpuja"

var speed = 30

func _ready():
	señalEmpuje.visible = false
	areaEmpuje.connect("body_entered", Callable(self, "_on_body_entered"))
	areaEmpuje.connect("body_exited", Callable(self, "_on_body_exited"))

func _on_body_entered(body):
	if body.name == "Player":
		señalEmpuje.visible = true
		
func _on_body_exited(body):
	if body.name == "Player":
		señalEmpuje.visible = false

func _physics_process(delta):
	if señalEmpuje.visible and Input.is_action_pressed("abrirLoQueSea"):
		# Mover el nodo del bloque completo
		roca.position.x -= speed * delta


	move_and_slide()
