extends CharacterBody2D

@onready var bloque = $BloqueParaMover
@onready var areaEmpuje = $zonaEmpuje
@onready var señalEmpuje = $zonaEmpuje/empuja
@onready var colisionBloque = $CollisionShape2D
@onready var colisionParaEmpujar = $zonaEmpuje/CollisionShape2D
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
	if(señalEmpuje.visible) and Input.is_action_pressed("abrirLoQueSea"):
		bloque.position.x -= speed * delta
		colisionBloque.position.x = bloque.position.x
		señalEmpuje.position.x = bloque.position.x
		

	
	
	move_and_slide()
