extends  Node
class_name StateMachine

var logic = {
	'current_state': null,
	'states': {}
}

func initializeLogicStateMachine(states, initial):
	for state in states:
		var new_state: State = state.value.new()
		new_state.entity = get_parent()
		new_state.name = state.label
		$Logic.add_child(new_state)
	for child in $Logic.get_children():
		if(child is State):
			logic['states'][child.name.to_lower()] = child
			child.Transition.connect(logicStateTransitioned)
	logic['current_state'] = logic['states'][initial]
	logic['current_state'].Enter()
func _process(delta):
	if not logic['current_state']: return
	logic['current_state'].Update(delta)
func _physics_process(delta):
	if not logic['current_state']: return
	logic['current_state'].PhysicsUpdate(delta)
func logicStateTransitioned(state, new_state_name): 
	if state != logic['current_state']: return
	var new_state: State = logic['states'].get(new_state_name.to_lower())
	if !new_state: return
	if logic['current_state']: logic['current_state'].Exit()
	logic['current_state'] = new_state
	logic['current_state'].Enter()
