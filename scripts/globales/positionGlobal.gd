extends Node

#referencia al jugador
var player:Node = null

#posicion del jugador
var player_position = Vector2()

#variable para hacer explotar la bola de fuego al chocar con enemigos
var insideEnemy = false

#tengo o no tengo la llave
var has_key = false

#numero de corazones dorados cogidos
var num_hearts_life_terapagos = 0

#valor de la vida de terapagos
var value_life_protagonist = 100

#variable booleana para saber si tengo la proteccion
var haveTheProtection = false

#variable para la velocidad de ondu
var speedOndu
var sprintOndu = 250

#variables booleanas para saber en que nivel estoy para aumentar la velocidad
var level1_10 = false
var level11_20 = false
var level21_30 = false
var level31_40 = false
var level41_50 = false
var level51_60 = false
var level61_70 = false
var level71_80 = false
var level81_90 = false
var level91_100 = false
var sprint = false

#ifs para establecer velocidades segun el nivel:
func giveValueSpeedOndu():
	if level1_10:
		speedOndu = 50
	elif level11_20:
		speedOndu = 55
	elif level21_30:
		speedOndu = 60
	elif level31_40:
		speedOndu = 65
	elif level41_50:
		speedOndu = 75
	elif level51_60:
		speedOndu = 85
	elif level61_70:
		speedOndu = 95
	elif level71_80:
		speedOndu = 100
	elif level81_90:
		speedOndu = 110
	elif level91_100:
		speedOndu = 118
	elif sprint:
		speedOndu = sprintOndu
		
	return speedOndu
	

#variable probar visibilidad llave

var keyHideRace = false

# Más adelante podremos añadir otros datos globales según avancemos
