extends Area2D

#Este hipopotamo siempre quita 30 de vida
#este hipopotamo muere de 5 golpes

var move_speed = 40 
var move_distance = 60
var start_position = Vector2.ZERO 
var hitsToDie = 0
@onready var animMove = $AnimationPlayer
@onready var sprite = $"SpritesHipopotamo"

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
		sprite.flip_h = true
		direction = -1
	elif position.x < initial_position.x - move_distance:
		sprite.flip_h = false
		direction = 1


func _on_body_entered(body):
	if body.is_in_group("fireball"):
		Global.insideEnemy = true
		hitsToDie = hitsToDie + 1
		if hitsToDie == 5:
			call_deferred("queue_free")
		
		
