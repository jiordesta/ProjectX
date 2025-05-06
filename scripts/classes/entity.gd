extends RigidBody2D
class_name Entity

@export var stats := {
	'intelligence': 0,
	'strength': 0,
	'agility': 0,
	'health': 0,
	'energy':0,
	'mana':0,
	'speed':0,
}

func initializedStats(newStats:Dictionary):
	for stat in newStats.keys():
		updateStats(stat,newStats[stat],Enum.StatActions.RESET)
	print(stats)
func updateStats(key:String, value:int, action:int):
	if(action == Enum.StatActions.INCREASE):
		stats[key] += value
	if(action == Enum.StatActions.DECREASE):
		stats[key] -= value
	if(action == Enum.StatActions.RESET):
		stats[key] = value
		
