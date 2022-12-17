extends WorldEnvironment


# Declare member variables here. Examples:
var degree = 0
var color_delta = 0.05
var df = 2 # directional factor
var af = 0.33 # ambiental factor
var c = 0
var background
var base_color
var	color
var blue_hunter_color = Color(0.29, 0.46, 0.83, 1)
# var green = Color(0.28, 0.48, 0.21, 1)
# var orange = Color(1.28, 0.48, 0.21, 1)
# var spooky_red =  Color(1.28, 0.11, 0.15, 1)


# Called when the node enters the scene tree for the first time.
func _ready():
	background = self.get_environment().background_color
	base_color = get_node("DirectionalLight").light_color
	color = base_color


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	degree = degree % 360
	c = sin(deg2rad(degree)) * color_delta
	self.get_environment().background_color = Color(background.r + c, background.g + c, background.b + c, 1)
	self.get_environment().ambient_light_color = Color(0.1 + c * af, 0.06 + c * af, 0.06 + c * af, 1)
	get_node("DirectionalLight").light_color = Color(color.r + c * df , color.g + c * df, color.b + c * df, 1)
	degree += 1

func switch_colorscheme():
	color = blue_hunter_color if color == base_color else base_color
