extends Area2D

#esta abeja quita 10 de vida



var move_speed = 120 
var move_distance = 120
var start_position = Vector2.ZERO 
@onready var animMove = $AnimationPlayer
@onready var sprite = $SpritesAbeja

var direction = 1
var initial_position

func _ready():
	initial_position = position
	$CollisionShape2D.connect("body_entered", Callable(self, "_on_body_entered"))
	sprite.flip_h = true

func _process(delta):
	# Mover la plataforma hacia arriba y hacia abajo
	position.x += direction * move_speed * delta
	animMove.play("attack")
	
	# Cambiar la dirección al alcanzar la distancia máxima
	if position.x > initial_position.x + move_distance:
		sprite.flip_h = false
		direction = -1
	elif position.x < initial_position.x - move_distance:
		sprite.flip_h = true
		direction = 1


func _on_body_entered(body):
	if body.is_in_group("fireball"):
		Global.insideEnemy = true
		call_deferred("queue_free")
		
		
