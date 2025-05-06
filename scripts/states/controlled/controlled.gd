extends State
class_name ControlledState

var down = Input.is_action_pressed("ui_down")
var up = Input.is_action_pressed("ui_up")
var right = Input.is_action_pressed("ui_right")
var left = Input.is_action_pressed("ui_left")

func updateInputs():
	direction = Vector2.ZERO
	down = Input.is_action_pressed("ui_down")
	up = Input.is_action_pressed("ui_up")
	right = Input.is_action_pressed("ui_right")
	left = Input.is_action_pressed("ui_left")
	if(Input.is_action_just_pressed('ui_right')):
		Transition.emit(self, 'dash')
