extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

# movement rules:
	# when a button is pressed, velocity is immediately set to startspeed, then increases by speed.to maxspeed
	# when the button is released, velocity imediately goes to dropspeed and decreases by traction

var velo = 0
var maxspeed = 1
var startspeed = 0.3
var dropspeed = 0.5
var speed = 0.1
var traction = 0.1

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass
