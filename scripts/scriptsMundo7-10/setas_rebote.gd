extends StaticBody2D

@onready var zonaDeRebotes = $zonaRebote
@onready var boing = $efectoRebote
@onready var boingAnim = $efectoRebote/AnimationPlayer

var playerInZone = false

func _ready():
	boing.visible = false
	zonaDeRebotes.connect("body_entered", Callable(self, "on_body_entered"))
	zonaDeRebotes.connect("body_exited", Callable(self, "on_body_exited"))
	boingAnim.connect("animation_finished", Callable(self, "on_animation_finished"))

func _process(delta):
	showBoing()

func on_body_entered(body):
	if body.name == "Player":
		playerInZone = true

func on_body_exited(body):
	if body.name == "Player":
		playerInZone = false

func on_animation_finished(anim):
	if anim == "rebote":
		boing.visible = false

func showBoing():
	if playerInZone and Input.is_action_just_pressed("saltar"):
		if not boing.visible:  # Evitar reiniciar la animación si ya está visible
			boing.visible = true
			boingAnim.play("rebote")
