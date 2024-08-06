extends Area2D


var move_speed = 60 
var move_distance = 90
var start_position = Vector2.ZERO 
@onready var animMove = $AnimationPlayer
@onready var sprite = $"SpritesArdilla"

var direction = 1
var initial_position

func _ready():
	initial_position = position


func _process(delta):
	
	if animMove.current_animation == "walk":
		position.x += direction * move_speed * delta
		if position.x > initial_position.x + move_distance:
			sprite.flip_h = true
			direction = -1
		elif position.x < initial_position.x - move_distance:
			sprite.flip_h = false
			direction = 1
	





