extends CharacterBody2D

@onready var tronco = self
@onready var areaEmpuje = $zonaEmpujeTronco
@onready var señalEmpuje = $zonaEmpujeTronco/empujaElTronco
var speed = 15

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
		tronco.position.x += speed * delta

	move_and_slide()
