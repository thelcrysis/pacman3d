extends Node
onready var fll = get_node("/root/Map/FoodLeftLabel")

var score = 0
var N_food = 0
var start_time = Time.get_ticks_msec();

var player_local_location;
var player_global_location;

var blinky_local_loc;
var inky_local_loc;
var pinky_local_loc;
var clyde_local_loc;


enum Phase {CHASE, FRIGHTENED};
var current_phase = Phase.CHASE;
var last_phase_change = Time.get_ticks_msec();

func time_to_str(time):
	# adds 0 if needed (from 0:0:3.342 to 00:00:03.342) 
	if time < 10:
		return "0" + str(time);
	else:
		return str(time)
		
func from_msec_to_humanreadable(msec_time):
	var msec = msec_time % 1000;
	var secs = (msec_time/1000)%60;
	var mins = (msec_time/1000/60);
	var format_str = "{mins}:{secs}.{msec}"
	return format_str.format({"mins":time_to_str(mins),"secs":time_to_str(secs),"msec":msec});

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	
func increment():
	score+=1;
	if (self.get_food_left() == 0):
		var end_time = Time.get_ticks_msec();
		var delta = end_time - start_time;
		print(from_msec_to_humanreadable(delta))
		fll.text = from_msec_to_humanreadable(delta);
		
func switch_phase():
	current_phase = (current_phase + 1)%2 # chase -> frightene -> chase
	print(current_phase)
	last_phase_change = Time.get_ticks_msec();

func get_score() -> int:
	return score;

func get_food_left() -> int:
	return N_food - score;
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
