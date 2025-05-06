extends ControlledState
class_name PlayerIdle

func Exit():
	pass
func Enter():
	if not entity: return
	entity.currentLogicState = self
func Update(delta: float):
	if not entity: return
	updateInputs()
	if down || left || right || up:
		Transition.emit(self, 'run')
func PhysicsUpdate(delta: float):
	if not entity: return
	entity.navigate(Vector2.ZERO,delta,Enum.ModifySpeedTypes.STOP,100,20)
