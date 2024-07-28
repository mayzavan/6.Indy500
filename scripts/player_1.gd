extends RigidBody2D
###################################################
var engine_power = 3
var braking = -1.5
var max_speed_reverse = 3
###################################################
var steer_velocity_factor
var steer_hand_factor
var traction_vel_factor
var traction_hand_factor
###################################################
var base_friction = -0.9
var drag = -0.002
var friction = base_friction
var veltraction
var steering_angle_base = 20
var wheel_base = 0.2
var traction_base = 1
var traction = 1
var steering_angle
var acceleration = Vector2.ZERO
var velocity = Vector2.ZERO
var steer_direction
var turning
var collision
var turn = 0
var colliding = false
###################################################
var main

var tile
var tilemap

func _ready():
	main = get_parent()
	tilemap = $"../TileMap"
	chosen_car(Global.chosen_car)

func chosen_car(num):
	match num:
		0:
			$Sprite2D.frame = 0
			engine_power = 3			 # acceleration and max speed
			braking = -2 				 # braking speed and accel back
			max_speed_reverse = 1 		 # yea
			steer_velocity_factor = 1.3	 # how much angle is taken away from turning acc to speed
			traction_vel_factor = 0.1	 # how much traction is lost acc to speed
			traction_hand_factor = 0.35	 # how much traction is lost on spacebar
			steer_hand_factor = 1	 	 # how much angle is increased on spacebar
		1:
			$Sprite2D.frame = 1
			engine_power = 4
			braking = -3
			max_speed_reverse = 2
			steer_velocity_factor = 2
			traction_vel_factor = 0.3
			traction_hand_factor = 0.7
			steer_hand_factor = 3
		2:
			$Sprite2D.frame = 2
			engine_power = 5
			braking = -3
			max_speed_reverse = 2
			steer_velocity_factor = 2
			traction_vel_factor = 0.1
			traction_hand_factor = 0.2
			steer_hand_factor = 1
		3:
			$Sprite2D.frame = 3
			engine_power = 7
			braking = -5
			max_speed_reverse = 3
			steer_velocity_factor = 2.1
			traction_vel_factor = 0.13
			traction_hand_factor = 0.1
			steer_hand_factor = 1
		4:
			$Sprite2D.frame = 4
			engine_power = 9
			braking = -8
			max_speed_reverse = 1
			steer_velocity_factor = 2.3
			traction_vel_factor = 0
			traction_hand_factor = 0.01
			steer_hand_factor = 1.2
		5:
			$Sprite2D.frame = 5
			engine_power = 15
			braking = -10
			max_speed_reverse = 1.5
			steer_velocity_factor = 1.35
			traction_vel_factor = 0
			traction_hand_factor = 0
			steer_hand_factor = 0
		6:
			$Sprite2D.frame = 6
			engine_power = 3
			braking = -2
			max_speed_reverse = 100
			steer_velocity_factor = 2
			traction_vel_factor = 10
			traction_hand_factor = 10
			steer_hand_factor = 3

func _physics_process(delta):
	$Smoke.emitting = true
	turning = false
	$LeftWheelDrift.emitting = false
	$RightWheelDrift.emitting = false
	acceleration = Vector2.ZERO
	veltraction = traction_base - velocity.length() * traction_vel_factor
	traction = clamp(veltraction, 0.01,traction_base)
	steering_angle = steering_angle_base - velocity.length() * steer_velocity_factor
	steering_angle = clamp(steering_angle , 0 , 20)
	get_input()
	apply_friction()
	calculate_steering(delta)
	velocity += acceleration * delta
	if collision:
		var collider = collision.get_collider()
		if collider is ai:
			pass
		if velocity.length() > 0.5 and collider is TileMap:
			collision_sound()
			colliding = true
			move_and_collide(-0.5*velocity)
			acceleration = Vector2.ZERO
			turn = 0
			await get_tree().create_timer(0.15).timeout
			turn = 0
			acceleration = Vector2.ZERO
			velocity = Vector2.ZERO
			colliding = false
	collision = move_and_collide(velocity)

func apply_friction():
	if velocity.length() < 0.025:
		velocity = Vector2.ZERO
	tile = check_tile()
	if tile == 'Grass':
		friction = -10
	else:
		friction = base_friction
	var friction_force = velocity * friction
	var drag_force = velocity * velocity.length() * drag
	acceleration += drag_force + friction_force

func get_input():
	if !colliding:
		turn = 0
		if Input.is_action_pressed("Right") and Input.is_action_pressed("Left"):
			turn = 0
			turning = false
		if Input.is_action_pressed("Right"):
			turn += 1
			turning = true
			if traction < 0.2:
				$LeftWheelDrift.emitting = true
				$RightWheelDrift.emitting = true
		if Input.is_action_pressed("Left"):
			turn -= 1
			turning = true
			if traction < 0.2:
				$LeftWheelDrift.emitting = true
				$RightWheelDrift.emitting = true
		if Input.is_action_pressed("Throttle"):
			acceleration = transform.x * engine_power
		if Input.is_action_pressed("Brake"):
			acceleration = transform.x * braking
		if Input.is_action_pressed("Handbrake"):
			traction = traction_base - velocity.length() * traction_hand_factor
			traction = clamp(traction, 0.01,traction_base)
			steering_angle = (steering_angle_base - velocity.length() * steer_velocity_factor) * steer_hand_factor
			steering_angle = clamp(steering_angle , 0 , 20)
			
			if velocity.length() > 2 and turning:
				$LeftWheelDrift.emitting = true
				$RightWheelDrift.emitting = true
		steer_direction = turn * deg_to_rad(steering_angle)

func calculate_steering(delta):
	var rear_wheel = position - transform.x * wheel_base/2.0
	var front_wheel = position + transform.x * wheel_base/2.0
	rear_wheel += velocity * delta
	front_wheel += velocity.rotated(steer_direction) * delta
	var new_heading = (front_wheel - rear_wheel).normalized()
	var d = new_heading.dot(velocity.normalized())
	if d > 0:
		velocity = velocity.lerp(new_heading * velocity.length(), traction)
	if d < 0:
		velocity = -new_heading * min(velocity.length(), max_speed_reverse)
	rotation = new_heading.angle()

func collision_sound():
	$CollisionSFX.play()

func check_tile():
	var data = tilemap.get_cell_tile_data(0, check_coords())
	if data != null:
		var type = data.get_custom_data('0')
		return type

func check_coords():
	var tile_coords = tilemap.local_to_map(tilemap.to_local(position))
	return tile_coords
