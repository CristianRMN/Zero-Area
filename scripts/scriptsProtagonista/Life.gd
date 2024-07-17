# LifeBar.gd
extends ProgressBar

func _ready():
	# Sincronizar la barra de vida con la variable global al inicio
	value = Global.value_life_protagonist

func heal(amount: int):
	var new_value = clamp(value + amount, 0, max_value)
	_animate_to(new_value)

func damage(amount: int):
	var new_value = clamp(value - amount, 0, max_value)
	_animate_to(new_value)

func _animate_to(new_value: int):
	var tween = create_tween()
	tween.tween_property(self, "value", new_value, 0.5)
	tween.finished.connect(_on_tween_finished)
	Global.value_life_protagonist = new_value

func _on_tween_finished():
	updateLife()

func updateLife():
	value = Global.value_life_protagonist
