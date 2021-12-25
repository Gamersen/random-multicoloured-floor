extends KinematicBody

const GRAVITY = -20
const MOVESPEED = 20
const TURNAMOUNT = deg2rad(1) #in degrees

var velocity = Vector3.ZERO

var currentCam = 1

func _ready():
	pass 

func _physics_process(delta):
	
	var collision = move_and_collide(velocity)
	velocity = Vector3.ZERO
	var directionVector = Vector3.ZERO
	var thetaY = get_rotation().y
	
	#Are we on the floor? If yes, don't push us into it.
	if collision:
		velocity.y = 0
	else:
		velocity.y = GRAVITY
	
	#Turning
	if Input.is_action_pressed("ui_left"):
		set_rotation(Vector3(0,(thetaY+TURNAMOUNT),0))
	elif Input.is_action_pressed("ui_right"):
		set_rotation(Vector3(0,(thetaY-TURNAMOUNT),0))
	
	#Finding DirectionVector, which way character is looking.
	if (thetaY < deg2rad(90)) || (thetaY > deg2rad(-90)): #if thetaY is between -90 and 90
		directionVector.x = cos(thetaY)
		directionVector.z = -sin(thetaY)
	elif (thetaY < deg2rad(180)) || (thetaY > deg2rad(-180)): #if thetaY is between -180 and 180. This exists in case thetaY is greater than the parameters. It shouldn't be but if it is, the next else statement catches.
		directionVector.z = cos(thetaY)
		directionVector.x = sin(thetaY)
	else:
		print("Y rotation is an unanticipated value.")
		
	#Finding Velocity
	if Input.is_action_pressed("ui_up"):
		velocity += directionVector.normalized() * MOVESPEED
	elif Input.is_action_pressed("ui_down"):
		velocity += directionVector.normalized() * -MOVESPEED
	
	velocity *= delta

func _input(event):
	if event.is_action_pressed("ui_accept"):
		#swaps current camera
		currentCam *= -1
		if currentCam == 1:
			get_node("Camera").set_current(true)
		else:
			get_node("Camera2").set_current(true)
	if event.is_action_pressed("ui_end"):
		translate(Vector3(0,20,0))
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
