class_name ai extends RigidBody2D

var max_speed = 250
var steer_force = 0.09
var look_ahead = 50
var num_rays = 16

# context array
var ray_directions = []
var interest = []
var danger = []

var chosen_dir = Vector2.ZERO
var velocity = Vector2.ZERO
var acceleration = Vector2.ZERO

var ownscript

func _ready():
	ownscript = get_parent()
	interest.resize(num_rays)
	danger.resize(num_rays)
	ray_directions.resize(num_rays)
	for i in num_rays:
		var angle = i * 2 * PI / num_rays
		ray_directions[i] = Vector2.RIGHT.rotated(angle)

func _physics_process(delta):
	set_interest()
	set_danger()
	choose_direction()
	var desired_velocity = chosen_dir.rotated(rotation) * max_speed
	velocity = velocity.lerp(desired_velocity, steer_force)
	rotation = velocity.angle()
	move_and_collide(velocity * delta)

func set_interest():
	var path_direction = ownscript.get_path_direction(position)
	for i in num_rays:
		var d = ray_directions[i].rotated(rotation).dot(path_direction)
		interest[i] = max(0, d)

func set_danger():
	var space_state = get_world_2d().direct_space_state
	for i in num_rays:
		var Parameters = PhysicsRayQueryParameters2D.create(position, position + ray_directions[i].rotated(rotation) * look_ahead)
		var result = space_state.intersect_ray(Parameters)
		danger[i] = 1.0 if result else 0.0

func choose_direction():
	for i in num_rays:
		if danger[i] > 0.0:
			interest[i] = 0.0
	chosen_dir = Vector2.ZERO
	for i in num_rays:
		chosen_dir += ray_directions[i] * interest[i]
	chosen_dir = chosen_dir.normalized()
