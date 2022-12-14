extends Node

onready var fll = get_node("/root/Map/FoodLeftLabel")
var food_locations = [[-11.5, -10.5], [-10.5, -10.5], [-9.5, -10.5], [-7.5, -10.5], [-6.5, -10.5], [-5.5, -10.5], [-1.5, -10.5], [2.5, -10.5], [3.5, -10.5], [4.5, -10.5], [5.5, -10.5], [6.5, -10.5], [7.5, -10.5], [-11.5, -9.5], [-9.5, -9.5], [-8.5, -9.5], [-7.5, -9.5], [-5.5, -9.5], [-1.5, -9.5], [2.5, -9.5], [4.5, -9.5], [7.5, -9.5], [-11.5, -8.5], [-9.5, -8.5], [-5.5, -8.5], [-1.5, -8.5], [2.5, -8.5], [4.5, -8.5], [7.5, -8.5], [-11.5, -7.5], [-9.5, -7.5], [-8.5, -7.5], [-7.5, -7.5], [-6.5, -7.5], [-5.5, -7.5], [-4.5, -7.5], [-3.5, -7.5], [-2.5, -7.5], [-1.5, -7.5], [-0.5, -7.5], [0.5, -7.5], [1.5, -7.5], [2.5, -7.5], [3.5, -7.5], [4.5, -7.5], [5.5, -7.5], [6.5, -7.5], [7.5, -7.5], [-11.5, -6.5], [-7.5, -6.5], [-5.5, -6.5], [-1.5, -6.5], [4.5, -6.5], [7.5, -6.5], [-11.5, -5.5], [-9.5, -5.5], [-8.5, -5.5], [-7.5, -5.5], [-5.5, -5.5], [-4.5, -5.5], [-3.5, -5.5], [-2.5, -5.5], [-1.5, -5.5], [-0.5, -5.5], [0.5, -5.5], [2.5, -5.5], [3.5, -5.5], [4.5, -5.5], [7.5, -5.5], [-11.5, -4.5], [-9.5, -4.5], [-7.5, -4.5], [-5.5, -4.5], [-3.5, -4.5], [0.5, -4.5], [2.5, -4.5], [4.5, -4.5], [7.5, -4.5], [-11.5, -3.5], [-9.5, -3.5], [-7.5, -3.5], [-5.5, -3.5], [-3.5, -3.5], [0.5, -3.5], [2.5, -3.5], [4.5, -3.5], [7.5, -3.5], [-11.5, -2.5], [-10.5, -2.5], [-9.5, -2.5], [-7.5, -2.5], [-6.5, -2.5], [-5.5, -2.5], [-3.5, -2.5], [0.5, -2.5], [1.5, -2.5], [2.5, -2.5], [4.5, -2.5], [5.5, -2.5], [6.5, -2.5], [7.5, -2.5], [-11.5, -1.5], [-7.5, -1.5], [-3.5, -1.5], [0.5, -1.5], [4.5, -1.5], [-11.5, -0.5], [-10.5, -0.5], [-9.5, -0.5], [-7.5, -0.5], [-6.5, -0.5], [-5.5, -0.5], [-3.5, -0.5], [0.5, -0.5], [1.5, -0.5], [2.5, -0.5], [4.5, -0.5], [5.5, -0.5], [6.5, -0.5], [7.5, -0.5], [-11.5, 0.5], [-9.5, 0.5], [-7.5, 0.5], [-5.5, 0.5], [-3.5, 0.5], [0.5, 0.5], [2.5, 0.5], [4.5, 0.5], [7.5, 0.5], [-11.5, 1.5], [-9.5, 1.5], [-7.5, 1.5], [-5.5, 1.5], [-3.5, 1.5], [0.5, 1.5], [2.5, 1.5], [4.5, 1.5], [7.5, 1.5], [-11.5, 2.5], [-9.5, 2.5], [-8.5, 2.5], [-7.5, 2.5], [-5.5, 2.5], [-4.5, 2.5], [-3.5, 2.5], [-2.5, 2.5], [-1.5, 2.5], [-0.5, 2.5], [0.5, 2.5], [2.5, 2.5], [3.5, 2.5], [4.5, 2.5], [7.5, 2.5], [-11.5, 3.5], [-7.5, 3.5], [-5.5, 3.5], [-1.5, 3.5], [4.5, 3.5], [7.5, 3.5], [-11.5, 4.5], [-9.5, 4.5], [-8.5, 4.5], [-7.5, 4.5], [-6.5, 4.5], [-5.5, 4.5], [-4.5, 4.5], [-3.5, 4.5], [-2.5, 4.5], [-1.5, 4.5], [-0.5, 4.5], [0.5, 4.5], [1.5, 4.5], [2.5, 4.5], [3.5, 4.5], [4.5, 4.5], [5.5, 4.5], [6.5, 4.5], [7.5, 4.5], [-11.5, 5.5], [-9.5, 5.5], [-5.5, 5.5], [-1.5, 5.5], [2.5, 5.5], [4.5, 5.5], [7.5, 5.5], [-11.5, 6.5], [-9.5, 6.5], [-8.5, 6.5], [-7.5, 6.5], [-5.5, 6.5], [-1.5, 6.5], [2.5, 6.5], [4.5, 6.5], [7.5, 6.5], [-11.5, 7.5], [-10.5, 7.5], [-9.5, 7.5], [-7.5, 7.5], [-6.5, 7.5], [-5.5, 7.5], [-1.5, 7.5], [2.5, 7.5], [3.5, 7.5], [4.5, 7.5], [5.5, 7.5], [6.5, 7.5], [7.5, 7.5]]
var isFoodLoaded = false

func load_food():
	var scene = load("res://environment/Food.tscn");	
	for loc in food_locations:
		var x = loc[0];
		var z = loc[1];
		var food = scene.instance();
		food.transform.origin = Vector3(x, 0.3, z);
		add_child(food);
		Global.N_food += 1;
	fll.text = str(Global.get_food_left()) + " food left";

func _ready():
	if not isFoodLoaded:
		load_food();
		isFoodLoaded = true;

