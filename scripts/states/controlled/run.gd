extends ControlledState
class_name PlayerRun

func Exit():
	pass
func Enter():
	if not entity: return
	entity.updatePlayerProperty('logic_state',self)
	entity.playAnimation('run')
func Update(delta: float):
	if not entity: return

	updateInputs()

	if !down and !left and !right and !up:
		Transition.emit(self, 'idle')

func PhysicsUpdate(delta: float):
	if not entity: return
	entity.controlledNavigate(delta,Enum.SPEEDTYPES.FORWARD,100,20)
