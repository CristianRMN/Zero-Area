extends CharacterBody2D

var jump = 11
const gravity = 9

var jumpToObjects = 55

var superJumpY = 13
var superJumpX = 130

var megaJumpY = 19
var megaJumpx = 60

var direction = 1

@onready var anim = $AnimationPlayer

# Variables de subir Escaleras
var colliding_ladder = false
var going_up = false
var climbStair = 11

# Variables de ascensión de viento
var wind_area = false
var rise_wind = 50

var wind_area_down = false

@onready var sprite = $TodosLosSpritesDeOndu


func _ready():
	# Asegúrate de que se llame a la función que establece la velocidad en el Singleton
	Global.giveValueSpeedOndu()

func _physics_process(delta):
	var speed = Global.speedOndu  # Obtén la velocidad desde el Singleton

	if anim.current_animation == "run":
		anim.speed_scale = 3
		velocity.x = direction * speed

	if anim.current_animation == "idle":
		velocity.x = 0
		anim.speed_scale = 1

	if anim.current_animation == "jump":
		velocity.y -= jump
		anim.speed_scale = 3
		
	if anim.current_animation == "jumpToObject":
		velocity.y -= jump
		velocity.x = direction * jumpToObjects
		anim.speed_scale = 3
	
	if anim.current_animation == "super_jump":
		velocity.y -= superJumpY
		velocity.x = direction * superJumpX
		anim.speed_scale = 3
		
	if anim.current_animation == "mega_jump":
		velocity.y -= megaJumpY
		velocity.x = direction * megaJumpx
		anim.speed_scale = 3
	

	if anim.current_animation == "waitRace" or anim.current_animation == "finishRace":
		velocity.x = 0
		anim.speed_scale = 1

	if not is_on_floor():
		velocity.y += gravity

	move_and_slide()
	
	climb()
	rise()
	rise_down()

func climb():
	if colliding_ladder:
		velocity.y -= climbStair

func rise():
	if wind_area:
		velocity.y -= rise_wind

func rise_down():
	if wind_area_down:
		velocity.y += rise_wind


func _on_area_2d_area_entered(area):
	if area.is_in_group("ladder"):
		colliding_ladder = true
		going_up = false

	if area.is_in_group("viento"):
		wind_area = true

	if area.is_in_group("viento_abajo"):
		wind_area_down = true


func _on_subir_a_algo_area_exited(area):
	if area.is_in_group("ladder"):
		colliding_ladder = false

	if area.is_in_group("viento"):
		wind_area = false

	if area.is_in_group("viento_abajo"):
		wind_area_down = false
