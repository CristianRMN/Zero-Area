extends CharacterBody2D

var speed = 120
var direction = 0.0
var jump = 200
var gravity = 9
const FIREBALL = preload("res://scenes/fire_ball.tscn")

#variables de subir Escaleras
var colliding_ladder = false
var going_up = false
var climbStair = 11

#variables de ascension de viento
var wind_area = false
var rise_wind = 50

var wind_area_down = false

#variables de lianas
var inVine = false
var swingingForceJump = 30

#variables de rebote
var inZonaRebote = false
var forceRebote = 100
var countRebote = 0
const limitCount = 3
var stopRebote = false



@export var fireball_scene = PackedScene
@export var fireBall_speed = 400

@onready var anim = $AnimationPlayer
@onready var sprite = $Sprite
@onready var mouth = $Marker2D
@onready var mouth2 = $Marker2D2

func _physics_process(delta):
	direction = Input.get_axis("caminar_izquierda", "caminar_derecha")
	velocity.x = direction * speed
	
	# Verifica si la animación de protección está en progreso
	if anim.current_animation == "protected" || anim.current_animation == "aplastado" || anim.current_animation == "attack" || anim.current_animation == "eat" || anim.current_animation == "AplastadoIzquierda" and anim.is_playing():
		# No cambiar la animación si está en protección
		pass
	elif direction != 0:
		anim.play("walk")
	else:
		anim.play("idle")

	sprite.flip_h = direction < 0 if direction != 0 else sprite.flip_h

	if Global.haveTheProtection and Input.is_action_just_pressed("protegerse"):
		anim.play("protected")
		
	
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
	
	climb()
	rise()
	rise_down()
	rebotes()

	
func spawnFireball():
	var ball = FIREBALL.instantiate()
	get_parent().add_child(ball)
	if sprite.flip_h:
		ball.setup("left")
		ball.position = mouth2.global_position
	else:
		ball.setup("right")
		ball.position = mouth.global_position
	
	
	

func climb():
	if colliding_ladder:
		if Input.is_action_pressed("subirAlgo"):
			velocity.y -= climbStair
			
func rise():
	if wind_area:
		velocity.y -= rise_wind
		
func rise_down():
	if wind_area_down:
		velocity.y += rise_wind


func rebotes():
	if inZonaRebote and Input.is_action_just_pressed("saltar"):
		if stopRebote == false:
			print("entre1")
			velocity.y -= forceRebote
			forceRebote = forceRebote + 30
			countRebote = countRebote + 1
			print(forceRebote)
			if countRebote >= limitCount:
				print(forceRebote)
				print("entre2")
				stopRebote = true
		
		if stopRebote:
			print("entre")
			velocity.y -= forceRebote
			forceRebote = 100
			countRebote = 0
			stopRebote = false










func _on_area_2d_area_entered(area):
	if area.is_in_group("ladder"):
		colliding_ladder = true
		going_up = false
	
	if area.is_in_group("viento"):
		wind_area = true
	
	if area.is_in_group("viento_abajo"):
		wind_area_down = true
	
	if area.is_in_group("liana"):
		inVine = true
	
	if area.is_in_group("rebote"):
		inZonaRebote = true



func _on_subir_a_algo_area_exited(area):
	if area.is_in_group("ladder"):
		colliding_ladder = false

	if area.is_in_group("viento"):
		wind_area = false
		
	if area.is_in_group("viento_abajo"):
		wind_area_down = false

	if area.is_in_group("liana"):
		inVine = false

	if area.is_in_group("rebote"):
		inZonaRebote = false
