extends Particles2D

# class member variables go here, for example:
var effectlen = 0.2
var effectlin = 0.5 # effect linger
var counter = 0

var movement

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	set_process(true)

func _process(delta):
	get_node(".").translate(movement * delta)
	counter += delta
	if(counter > effectlen):
		set_emitting(false)
	if(counter > effectlen + effectlin):
		queue_free()
		
func init(motion):
	movement = motion