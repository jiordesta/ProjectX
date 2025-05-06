extends ControlledState
class_name PlayerDash
const DASH_TIME = 0.09
var time = DASH_TIME

func Exit():
	pass
func Enter():
	if not entity: return
	entity.currentLogicState = self
	time = DASH_TIME
func Update(delta: float):
	if not entity: return
	time -= delta
	if time <= 0:
		Transition.emit(self, 'idle')
func PhysicsUpdate(delta: float):
	if not entity: return
	entity.instantSpeedChange(direction)
