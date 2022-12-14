extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var score = 0
var N_food = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	print("I'm the Global ready function")
	
	pass # Replace with function body.
func increment():
	score+=1;

func get_score() -> int:
	return score;

func get_food_left() -> int:
	return N_food - score;
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
