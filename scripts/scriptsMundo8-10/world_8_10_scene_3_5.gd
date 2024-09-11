extends Node2D
@onready var mariposaAnim1 = $mariposa/AnimationPlayer


func _ready():
	mariposaAnim1.play("volandoArriba")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
