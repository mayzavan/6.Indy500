extends Node2D

var chosenbutton : int = 0
var volsett : int = 0
var volumesetting : bool = false
var sure : int = 0

var fullscreen: bool = false

func _ready():
	$yesimsure.hide()
	$reset/Lines.hide()
	$backbutton/Lines.hide()
	$yesimsure/Lines.hide()
	$volumesettings.hide()
	$volume/Lines.show()
	if DisplayServer.window_get_mode() == 0:
		fullscreen = false
	else:
		fullscreen = true

func _process(delta):
	if fullscreen == true:
		$fullscreen/Yes.show()
	else:
		$fullscreen/Yes.hide()
	if volumesetting == false:
		match chosenbutton:
			0:
				$volume/Lines.show()
				$yesimsure.hide()
				$yesimsure/Lines.hide()
				$reset/Lines.hide()
				$backbutton/Lines.hide()
				$fullscreen/Lines.hide()
			2:
				$reset/Lines.show()
				$backbutton/Lines.hide()
				$volume/Lines.hide()
				$fullscreen/Lines.hide()
			1:
				$yesimsure.hide()
				$yesimsure/Lines.hide()
				$reset/Lines.hide()
				$backbutton/Lines.hide()
				$volume/Lines.hide()
				$fullscreen/Lines.show()
			3:
				$yesimsure.hide()
				$yesimsure/Lines.hide()
				$reset/Lines.hide()
				$backbutton/Lines.show()
				$volume/Lines.hide()
				$fullscreen/Lines.hide()
	elif volumesetting == true:
		match volsett:
			0:
				$volumesettings/master/Line5.show()
				$volumesettings/master/Line6.show()
				$volumesettings/music/Line5.hide()
				$volumesettings/music/Line6.hide()
				$volumesettings/sfx/Line5.hide()
				$volumesettings/sfx/Line6.hide()
			1:
				$volumesettings/music/Line5.show()
				$volumesettings/music/Line6.show()
				$volumesettings/sfx/Line5.hide()
				$volumesettings/sfx/Line6.hide()
				$volumesettings/master/Line5.hide()
				$volumesettings/master/Line6.hide()
			2:
				$volumesettings/sfx/Line5.show()
				$volumesettings/sfx/Line6.show()
				$volumesettings/master/Line5.hide()
				$volumesettings/master/Line6.hide()
				$volumesettings/music/Line5.hide()
				$volumesettings/music/Line6.hide()

func _input(event):
	if volumesetting == false:
		if Input.is_action_just_pressed("Enter") or Input.is_action_just_pressed("Handbrake"):
			change_scene()
		if Input.is_action_just_pressed("Brake"):
			sure = 0
			if chosenbutton == 3:
				chosenbutton = 0
			else:
				chosenbutton += 1
		if Input.is_action_just_pressed("Throttle"):
			sure = 0
			if chosenbutton <= 0:
				chosenbutton = 3
			else:
				chosenbutton -= 1
		if Input.is_action_just_pressed("Esc"):
			get_tree().change_scene_to_file("res://scenes/main.tscn")
	if volumesetting == true:
		if Input.is_action_just_pressed("Esc"):
			volumesetting = false
			$volumesettings.hide()
		if Input.is_action_just_pressed("Brake"):
			if volsett == 2:
				volumesetting = false
				$volumesettings.hide()
			else:
				volsett += 1
		if Input.is_action_just_pressed("Throttle"):
			if volsett <= 0:
				volsett = 2
			else:
				volsett -= 1
		if Input.is_action_just_pressed("Left"):
			change_volume(-1)
		if Input.is_action_just_pressed("Right"):
			change_volume(1)

func change_scene():
	match chosenbutton:
		0:
			$volumesettings.show()
			$volumesettings/master/HSlider.value = 10*db_to_linear(AudioServer.get_bus_volume_db(0))
			$volumesettings/music/HSlider.value = 10*db_to_linear(AudioServer.get_bus_volume_db(1))
			$volumesettings/sfx/HSlider.value = 10*db_to_linear(AudioServer.get_bus_volume_db(2))
			volumesetting = true
		2:
			if sure == 0:
				$yesimsure.show()
				sure = 1
			elif sure == 1:
				sure = 2
				$yesimsure/Lines.show()
			elif sure >=2:
				Global.played = 0
				Global.highscores = []
				Global.map0_times = [0,0,0,0,0,0,0]
				Global.map1_times = [0,0,0,0,0,0,0]
				Global.map2_times = [0,0,0,0,0,0,0]
				Global.map3_times = [0,0,0,0,0,0,0]
				Global.map4_times = [0,0,0,0,0,0,0]
				Global.map5_times = [0,0,0,0,0,0,0]
				Global.map6_times = [0,0,0,0,0,0,0]

				Global.map0_drifts = [0,0,0,0,0,0,0]
				Global.map1_drifts = [0,0,0,0,0,0,0]
				Global.map2_drifts = [0,0,0,0,0,0,0]
				Global.map3_drifts = [0,0,0,0,0,0,0]
				Global.savefile()
				$yesimsure.hide()
		1:
			if fullscreen == true:
				DisplayServer.window_set_mode(0)
				$fullscreen/Yes.hide()
				fullscreen = false
			else:
				DisplayServer.window_set_mode(3)
				$fullscreen/Yes.show()
				fullscreen = true
		3:
			get_tree().change_scene_to_file("res://scenes/main.tscn")

func change_volume(val):
	match volsett:
		0:
			$volumesettings/master/HSlider.value += val
			AudioServer.set_bus_volume_db(0, linear_to_db($volumesettings/master/HSlider.value/10))
		1:
			$volumesettings/music/HSlider.value += val
			AudioServer.set_bus_volume_db(1, linear_to_db($volumesettings/music/HSlider.value/10))
		2:
			$volumesettings/sfx/HSlider.value += val
			AudioServer.set_bus_volume_db(2, linear_to_db($volumesettings/sfx/HSlider.value/10))
