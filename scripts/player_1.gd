extends RigidBody2D
###################################################
var engine_power = 3
var braking = -1.5
var max_speed_reverse = 3
###################################################
var base_friction = -0.9
var drag = -0.002
var steer_velocity_factor = 2
var traction_vel_factor = 0.18
###################################################
var friction = base_friction
var veltraction
var steering_angle_base = 15
var wheel_base = 0.2
var traction_base = 1
var traction
var steering_angle
var acceleration = Vector2.ZERO
var velocity = Vector2.ZERO
var steer_direction
var turning
var collision
###################################################
var bestdrift = 0
var score = 0

func _ready():
	reload_text()

func chosen_car(num):
	match num:
		1:
			$Sprite2D.frame = 0
			engine_power = 3
			braking = -2
			max_speed_reverse = 1
			steer_velocity_factor = 2
			traction_vel_factor = 0.15
		2:
			$Sprite2D.frame = 1
			engine_power = 5
			braking = -3
			max_speed_reverse = 2
			steer_velocity_factor = 2
			traction_vel_factor = 0.4
		3:
			$Sprite2D.frame = 2
			engine_power = 5
			braking = -3
			max_speed_reverse = 2
			steer_velocity_factor = 2
			traction_vel_factor = 0.15
		4:
			$Sprite2D.frame = 3
			engine_power = 7
			braking = -5
			max_speed_reverse = 3
			steer_velocity_factor = 2
			traction_vel_factor = 0.05
		5:
			$Sprite2D.frame = 4
			engine_power = 9
			braking = -8
			max_speed_reverse = 1
			steer_velocity_factor = 2
			traction_vel_factor = 0
		6:
			$Sprite2D.frame = 5
			engine_power = 20
			braking = -20
			max_speed_reverse = 1.5
			steer_velocity_factor = 2
			traction_vel_factor = 0
		7:
			$Sprite2D.frame = 6
			engine_power = 3
			braking = -2
			max_speed_reverse = 100
			steer_velocity_factor = 2
			traction_vel_factor = 10
	reload_text()

func _process(delta):
	print(steering_angle)
	$"../gowno/score".text =str(int(score))
	$"../gowno/Traction".text = "Traction: " + str(traction)
	$"../gowno/Velocity".text = "Velocity: " + str(int(velocity.length()*30))
	$"../gowno/StAngle".text = "Steering angle: " + str(int(steering_angle))
	if traction < 0.2 and turning and !collision:
		score += (velocity.length()*velocity.length())/2
	elif !collision and (traction > 0.3 or !turning):
		await get_tree().create_timer(1.5).timeout
		if traction > 0.3 or !turning:
			if score > bestdrift:
				bestdrift = score
				reload_text()
				score = 0
	elif collision:
		score = 0

func _physics_process(delta):
	$Smoke.emitting = true
	turning = false
	$LeftWheelDrift.emitting = false
	$RightWheelDrift.emitting = false
	acceleration = Vector2.ZERO
	veltraction = traction_base - velocity.length() * traction_vel_factor
	traction = clamp(veltraction, 0.01,traction_base)
	steering_angle = steering_angle_base - velocity.length() * steer_velocity_factor
	steering_angle = clamp(steering_angle , 0 , steering_angle_base)
	get_input()
	apply_friction()
	calculate_steering(delta)
	velocity += acceleration * delta
	collision = move_and_collide(velocity)
	if collision:
		friction = -10
		if velocity.length() > 0.5:
			collision_sound()
	else:
		friction = base_friction
	
func apply_friction():
	if velocity.length() < 0.025:
		velocity = Vector2.ZERO
	var friction_force = velocity * friction
	var drag_force = velocity * velocity.length() * drag
	acceleration += drag_force + friction_force

func get_input():
	var turn = 0
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
		
	steer_direction = turn * deg_to_rad(steering_angle)
	
	if Input.is_action_pressed("Throttle"):
		acceleration = transform.x * engine_power
	if Input.is_action_pressed("Brake"):
		acceleration = transform.x * braking
	if Input.is_action_pressed("Handbrake"):
		traction = traction_base - velocity.length() * 0.7
		traction = clamp(traction, 0.01,traction_base)
		steering_angle = steering_angle_base * 40
		if velocity.length() > 2 and turning:
			$LeftWheelDrift.emitting = true
			$RightWheelDrift.emitting = true

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

func reload_text():
	$"../gowno/Power".text = "Power: " + str(engine_power)
	$"../gowno/Braking".text = "Braking: " + str(-braking)
	$"../gowno/TrLoss".text = "Traction loss: " + str(traction_vel_factor)
	$"../gowno/BestDrift".text = "Best drift: " + str(int(bestdrift))

func collision_sound():
	$CollisionSFX.play()
