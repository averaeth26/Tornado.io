extends Area3D

@export var inward_force:    float = 50.0   # how hard it pulls inward
@export var spin_force:      float = 2.0   # how hard it spins around
@export var lift_force:      float = 10.0  # how hard it lifts upward


var bodies: Array[RigidBody3D] = []
var joints := {}
var new_lift_force = lift_force
var new_spin_force = spin_force
var new_inward_force = inward_force
var objectSize
var playerSize



func _ready() -> void:
	monitoring = true
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)


func _on_body_entered(body):
	if body is RigidBody3D and not bodies.has(body):
		bodies.append(body)
		print(body.name)


func _on_body_exited(body: Node) -> void:
	if body is RigidBody3D:
		bodies.erase(body)


func find_mesh_descendants(body: Node) -> Array:
	var results := []
	for child in body.get_children():
		if child is MeshInstance3D:
			results.append(child)
		results += find_mesh_descendants(child)
	return results


func sum_sizes(arr: Array) -> float:
	var totalSize := 0
	for obj in arr:
		totalSize += obj.get_aabb().size.length()*obj.get_parent().scale.x**3
	return totalSize


func _physics_process(delta: float) -> void:
	for body in bodies.duplicate():
		if not is_instance_valid(body):
			bodies.erase(body)
			continue
			

		if gravity*body.mass < new_lift_force:
			if body.freeze == true:
				body.freeze = false
			
			#objectSize = sum_sizes(find_mesh_descendants(body))
			#print(objectSize)
			#playerSize = sum_sizes(find_mesh_descendants(get_parent()))*get_parent().scale
			#print(playerSize)
			
			get_parent().scale += sum_sizes(find_mesh_descendants(body))*body.scale * 0.001
			#get_parent().get_child(0).fov += sum_sizes(find_mesh_descendants(body))* body.scale.x * 0.001

			#get_parent().scale.z += sum_sizes(find_mesh_descendants(body))* body.scale.z * 0.001
			new_lift_force = lift_force * get_parent().scale.x
			new_inward_force = inward_force * get_parent().scale.x
			new_spin_force = spin_force * get_parent().scale.x
			#print(new_lift_force, gravity*body.mass)


			body.scale -= get_parent().scale * 0.005
			if body.scale.x <= 0.02:
				body.free()
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
		else:
			print(new_lift_force, "   ", body.mass*gravity)
