extends RigidBody2D
class_name Entity

@onready var currentLogicState: State

@export var stats := {
	'intelligence': 0,
	'strength': 0,
	'agility': 0,
	'health': 0,
	'energy':0,
	'mana':0,
	'speed':0,
}

@export var property = {
	'direction':Vector2.ZERO,
	'multiplier':0
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
func getSteer(pos):
	var desired_velocity = Vector2(pos).normalized()
	var steer_value = desired_velocity - property['direction']
	var steering_force = 0.04
	return property['direction'] + (steer_value * steering_force)
func modifySpeed(type, max, step):
	if type == Enum.ModifySpeedTypes.FORWARD:
		if property['multiplier'] < max:
			property['multiplier'] += step
		return
	if type == Enum.ModifySpeedTypes.BACKWARD:
		if property['multiplier'] > -max:
			property['multiplier'] -= step
		return
	if type == Enum.ModifySpeedTypes.STOP:
		if property['multiplier'] > 0:
			if property['multiplier'] < 10:
				property['multiplier'] = 0
			property['multiplier'] -= step
			return
		if property['multiplier'] < 0:
			if property['multiplier'] > -10:
				property['multiplier'] = 0
			property['multiplier'] += step
			return
func navigate(val, delta, type, max, step):
	modifySpeed(type, max, step)
	if type != Enum.ModifySpeedTypes.STOP:
		property['direction'] = getSteer(val)
	linear_velocity = (Vector2(stats['speed'] * property['multiplier'],0) * delta).rotated(property['direction'].angle())
func instantSpeedChange(direction):
	property['direction'] = direction
	linear_velocity = (Vector2(900,0)).rotated(property['direction'].angle())
		
		
		
		
		
		
		
		
		
		
		
		
