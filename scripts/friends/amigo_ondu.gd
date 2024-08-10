extends CharacterBody2D


var direction = 0.0
var jump = 200
const gravity = 9


#variables de subir Escaleras
var colliding_ladder = false
var going_up = false
var climbStair = 11

#variables de ascension de viento
var wind_area = false
var rise_wind = 50

var wind_area_down = false


@onready var anim = $AnimationPlayer
@onready var sprite = $TodosLosSpritesDeOndu


func _physics_process(delta):

	
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
