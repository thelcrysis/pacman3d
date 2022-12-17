extends KinematicBody
const PF = preload("res://scripts/PathFinding.gd")

var speed = 2
func _ready():
	var mat = self
	pass # Replace with function body.

func _process(delta):
	var loc = self.transform.origin
	var direction;
	
	var my_local_loc = PF.getLocalFromGlobalCoord(loc)
	Global.blinky_local_loc = my_local_loc;
	
	var player_local_loc = Global.player_local_location
	var home = Vector2(19,0) # right upper corner
	var goal_local_loc; 
	var goal_global_loc;

	if Global.current_phase == Global.Phase.CHASE:
		goal_local_loc = player_local_loc
		goal_global_loc = PF.getGlobalFromLocalCoord(player_local_loc,loc.y);		
	elif Global.current_phase == Global.Phase.FRIGHTENED:
		goal_local_loc = home
		goal_global_loc = PF.getGlobalFromLocalCoord(home, loc.y)
		
	var goal;
	if my_local_loc.distance_to(goal_local_loc) > 2:
		# caluclate BFS path
		goal_global_loc = PF.getGlobalFromLocalCoord(PF.getFirstDirectionChangeLocation(my_local_loc, goal_local_loc),loc.y);
		
	# fixes the move and slide jitter
	if loc.distance_to(goal_global_loc) > 0.05:
		direction = goal_global_loc - loc;
		direction = direction.normalized() * speed;
	else:
		direction = goal_global_loc - loc;
		
	# COLLISION HANDLING
	var coll = get_last_slide_collision();
	if coll != null and get_last_slide_collision().collider.name == 'Steve':
		if Global.current_phase == Global.Phase.CHASE:
			Global.remove_life()
	if Global.lives != 0 and Global.get_food_left() > 0:
		move_and_slide(direction);
	
