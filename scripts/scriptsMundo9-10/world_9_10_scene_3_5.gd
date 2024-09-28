extends Node2D

#mariposas
@onready var mariposa1Anim = $mariposa/AnimationPlayer
@onready var mariposa2Anim = $mariposa2/AnimationPlayer
@onready var mariposa3Anim = $mariposa3/AnimationPlayer
@onready var mariposa4Anim = $mariposa4/AnimationPlayer
@onready var mariposa5Anim = $mariposa5/AnimationPlayer

func _ready():
	mariposa1Anim.play("volandoArriba")
	mariposa2Anim.play("volandoArriba")
	mariposa3Anim.play("volandoArriba")
	mariposa4Anim.play("volandoArriba")
	mariposa5Anim.play("volandoArriba")

func _process(delta):
	pass
