extends KinematicBody

onready var camera = $Pivot/Camera

const PF = preload("res://scripts/PathFinding.gd")

var gravity = -30
var max_speed = 4
var mouse_sensitivity = 0.001  # radians/pixel

var velocity = Vector3()

# Called when the node enters the scene tree for the first time.
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED);

func get_input():
	var input_dir = Vector3()
	# desired move in camera direction
	if Input.is_action_pressed("move_forward"):
		input_dir += -global_transform.basis.z
	if Input.is_action_pressed("move_back"):
		input_dir += global_transform.basis.z
	if Input.is_action_pressed("strafe_left"):
		input_dir += -global_transform.basis.x
	if Input.is_action_pressed("strafe_right"):
		input_dir += global_transform.basis.x
	input_dir = input_dir.normalized()
	return input_dir

func _unhandled_input(event):
	if event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		rotate_y(-event.relative.x * mouse_sensitivity)
		$Pivot.rotate_x(-event.relative.y * mouse_sensitivity)
		$Pivot.rotation.x = clamp($Pivot.rotation.x, -1.2, 1.2)

func _physics_process(delta):
	var local = PF.getLocalFromGlobalCoord(self.transform.origin)
	Global.player_local_location = local;
	Global.player_global_location = self.transform.origin
	if Global.player_local_location != local:
		var d_x = local.x - Global.player_local_location.x 
		var d_y = local.y - Global.player_local_location.y 
		if d_x == 0 and d_y == 0:
			Global.player_direction = null
		elif abs(d_x) > abs(d_y):
			if d_x > 0:
				Global.player_direction = Vector2(1,0)
			else:
				Global.player_direction = Vector2(-1,0)
		elif abs(d_x) < abs(d_y):
			if d_y > 0:
				Global.player_direction = Vector2(0,1)
			else:
				Global.player_direction = Vector2(0,-1)
		Global.player_direction = local.player
		
	
	# wrong place for this :shrug:
	# CHANGES GAME PHASE -> SHOULD BE MOVED
	var current_time = Time.get_ticks_msec();
	# GAME PHASE SWITCHING
	var wait = 0
	if Global.last_phase_change == Global.Phase.CHASE:
		wait = 5
	else:
		wait = 5
	if current_time - Global.last_phase_change > wait*1000:
		Global.switch_phase();# chase -> frightened -> chase
	
	# PORTAL
	if self.transform.origin.z < -11.75:
		self.transform.origin.z = 8.5;
	if self.transform.origin.z > 8.75:
		self.transform.origin.z = -11.5;
	var desired_velocity = get_input() * max_speed
	var coll = get_last_slide_collision();
	velocity.x = desired_velocity.x
	velocity.z = desired_velocity.z
	
	if coll != null and get_last_slide_collision().collider.name in ["Blinky", "Pinky", "Inky", "Clyde"]:
		if Global.current_phase == Global.Phase.FRIGHTENED:
				Global.increment_life()
	if Global.lives > 0:
		velocity = move_and_slide(velocity, Vector3.UP, true)
