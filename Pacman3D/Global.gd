extends Node
onready var fll = get_node("/root/Map/FoodLeftLabel")
onready var helt = get_node("/root/Map/Helt")
onready var audiogood = get_node("/root/Map/goodsound")
onready var audiobad = get_node("/root/Map/badsound")

var score = 0
var N_food = 0
var start_time = Time.get_ticks_msec();

var player_local_location;
var player_global_location;
var player_direction = null;

var blinky_local_loc;
var inky_local_loc;
var pinky_local_loc;
var clyde_local_loc;

var lives = 3

enum Phase {CHASE, FRIGHTENED};
var current_phase = Phase.CHASE;
var last_phase_change = Time.get_ticks_msec();
var last_death = null;
var last_kill = null;
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

func visualize_lives():
	var out = "Lives:"
	if lives == 0:
		return "End game"
	for i in range(lives):
		out += " <3"
	return out
	
func _ready():
	helt.text = visualize_lives()
	
func increment():
	score+=1;
	if (self.get_food_left() == 0):
		var end_time = Time.get_ticks_msec();
		var delta = end_time - start_time;
		fll.text = from_msec_to_humanreadable(delta) + '\nWIN';

func remove_life():
	if last_death == null or Time.get_ticks_msec() - last_death > 3*1000:
		lives -= 1
		last_death = Time.get_ticks_msec()
	helt.text = visualize_lives()

func increment_life():
	if last_kill == null or Time.get_ticks_msec() - last_kill > 5*1000:
		last_kill = Time.get_ticks_msec() 
		lives += 1
		if lives > 3:
			lives = 3
	helt.text = visualize_lives()
	

func switch_phase():
	current_phase = (current_phase + 1)%2 # chase -> frightene -> chase
	last_phase_change = Time.get_ticks_msec();
	fll.text = str(Global.get_food_left()) + " food left\n";
	if Global.current_phase == Global.Phase.CHASE:
		audiobad.play()
		fll.text += "CHASE"
	elif Global.current_phase == Global.Phase.FRIGHTENED:
		audiogood.play()
		fll.text += "FRIGHTENED"
			
func get_score() -> int:
	return score;

func get_food_left() -> int:
	return N_food - score;
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
