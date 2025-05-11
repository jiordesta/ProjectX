extends ControlledState
class_name PlayerDash
const DASH_TIME = 0.25
var time = DASH_TIME

func Exit():
	pass
func Enter():
	if not entity: return
	entity.updatePlayerProperty('logic_state',self)
	entity.playAnimation('roll')
	time = DASH_TIME
	var direction = entity.getPlayerProperty('direction')
	if direction.x > 0:
		entity.flipPlayerBody(1)
	if direction.x < 0:
		entity.flipPlayerBody(-1)
func Update(delta: float):
	if not entity: return
	time -= delta

	if time <= 0:
		Transition.emit(self, 'idle')
func PhysicsUpdate(delta: float):
	if not entity: return
	entity.instantSpeedChange(250)
