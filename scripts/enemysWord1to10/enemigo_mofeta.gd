extends Area2D
#al tocar la mofeta te quita 5 de vida
#el pedo de la mofeta te quita 25 de vida

@onready var sprite = $SpritesMofeta
@onready var anim = $AnimationPlayer
@onready var colisionesPedo = $areaPedo/colisionPedo

#velocidad y recorrido de la mofeta
var move_speed = 100
var move_distance = 100
var start_position = Vector2.ZERO 

#variables para que haga una animacion u otra
var run = false
var idle = false
var pedos = false

var waitIdle = 0
var waitPedos = 0

var direction = 1
var initial_position

func _ready():
	initial_position = position
	run = true
	colisionesPedo.disabled = true
	$CollisionShape2D.connect("body_entered", Callable(self, "_on_body_entered"))

func _process(delta):
	if run:
		position.x += direction * move_speed * delta
		anim.play("run")
		colisionesPedo.disabled = true
	
	if position.x > initial_position.x + move_distance:
		sprite.flip_h = true
		direction = -1
		move_speed = 0
		run = false
		idle = true
		pedos = false

	if idle:
		anim.speed_scale = 1.5
		anim.play("idle")
		colisionesPedo.disabled = true
		waitIdle += 1
		if waitIdle > 150:
			idle = false
			run = true
			move_speed = 100
			anim.speed_scale = 4
			pedos = false
			waitIdle = 0



	elif position.x < initial_position.x - move_distance:
		sprite.flip_h = false
		direction = 1
		move_speed = 0
		run = false
		idle = false
		pedos = true

	if pedos:
		anim.speed_scale = 3
		anim.play("pedos")
		colisionesPedo.disabled = false
		waitPedos += 1
		if waitPedos > 100:
			pedos = false
			idle = false
			run = true
			move_speed = 100
			anim.speed_scale = 4
			waitPedos = 0




func _on_body_entered(body):
	if body.is_in_group("fireball"):
		Global.insideEnemy = true
		call_deferred("queue_free")
		
