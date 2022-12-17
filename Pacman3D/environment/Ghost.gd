extends KinematicBody


var speed = 2
func _ready():
	pass # Replace with function body.

func _process(delta):
	var loc = self.transform.origin 
	var direction;
	var goal = Vector3(0, loc.y, 0)
	if loc.distance_to(goal) > 0.05:
		direction = goal - loc;
		direction = direction.normalized() * speed;
	else:
		direction = goal - loc;
	move_and_slide(direction);
	
