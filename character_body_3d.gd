extends CharacterBody3D

@export var speed = 5	# speed in meters/sec
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")


func _physics_process(delta):
	var direction := Vector3.ZERO
	direction.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	direction.z = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
		
	velocity = direction*speed
	print(is_on_floor())
	if not is_on_floor():
		velocity.y -= gravity * delta
		
	move_and_slide()
	
