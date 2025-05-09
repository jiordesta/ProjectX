extends Entity

@export var some_stats = {
	'intelligence': 10,
	'strength': 110,
	'agility': 230,
	'health': 330,
	'energy':4210,
	'mana':120,
	'speed':25,
}

func _ready() -> void:
	initializedStats(some_stats)
	
func _process(delta: float) -> void:
	if(!currentLogicState): return
	$Label.text = currentLogicState.name
