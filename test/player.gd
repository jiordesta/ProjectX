extends Entity

const MAX_STATS = {
	'intelligence': 10,
	'strength': 110,
	'agility': 230,
	'health': 330,
	'energy':100,
	'mana':120,
	'speed':25,
}

@export var some_stats = {
	'intelligence': 10,
	'strength': 110,
	'agility': 230,
	'health': 330,
	'energy':100,
	'mana':120,
	'speed':25,
}

@onready var nodes = {
	'animation_player':$AnimationPlayer,
	'state_machine':$StateMachine,
	'camera':$CustomCamera,
	'textures':$Textures,
	'item':$Item
}

@onready var states = [
	{'label':'idle','value':PlayerIdle},
	{'label':'run','value':PlayerRun},
	{'label':'dash','value':PlayerDash},
	{'label':'slash','value':PlayerSlash}
]

func _ready() -> void:
	initializeEntity(nodes, some_stats, states)
