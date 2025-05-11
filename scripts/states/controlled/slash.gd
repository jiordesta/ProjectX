extends ControlledState
class_name PlayerSlash

var slash_time = 0

func Exit():
	pass
func Enter():
	if not entity: return
	entity.currentLogicState = self
	#entity.run_animation('idle')
func Update(delta: float):
	if not entity: return
	updateInputs()
	#if(entity.getItemCanAttack()):
		#Transition.emit(self,'idle')
func PhysicsUpdate(delta: float):
	if not entity: return
