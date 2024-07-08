extends CharacterBody3D

# How fast the player moves in meters per second.
@export var speed = 14
# The downward acceleration when in the air, in meters per second squared.
@export var fall_acceleration = 75

@export var jump_force = 20
var target_velocity = Vector3.ZERO


func _physics_process(delta):
	var direction = Vector3.ZERO

	if Input.is_action_pressed("move_right"):
		direction.x += sqrt(2)
		direction.z -= sqrt(2)
	if Input.is_action_pressed("move_left"):
		direction.x -= sqrt(2)
		direction.z += sqrt(2)
	if Input.is_action_pressed("move_back"):
		direction.x += sqrt(2)
		direction.z += sqrt(2)
	if Input.is_action_pressed("move_forward"):
		direction.x -= sqrt(2)
		direction.z -= sqrt(2)
	if is_on_floor():
		if Input.is_action_pressed("jump_up"):
			direction.y += 200
	if direction != Vector3.ZERO:
		direction = direction.normalized()

	# Ground Velocity
	target_velocity.x = direction.x * speed
	target_velocity.z = direction.z * speed
	if is_on_floor():
		target_velocity.y = direction.y * jump_force
	# Vertical Velocity
	if not is_on_floor(): # If in the air, fall towards the floor. Literally gravity
		target_velocity.y = target_velocity.y - (fall_acceleration * delta)

	# Moving the Character
	velocity = target_velocity
	move_and_slide()
