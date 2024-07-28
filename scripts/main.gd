extends Node2D

var chosenbutton : int = 0
var firsttime: int

func _ready():
	Global.loadfile()
	if Global.played == 0:
		firsttime = 1
		print("first time playing")
	else:
		firsttime = 0
		print("not a first time playing")
	$Buttons/Play/Lines.show()
	$Buttons/Settings/Lines.hide()
	$Buttons/Credits/Lines.hide()
	$Buttons/Quit/Lines.hide()

func _process(delta):
	$Cars.rotation += deg_to_rad(10*delta)
	$Buttons/Play/Lines.hide()
	$Buttons/Settings/Lines.hide()
	$Buttons/Credits/Lines.hide()
	$Buttons/Quit/Lines.hide()
	match chosenbutton:
		0:
			$Buttons/Play/Lines.show()
		1:
			$Buttons/Settings/Lines.show()
		2:
			$Buttons/Credits/Lines.show()
		3:
			$Buttons/Quit/Lines.show()

func _input(event):
	if Input.is_action_just_pressed("Brake"):
		if chosenbutton >= 3:
			chosenbutton = 0
		else:
			chosenbutton += 1
	if Input.is_action_just_pressed("Throttle"):
		if chosenbutton <= 0:
			chosenbutton = 3
		else:
			chosenbutton -= 1
	if Input.is_action_just_pressed("Enter") or Input.is_action_just_pressed("Handbrake"):
		change_scene()
	if Input.is_action_just_pressed("Esc"):
		Global.savefile()
		get_tree().quit()

func change_scene():
	match chosenbutton:
		0:
			if firsttime == 0:
				get_tree().change_scene_to_file("res://scenes/choose_mode.tscn")
			else:
				get_tree().change_scene_to_file("res://scenes/tutorial.tscn")
		1:
			get_tree().change_scene_to_file("res://scenes/settings.tscn")
		2:
			get_tree().change_scene_to_file("res://scenes/credits.tscn")
		3:
			Global.savefile()
			get_tree().quit()
