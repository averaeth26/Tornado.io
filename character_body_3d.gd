extends CharacterBody3D

@export var speed = 5	# speed in meters/sec

func _physics_process(delta):
	var direction := Vector3.ZERO
	direction.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	direction.z = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
		
	velocity = direction*speed
	print(velocity.x)

	move_and_slide()
