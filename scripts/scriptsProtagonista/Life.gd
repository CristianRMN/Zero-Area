extends Node2D

var max_health = 100
var current_health = max_health



func _on_ready():
	update_health_bar()


func decrease_health(amount):
	current_health -= amount
	if current_health < 0:
		current_health = 0
	update_health_bar()

func increase_health(amount):
	current_health += amount
	if current_health > max_health:
		current_health = max_health
	update_health_bar()

func update_health_bar():
	if Life:
		print("hay vida")
	else:
		print("No se encontró")
