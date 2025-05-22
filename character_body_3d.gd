extends CharacterBody3D

@export var speed = 5	# speed in meters/sec
@export var rotationSpeed = 1
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _physics_process(delta):
	var direction := Vector3.ZERO
	var rotationY = Input.get_action_strength("turn_camera_left") - Input.get_action_strength("turn_camera_right")
	direction.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	direction.z = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	
	velocity = get_transform().basis * direction*speed / pow(scale.x,0.5)
	rotate_y(deg_to_rad(rotationY * rotationSpeed))
	#print(is_on_floor())
	if not is_on_floor():
		velocity.y -= gravity * 0.1 * scale.y
		
	move_and_slide()
	
