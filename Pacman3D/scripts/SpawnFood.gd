extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var fll = get_node("/root/Map/FoodLeftLabel")
var isFoodLoaded = false
# Called when the node enters the scene tree for the first time.
func load_food():
	var scene = load("res://environment/Food.tscn");
	for i in range(7):
		# TODO: add food on right places
		var food = scene.instance();
		food.transform.origin = Vector3(-1.5, 0.3, 8.5-1*i);
		add_child(food);
		Global.N_food += 1;
		fll.text = str(Global.get_food_left()) + " food left";

	for i in range(7):
		var food = scene.instance();
		add_child(food);
		food.transform.origin = Vector3(-1.5, 0.3, -11.5+1*i);
		Global.N_food += 1;
		fll.text = str(Global.get_food_left()) + " food left";
		
func _ready():
	if not isFoodLoaded:
		load_food();
		isFoodLoaded = true;

