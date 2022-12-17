extends KinematicBody


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var speed = 2
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var loc = self.transform.origin 
	var direction;
	var goal = Vector3(Global.player_location.x, loc.y, Global.player_location.z)
	if loc.distance_to(goal) > 0.05:
		direction = goal - loc;
		direction = direction.normalized() * speed;
	else:
		direction = goal - loc;		
	move_and_slide(direction);
	
