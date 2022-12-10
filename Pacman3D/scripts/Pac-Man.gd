extends KinematicBody

var velocity = Vector3(0,0,0)
var MAX_VELOCITY = 2
var mouse_sensitivity = 0.1

var direction = Vector3()
onready var head = $Head
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
# https://www.youtube.com/watch?v=Nn2mi5sI8bM
func _input(event):
	if event is InputEventMouseMotion:
		rotate_y(deg2rad(-event.relative.x * mouse_sensitivity))
		head.rotate_x(deg2rad(-event.relative.y * mouse_sensitivity))
		head.rotation.x = clamp(head.rotation.x, deg2rad(-89), deg2rad(89))
		
func _physics_process(delta):
	# diagonal movement?
	direction = Vector3()
	
	if Input.is_action_pressed("ui_up"):
		direction.z += MAX_VELOCITY
	elif Input.is_action_pressed("ui_down"):
		direction.z -= MAX_VELOCITY
	elif Input.is_action_pressed("ui_left"):
		direction.x -= MAX_VELOCITY
	elif Input.is_action_pressed("ui_right"):
		direction.x += MAX_VELOCITY
	
	move_and_slide(direction)
	
