extends CharacterBody2D

@onready var bloque = self
@onready var areaEmpuje = $zonaEmpuje
@onready var señalEmpuje = $zonaEmpuje/empuja
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
		# Mover el nodo del bloque completo
		bloque.position.x -= speed * delta

	# No es necesario mover manualmente colisionBloque, colisionParaEmpujar y señalEmpuje
	# ya que son hijos del nodo bloque, se moverán automáticamente con él

	move_and_slide()
