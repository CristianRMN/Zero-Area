extends Area2D

@export var move_speed = 30 
@export var move_distance = 30
@export var start_position = Vector2.ZERO 
@onready var animMove = $Anim
@onready var sprite = $"Monito"

var direction = 1
var initial_position

func _ready():
	initial_position = position
	$CollisionShape2D.connect("body_entered", Callable(self, "_on_body_entered"))

func _process(delta):
	# Mover la plataforma hacia arriba y hacia abajo
	position.x += direction * move_speed * delta
	animMove.play("caminar")
	
	# Cambiar la dirección al alcanzar la distancia máxima
	if position.x > initial_position.x + move_distance:
		sprite.flip_h = false
		direction = -1
	elif position.x < initial_position.x - move_distance:
		sprite.flip_h = true
		direction = 1


func _on_body_entered(body):
	if body.is_in_group("fireball"):
		animMove.play("muerte")
		sprite.hide()
		call_deferred("queue_free")
		
