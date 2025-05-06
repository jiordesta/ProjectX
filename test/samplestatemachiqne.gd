extends StateMachine

@onready var states = [
	{'label':'idle','value':PlayerIdle},
	{'label':'run','value':PlayerRun},
	{'label':'dash','value':PlayerDash}
]

func _ready() -> void:
	initializeLogicStateMachine(states,'idle')
