extends RigidBody


onready var flLabel = get_node("/root/Map/FoodLeftLabel");

func _ready():
	pass # Replace with function body.

func _on_Food_body_entered(body):
	
	if body.name == "Steve" or body.name == "Food":
		Global.increment();
		if Global.get_food_left() != 0:
			# else Global sets label to elapsed time
			flLabel.text = str(Global.get_food_left()) + " food left";
		queue_free();
