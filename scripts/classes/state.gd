extends Node
class_name State

@onready var entity: Entity

var direction: Vector2

signal Transition
signal TransitionHurt
