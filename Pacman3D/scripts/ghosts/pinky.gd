extends KinematicBody
const PF = preload("res://scripts/PathFinding.gd")

var speed = 2
func _ready():
	pass # Replace with function body.

func funky_abs(vec:Vector2):
	# makes vec absoulte but with adding world x or y size
	var x = vec.x
	var y = vec.y
	while x < 0:
		x += 19
	while y < 0:
		y += 18
	return Vector2(x,y)
	
func calc_target(my_local_pos) -> Vector2:
	
	# calculates pinky target square
	var player = Global.player_local_location;
	var target = Vector2(0,0);
	if Global.player_direction == null:
		target = player
		return target
	target = Vector2(player.x+2*Global.player_direction.x,player.x+2*Global.player_direction.x)
		
	target = abs(target.x)
	target = abs(target.y)
	target.x = int(target.x) % 20
	target.y = int(target.y) % 19
	if PF.at(target) == 0: # wall tile
		target = PF.getClosestFloorLocation(target)
	return target
func _process(delta):
	var loc = self.transform.origin
	var direction;
	
	var my_local_loc = PF.getLocalFromGlobalCoord(loc)
	Global.inky_local_loc = my_local_loc;
	
	var player_local_loc = Global.player_local_location
	var home = Vector2(19,18) # right lower corner
	var goal_local_loc; 
	var goal_global_loc;

	if Global.current_phase == Global.Phase.CHASE:
		goal_local_loc = calc_target(player_local_loc)
		goal_global_loc = PF.getGlobalFromLocalCoord(calc_target(player_local_loc), loc.y);		
	elif Global.current_phase == Global.Phase.FRIGHTENED:
		goal_local_loc = home
		goal_global_loc = PF.getGlobalFromLocalCoord(home, loc.y)
		
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
		elif Global.current_phase == Global.Phase.FRIGHTENED:
			Global.increment_life()
	if Global.lives != 0 and Global.get_food_left() > 0:
		move_and_slide(direction);
	
