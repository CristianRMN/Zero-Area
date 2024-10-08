extends CharacterBody2D

@export var speed = 200
@onready var animation = $AnimationPlayer
@onready var sprite = $Sprite
@onready var colisionEnemigos = $areaColisionEnemigos

# Variable para almacenar la dirección
var direction = "right"

func _ready():
	colisionEnemigos.connect("body_entered", Callable(self, "_on_area_colision_enemigos_body_entered"))
	animation.connect("animation_finished", Callable(self, "on_finish_explosion_animation_finished"))

func _physics_process(delta):
	# Configurar la velocidad según la dirección
	if direction == "right":
		velocity.x = speed
	else:
		velocity.x = -speed
	
	# Mueve la bola de fuego y detecta colisiones
	var collision = move_and_collide(velocity * delta)
	if collision:
		_on_collision(collision)

	animation.play("shoot_fire_ball")
	explosionEnemys()

func _on_collision(collision):
	# Maneja lo que sucede cuando la bola de fuego colisiona
	queue_free()  # Elimina la bola de fuego al colisionar

func setup(new_direction):
	direction = new_direction
	if direction == "right":
		sprite.flip_h = false
	elif direction == "left":
		sprite.flip_h = true

func _on_area_colision_enemigos_body_entered(body):
	if body.is_in_group("enemy"):
		queue_free()

func explosionEnemys():
	if Global.insideEnemy:
		var is_active = true
		if is_active: 
			animation.play("explosion")
			is_active = false
			var desaparece = true
			if desaparece:
				Global.insideEnemy = false
				queue_free()
				desaparece = false

func on_finish_explosion_animation_finished(anim_name):
	if anim_name == "explosion":
		Global.insideEnemy = false
		queue_free()



