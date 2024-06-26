extends CharacterBody2D

var speed = 120
var direction = 0.0
var jump = 200
const gravity = 9
const FIREBALL = preload("res://scenes/fire_ball.tscn")

@export var fireball_scene = PackedScene
@export var fireBall_speed = 400

@onready var anim = $AnimationPlayer
@onready var sprite = $Sprite
@onready var mouth = $Marker2D

func _physics_process(delta):
	direction = Input.get_axis("caminar_izquierda", "caminar_derecha")
	velocity.x = direction * speed
	
	# Verifica si la animación de protección está en progreso
	if anim.current_animation == "protected" || anim.current_animation == "sleep" || anim.current_animation == "attack" || anim.current_animation == "eat" and anim.is_playing():
		# No cambiar la animación si está en protección
		pass
	elif direction != 0:
		anim.play("walk")
	else:
		anim.play("idle")

	sprite.flip_h = direction < 0 if direction != 0 else sprite.flip_h

	if Input.is_action_just_pressed("protegerse"):
		anim.play("protected")
	
	if Input.is_action_just_pressed("mimir"):
		anim.play("sleep")
	
	if Input.is_action_just_pressed("ataque"):
		anim.play("attack")
		spawnFireball()
		
	if Input.is_action_just_pressed("alimentacion"):
		anim.play("eat")
	
	if is_on_floor() and Input.is_action_pressed("ui_accept"):
		velocity.y -= jump
	
	if not is_on_floor():
		velocity.y += gravity
	
	move_and_slide()
	
func spawnFireball():
	var ball = FIREBALL.instantiate()
	get_parent().add_child(ball)
	if sprite.flip_h:
		ball.setup("left")
		ball.position = $Marker2D.global_position
	else:
		ball.setup("right")
		ball.position = $Marker2D.global_position
	
	
	

