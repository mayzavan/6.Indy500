extends Node2D

var chosenbutton : int = 0

func _ready():
	$Test_Track/Test_Track/Lines.show()
	$Free_Ride/Free_Ride/Lines.hide()
	$Time_attack/Time_attack/Lines.hide()
	$Drift/Drift/Lines.hide()
	$"Time_Challenge/Time Challenge/Lines".hide()
	$Race/Race/Lines.hide()
	$Main_menu/Main_menu/Lines.hide()

func _process(delta):
	$Test_Track/Test_Track/Lines.hide()
	$Free_Ride/Free_Ride/Lines.hide()
	$Time_attack/Time_attack/Lines.hide()
	$Drift/Drift/Lines.hide()
	$"Time_Challenge/Time Challenge/Lines".hide()
	$Race/Race/Lines.hide()
	$Main_menu/Main_menu/Lines.hide()
	match chosenbutton:
		0:
			$Test_Track/Test_Track/Lines.show()
		1:
			$Free_Ride/Free_Ride/Lines.show()
			Global.mode = 'free'
		2:
			$"Time_Challenge/Time Challenge/Lines".show()
			Global.mode = 'time_chall'
		3:
			$Time_attack/Time_attack/Lines.show()
			Global.mode = 'time_attack'
		4:
			$Drift/Drift/Lines.show()
			Global.mode = 'drift'
		5:
			$Race/Race/Lines.show()
			Global.mode = 'vsAI'
		6:
			$Main_menu/Main_menu/Lines.show()

func _input(event):
	if Input.is_action_just_pressed("Brake"):
		if chosenbutton >= 6:
			chosenbutton = 0
		else:
			chosenbutton += 1
	if Input.is_action_just_pressed("Throttle"):
		if chosenbutton <= 0:
			chosenbutton = 6
		else:
			chosenbutton -= 1
	if Input.is_action_just_pressed("Enter") or Input.is_action_just_pressed("Handbrake"):
		if chosenbutton == 0:
			get_tree().change_scene_to_file("res://scenes/map_drift.tscn")
		elif chosenbutton == 6:
			get_tree().change_scene_to_file("res://scenes/main.tscn")
		else:
			get_tree().change_scene_to_file("res://scenes/choose_map.tscn")
	if Input.is_action_just_pressed("Esc"):
		get_tree().change_scene_to_file("res://scenes/main.tscn")
