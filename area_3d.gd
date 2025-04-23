extends Area3D

@export var inward_force:    float = 200.0   # how hard it pulls inward
@export var spin_force:      float = 2.0   # how hard it spins around
@export var lift_force:      float = 10.0  # how hard it lifts upward

var bodies: Array[RigidBody3D] = []
var joints := {}


func _ready() -> void:
	monitoring = true
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)


func _on_body_entered(body):
	if body is RigidBody3D and not bodies.has(body):
		bodies.append(body)


func _on_body_exited(body: Node) -> void:
	if body is RigidBody3D:
		bodies.erase(body)

func _physics_process(delta: float) -> void:
	for body in bodies.duplicate():
		if not is_instance_valid(body):
			bodies.erase(body)
			continue
			
		#print(body)

		# vector from tornado center to object
		var offset: Vector3 = body.global_transform.origin - global_transform.origin
		var distFromCenter := offset.length()
		# horizontal component only (ignore y for spin/pull)
		var horiz: Vector3  = Vector3(offset.x, 0, offset.z)
		if horiz.length() > 0.1:
			var radial_dir = -horiz.normalized()
			var tangential_dir = radial_dir.cross(Vector3.UP)

			# pull inward (centripetal)
			body.apply_central_force(radial_dir * inward_force)
			# print(radial_dir * inward_force)
			# spin around
			body.apply_central_force(tangential_dir * spin_force * distFromCenter)

		# lift up
		body.apply_central_force(Vector3.UP * lift_force)
