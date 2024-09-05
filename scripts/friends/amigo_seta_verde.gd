extends Area2D

@onready var setaAnim = $AnimationPlayer


func _ready():
	setaAnim.play("idle")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
