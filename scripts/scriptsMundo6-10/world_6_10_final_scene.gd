extends Node2D

@onready var mariposa1 = $mariposa/AnimationPlayer
@onready var mariposa2 = $mariposa2/AnimationPlayer

func _ready():
	mariposa1.play("volandoAbajo")
	mariposa2.play("volandoArriba")


func _process(delta):
	pass
