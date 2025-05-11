extends Node2D

var swordStats = {
	'damage': 100,
	'weight': 5,
	'base_reset_time': 0.5,
	'max_reset_time': 5
}

var resetTime = swordStats['base_reset_time']
var canUse = true

func calculate_reset_time(energy: float, max_energy: float) -> float:
	var min_time = 0.2
	var base_time = swordStats["base_reset_time"]
	var weight = swordStats["weight"]

	var energy_ratio = clamp(1.0 - (energy / max_energy), 0.0, 1.0)
	var time = lerp(min_time, base_time, energy_ratio)

	# Scale reset time by weight (e.g., +10% time per unit of weight)
	var weight_factor = 1.0 + (weight * 0.1)
	
	
	print(energy_ratio)
	if (energy_ratio > 0.85): return swordStats["max_reset_time"]
	
	return time * weight_factor
func use(energy, max_energy):
	canUse = false
	resetTime = calculate_reset_time(energy, max_energy)
	print(resetTime,' ', energy)
	$AnimationPlayer.play("slash")
func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	var tween = get_tree().create_tween()
	tween.parallel().tween_property($Texture, "rotation", 0.0, resetTime).set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN_OUT)
	tween.parallel().tween_property($Texture, "position", Vector2(0,0), resetTime).set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN_OUT)
	tween.finished.connect(_on_tween_finished)
func _on_tween_finished():
	canUse = true
