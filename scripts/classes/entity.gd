extends RigidBody2D
class_name Entity

@export var player_stats := {
	'intelligence': 0,
	'strength': 0,
	'agility': 0,
	'health': 0,
	'energy':0,
	'mana':0,
	'speed':0,
}

@export var player_properties = {
	'direction':Vector2.ZERO,
	'multiplier':0,
	'logic_state': null
}

@onready var player_nodes = {
	'animation_player': null,
	'state_machine': null,
	'camera': null,
	'textures': null,
	'item': null
}

func initializeEntity(nodes, stats, states):
	initializedStats(stats)
	initializeNodes(nodes)
	initializeStateMachine(states)
	print(player_nodes)
	print(player_properties)
	print(player_stats)
func initializeStateMachine(states):
	var state_machine = player_nodes['state_machine']
	if !state_machine: return
	state_machine.initializeStates(states,'idle')
func initializeNodes(nodes):
	for key in nodes.keys():
		updateNodes(key,nodes[key])
func playAnimation(anim_name: String):
	var animation_player = player_nodes['animation_player']
	if !animation_player: return
	animation_player.play(anim_name)
func getPlayerNode(key: String):
	return player_nodes[key]
func initializedStats(stats:Dictionary):
	for key in stats.keys():
		updateStats(key,stats[key],Enum.STATACTIONS.RESET)
func updateNodes(key:String, value):
	player_nodes[key] = value
func updateStats(key:String, value:int, action:int):
	if(action == Enum.STATACTIONS.INCREASE):
		player_stats[key] += value
	if(action == Enum.STATACTIONS.DECREASE):
		player_stats[key] -= value
	if(action == Enum.STATACTIONS.RESET):
		player_stats[key] = value
func getPlayerStat(key: String):
	return player_stats[key]
func getPlayerAllStat():
	return player_stats
func updatePlayerProperty(key:String, value):
		player_properties[key] = value
func getPlayerProperty(key:String):
	return player_properties[key]
func getAllPlayerProperty():
	return player_properties
func getSteer(pos):
	var desired_velocity = Vector2(pos).normalized()
	var steer_value = desired_velocity - player_properties['direction']
	var steering_force = 0.04
	return player_properties['direction'] + (steer_value * steering_force)
func flipPlayerBody(scalex):
	var texture = getPlayerNode('textures')
	if !texture: return
	texture.scale.x = scalex
func modifySpeed(type, max, step):
	if type == Enum.SPEEDTYPES.FORWARD:
		if player_properties['multiplier'] < max:
			player_properties['multiplier'] += step
		return
	if type == Enum.SPEEDTYPES.BACKWARD:
		if player_properties['multiplier'] > -max:
			player_properties['multiplier'] -= step
		return
	if type == Enum.SPEEDTYPES.STOP:
		if player_properties['multiplier'] > 0:
			if player_properties['multiplier'] < 10:
				player_properties['multiplier'] = 0
			player_properties['multiplier'] -= step
			return
		if player_properties['multiplier'] < 0:
			if player_properties['multiplier'] > -10:
				player_properties['multiplier'] = 0
			player_properties['multiplier'] += step
			return
func uncontrolledNavigate(val, delta, type, max, step):
	modifySpeed(type, max, step)
	if type != Enum.ModifySpeedTypes.STOP:
		player_properties['direction'] = getSteer(val)
	linear_velocity = (
		Vector2(player_stats['speed'] * player_properties['multiplier'],0) * delta).rotated(player_properties['direction'].angle())
func controlledNavigate(delta, type, max, step):
	modifySpeed(type, max, step)
	linear_velocity = (Vector2(player_stats['speed'] * player_properties['multiplier'],0) * delta).rotated(player_properties['direction'].angle())
func instantSpeedChange(speed):
	linear_velocity = (Vector2(speed,0)).rotated(player_properties['direction'].angle())
