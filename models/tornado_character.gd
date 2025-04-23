extends Node3D

@export var speed = 5	# speed in meters/sec

func _physics_process(delta: float) -> void:
		rotation_degrees.y += speed
