extends Node


static func getLocalFromGlobalCoord(global):
	var local = Vector3();
	local.x = int((abs(global.x+11.8)/(11.8+7.8))*20)
	local.y = global.y
	local.z = int((abs(global.z+10.8)/(10.8+7.8))*19)
	return local

static func getGlobalFromLocalCoord(local):
	var global = Vector3();
	global.x = local.x*((11.8+7.8)/19) -11.8
	global.y = local.y
	global.z = (local.z)*((10.8+7.8)/18) -10.8
	return global


func _ready():
	pass # Replace with function body.
