extends WorldEnvironment


# Declare member variables here. Examples:
var rng = RandomNumberGenerator.new()
var degree = 0
var color_delta = 0.05
var r = 0
# var green = Color(0.28, 0.48, 0.21, 1)
# var orange = Color(1.28, 0.48, 0.21, 1)
# var spooky_red =  Color(1.28, 0.11, 0.15, 1)
# var blue = Color(0.15, 11, 1.28, 1)

# Called when the node enters the scene tree for the first time.
func _ready():
	rng.randomize()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	degree = degree % 360
	r = sin(deg2rad(degree)) * color_delta
	self.get_environment().background_color = Color(0.13 + r, 0.02 + r, 0.23 + r, 1)
	# self.get_environment().ambient_light_color  = Color(0.1 + r, 0.06 + r, 0.06 + r, 1)
	r *= 2
	get_node("DirectionalLight").light_color = Color(1.28 + r, 0.48 + r, 0.21 + r, 1)
	degree += 1
