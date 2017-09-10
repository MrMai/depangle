extends Node2D

# class member variables go here, for example:
var travel = Vector2(0,0)
var speed = 800

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	set_process(true)
	
func _process(delta):
	translate(travel * speed * delta)

func init(input):
	travel = input