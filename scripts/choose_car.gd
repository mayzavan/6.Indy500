extends Node2D

var car = 0
@onready var object_car = $Cars/Car1

func _ready():
	change_car()

func _input(event):
	if Input.is_action_just_pressed("Right"):
		if car == 6:
			car = 0
		else:
			car += 1
	change_car()
	if Input.is_action_just_pressed("Left"):
		if car == 0:
			car = 6
		else:
			car -= 1
		change_car()
	if Input.is_action_just_pressed("Enter") or Input.is_action_just_pressed("Handbrake"):
		Global.chosen_car = car
		ThemeMusic.stopped = true
		match Global.chosen_map:
			0:
				get_tree().change_scene_to_file("res://scenes/map_1.tscn")
			1:
				get_tree().change_scene_to_file("res://scenes/map_2.tscn")
			2:
				get_tree().change_scene_to_file("res://scenes/map_3.tscn")
			3:
				get_tree().change_scene_to_file("res://scenes/map_4.tscn")
			4:
				get_tree().change_scene_to_file("res://scenes/challenge_1.tscn")
			5:
				get_tree().change_scene_to_file("res://scenes/challenge_2.tscn")
			6:
				get_tree().change_scene_to_file("res://scenes/challenge_3.tscn")
	if Input.is_action_just_pressed("Esc"):
		get_tree().change_scene_to_file("res://scenes/choose_map.tscn")

func change_car():
	$Cars/Car1.hide()
	$Cars/Car2.hide()
	$Cars/Car3.hide()
	$Cars/Car4.hide()
	$Cars/Car5.hide()
	$Cars/Car6.hide()
	$Cars/Car7.hide()
	match car:
		0:
			$Cars/Car1.show()
			object_car = $Cars/Car1
			object_car.set_rotation_degrees(0)
			$CarDescription/Speed/Panel.scale.x = 0.2
			$CarDescription/OverSteer/Panel.scale.x = 0.1
			$CarDescription/Understeer/Panel.scale.x = 0.2
			$CarDescription/Difficulty/Panel.scale.x = 0.1
			$CarDescription/carname.text = 'A car'
			$CarDescription/description.text = 'The most basic car You can find easiest one to control but also the slowest one'
		1:
			$Cars/Car2.show()
			object_car = $Cars/Car2
			object_car.set_rotation_degrees(0)
			$CarDescription/Speed/Panel.scale.x = 0.27
			$CarDescription/OverSteer/Panel.scale.x = 0.8
			$CarDescription/Understeer/Panel.scale.x = 0.1
			$CarDescription/Difficulty/Panel.scale.x = 0.3
			$CarDescription/carname.text = 'Drift car'
			$CarDescription/description.text = 'Very good car for drift challenges'
		2:
			$Cars/Car3.show()
			object_car = $Cars/Car3
			object_car.set_rotation_degrees(0)
			$CarDescription/Speed/Panel.scale.x = 0.3
			$CarDescription/OverSteer/Panel.scale.x = 0.1
			$CarDescription/Understeer/Panel.scale.x = 0.6
			$CarDescription/Difficulty/Panel.scale.x = 0.4
			$CarDescription/carname.text = 'Fast car'
			$CarDescription/description.text = 'A bit faster than previous ones, still pretty easy to handle'
		3:
			$Cars/Car4.show()
			object_car = $Cars/Car4
			object_car.set_rotation_degrees(0)
			$CarDescription/Speed/Panel.scale.x = 0.47
			$CarDescription/OverSteer/Panel.scale.x = 0.1
			$CarDescription/Understeer/Panel.scale.x = 0.2
			$CarDescription/Difficulty/Panel.scale.x = 0.7
			$CarDescription/carname.text = 'Faster car'
			$CarDescription/description.text = 'Sticks to road a bit too much, turns faster than you think'
		4:
			$Cars/Car5.show()
			object_car = $Cars/Car5
			object_car.set_rotation_degrees(0)
			$CarDescription/Speed/Panel.scale.x = 0.6
			$CarDescription/OverSteer/Panel.scale.x = 0.1
			$CarDescription/Understeer/Panel.scale.x = 1
			$CarDescription/Difficulty/Panel.scale.x = 0.55
			$CarDescription/carname.text = 'F1 typa fast car'
			$CarDescription/description.text = "Slam those brakes before corner or it won't turn"
		5:
			$Cars/Car6.show()
			object_car = $Cars/Car6
			object_car.set_rotation_degrees(0)
			$CarDescription/Speed/Panel.scale.x = 1
			$CarDescription/OverSteer/Panel.scale.x = 0.1
			$CarDescription/Understeer/Panel.scale.x = 0.3
			$CarDescription/Difficulty/Panel.scale.x = 1
			$CarDescription/carname.text = 'Too fast car'
			$CarDescription/description.text = "Straight up alien car - human can't control it"
		6:
			$Cars/Car7.show()
			object_car = $Cars/Car7
			object_car.set_rotation_degrees(0)
			$CarDescription/Speed/Panel.scale.x = 0.2
			$CarDescription/OverSteer/Panel.scale.x = 1
			$CarDescription/Understeer/Panel.scale.x = 0.1
			$CarDescription/Difficulty/Panel.scale.x = 0.2
			$CarDescription/carname.text = 'Drifting forklift'
			$CarDescription/description.text = "drifting forklift"

func _process(delta):
	object_car.rotation_degrees += 30 * delta
