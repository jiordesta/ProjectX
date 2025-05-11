extends Node2D

var rays: Array[float] = []
var ray_calculated = []
var rays_values: Array[Vector2] = []

@onready var char = get_parent()

func _ready() -> void:
	for ray in range(8):
		rays_values.append(Vector2(1, 0).rotated(deg_to_rad(45 * ray)))
		ray_calculated.append(0)
		rays.append(0.0)
func _process(delta: float) -> void:
	getDirections(get_global_mouse_position() - get_parent().global_position)
	doThis(getPrefferedDirection())

func useItem():
	$Sword.use(char.stats['energy'], char.MAX_STATS['energy'])
	char.updateStats('energy',5,Enum.StatActions.DECREASE)
func getDirections(dir: Vector2):
	ray_calculated = []
	for ray in rays_values:
		ray_calculated.push_back(ray.dot(dir))
func doThis(dir:Vector2):
	var x = dir.x
	var y = dir.y
	var angle_radians = dir.angle()
	var angle_degrees = rad_to_deg(angle_radians)

	#rotation = lerp_angle(rotation, angle_radians, 0.1)

	#if(x > -0.75 and x < 0.75 and y < 0):
		#show_behind_parent = true
	#else:
		#show_behind_parent = false
	var textures_node = get_parent().get_node("Textures")
	
	var target_scale_x = 1 if x > 0 else -1
	textures_node.scale.x = lerp(textures_node.scale.x, float(target_scale_x), 0.5)
	scale.x = lerp(textures_node.scale.x, float(target_scale_x), 0.5)
	#if(x > 0):
		#scale.y = 1
		##textures_node.scale.x = 1
	#if(x < 0):
		#scale.y = -1
		##textures_node.scale.x = -1
	#print(x, y)
	#if x > 0 and y > 0:
		#print("BottomRight (BR)")
	#elif x > 0 and y < 0:
		#print("TopRight (TR)")
	#elif x < 0 and y > 0:
		#print("BottomLeft (BL)")
	#elif x < 0 and y < 0:
		#print("TopLeft (TL)")
	#elif (x >= -0.05 and x <= 0.05) and y < 0:
		#print("Top (T)")
	#elif (x >= -0.05 and x <= 0.05) and y > 0:
		#print("Bottom (B)")
	#elif (y >= -0.05 and y <= 0.05) and x > 0:
		#print("Right (R)")
	#elif (y >= -0.05 and y <= 0.05) and x < 0:
		#print("Left (L)")
	
func getPrefferedDirection():
	var val = ray_calculated.max()
	var index = ray_calculated.find(val)
	return rays_values[index]
