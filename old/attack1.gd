extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

# when active, start decrementing counter by deltatime. 
# when counter is <= 0, set back to speed. 
# constantly decrement activecounter by deltatime.


var active = false
var speed = 1
var counter = speed # period inbetween attacks (in seconds)
var length = 120
var activecounter = length # potion length

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass
