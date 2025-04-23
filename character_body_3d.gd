extends CharacterBody3D

@export var speed = 5	# speed in meters/sec
@onready var interact_zone = $Area3D
var current_target: Node = null

func _physics_process(delta):
	var direction := Vector3.ZERO
	direction.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	direction.z = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
		
	velocity = direction*speed
	
	move_and_slide()
