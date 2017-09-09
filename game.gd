extends Node2D

var player
var gun
var dust
var bulletobj
var guneffectobj
var soundplayer

var minjoy = 0.1

var velo = 0
var vec = Vector2(0,0)
var joymag = Vector2(0,0)
var rotation = 0
var ppos = Vector2(0,0)

var nowsound = ""
var lastsound = ""

var gunrot = 0
var gunvec = Vector2(0,0)

var start = 0.1
var traction = 6
var gain = 3
var speed = 100
var maxspeed = 2
var cone = PI/2

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	player = get_node("player/body")
	gun = get_node("player/gun")
	dust = get_node("player/dust")
	soundplayer = get_node("soundplayer")
	bulletobj = load("res://bullet.tscn")
	guneffectobj = load("res://guneffect.tscn")
	set_process(true)
	set_process_input(true)

func _input(event):
	if(event.is_action_pressed("attack")):
		var newBullet = bulletobj.instance()
		add_child(newBullet)
		newBullet.init(gunvec)
		newBullet.set_pos(ppos)
		newBullet.set_rot(gunrot)
		get_node("gunanimator").play("shoot")
		var newGunEffect = guneffectobj.instance()
		add_child(newGunEffect)
		newGunEffect.set_pos(ppos)
		newGunEffect.set_rot(gunrot - PI)
		get_node("gunplayer").play("gun")
		
func _process(delta):
	ppos = player.get_pos()
	var joy = Vector2(Input.get_joy_axis(0,0), Input.get_joy_axis(0,1))
	var gunjoy = Vector2(Input.get_joy_axis(0,2), Input.get_joy_axis(0,3))
		# player movement
	if(abs(joy.x) > minjoy or abs(joy.y) > minjoy):
		if(velo <= 0):
			velo = start 
		if(velo < maxspeed * (abs(joy.x) + abs(joy.y))):
			velo += (abs(joy.x) + abs(joy.y)) * delta * gain
	elif(velo > 0):
		velo -= traction * delta * velo
		get_node("animator").play("body")
	else:
		velo = 0
	if(abs(joy.x) > minjoy or abs(joy.y) > minjoy):
		joymag = joy.length()
		vec = joy.normalized()
		rotation = vec.angle() + PI
		nowsound = "move"
	else:
		nowsound = "idle"
	
	if(nowsound != lastsound):
		lastsound = nowsound
		soundplayer.stop_all()
	if(not soundplayer.is_active()):
		soundplayer.play(nowsound)
	
	if(velo > 0):
		ppos.x += vec.x * speed * velo * delta
		ppos.y += vec.y * speed * velo * delta
	
	if(velo < 0.1):
		dust.set_amount(10)
		dust.set_param(1, 180)
		
	else:
		dust.set_amount(20)
		dust.set_param(1, 50)
		
		# gun
	if(abs(gunjoy.x) > minjoy or abs(gunjoy.y) > minjoy):
		gunvec = gunjoy.normalized()
		gunrot = gunvec.angle() + PI
		
		
		
	player.set_pos(ppos)
	player.set_rot(rotation)
	gun.set_pos(ppos)
	gun.set_rot(gunrot)
	dust.set_emissor_offset(Vector2(ppos.x/4, ppos.y/4))
	dust.set_param(0, 180 * rotation / PI)