extends RigidBody


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
# Called when the node enters the scene tree for the first time.

onready var fll = get_node("/root/Map/FoodLeftLabel")

func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Food_body_entered(body):
	
	if body.name == "Steve":
		Global.increment();
		fll.text = str(Global.get_food_left()) + " food left";
		queue_free();
