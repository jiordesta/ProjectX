extends ControlledState
class_name PlayerRun

func Exit():
	pass
func Enter():
	if not entity: return
	entity.currentLogicState = self
func Update(delta: float):
	if not entity: return

	updateInputs()

	if down || left || right || up:
		if up:
			direction.y -= 1
		if down:
			direction.y += 1
		if left:
			direction.x -= 1
		if right:
			direction.x += 1
	else:
		Transition.emit(self, 'idle')
func PhysicsUpdate(delta: float):
	if not entity: return
	entity.navigate(direction,delta,Enum.ModifySpeedTypes.FORWARD,100,20)
