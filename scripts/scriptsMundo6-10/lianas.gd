extends Area2D

@onready var señalAgarre = $agarrarse
@onready var zonaAreaAgarreLianas = self
var target_position = Vector2(283, 347)
@onready var player = $Player
@onready var colisiones = $colisionesEnLiana
@onready var spriteLiana = $SpritesLianas




func _ready():
	señalAgarre.visible = false
	zonaAreaAgarreLianas.connect("body_entered", Callable(self, "on_señal_agarre_liana_on_body_entered"))
	zonaAreaAgarreLianas.connect("body_exited", Callable(self, "on_señal_agarre_liana_on_body_exited"))
	disableInitialColisions()

func _process(delta):
	swinging()


func on_señal_agarre_liana_on_body_entered(body):
	if body.name == "Player":
		señalAgarre.visible = true

func on_señal_agarre_liana_on_body_exited(body):
	if body.name == "Player":
		señalAgarre.visible = false

func swinging():
	if señalAgarre.visible and Input.is_action_pressed("abrirLoQueSea"):
		player.global_position = target_position
		activateColisions()
		if Input.is_action_pressed("caminar_derecha") and Input.is_action_pressed("ui_accept"):
			print("estoy dentro")
			disableInitialColisions()
			

func disableInitialColisions():
	for collision_shape in $colisionesEnLiana.get_children():
		if collision_shape is CollisionShape2D:
			collision_shape.disabled = true

func activateColisions():
	for collision_shape in $colisionesEnLiana.get_children():
		if collision_shape is CollisionShape2D:
			collision_shape.disabled = false


