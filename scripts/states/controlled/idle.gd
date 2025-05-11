extends ControlledState
class_name PlayerIdle

func Exit():
	pass
func Enter():
	if not entity: return
	entity.updatePlayerProperty('logic_state',self)
	entity.playAnimation('idle')
func Update(delta: float):
	if not entity: return
	updateInputs()
	if down || left || right || up:
		Transition.emit(self, 'run')
func PhysicsUpdate(delta: float):
	if not entity: return
	entity.controlledNavigate(delta,Enum.SPEEDTYPES.STOP,100,20)
