extends Node2D

var tutorial = 0
var menu = false

func _ready():
	$Tut0.show()
	$Tut1.hide()
	$Tut2.hide()
	$Tut3.hide()
	$Tut4.hide()
	$Menu.hide()
	$Tut0/Label.show()
	$Tut0/Label2.hide()
	$Tut0/KEY.hide()
	$Tut0/KEY2.hide()
	await get_tree().create_timer(0.5).timeout
	$Tut0/Label2.show()
	$Tut0/KEY.show()
	$Tut0/KEY2.show()

func _input(event):
	if Input.is_action_just_pressed("Throttle") and tutorial == 0:
		await get_tree().create_timer(1).timeout
		$Tut0.hide()
		$Tut1.show()
		tutorial = 1
	if Input.is_action_just_pressed("Left") and tutorial == 1 or Input.is_action_just_pressed("Right") and tutorial == 1:
		await get_tree().create_timer(1).timeout
		$Tut1.hide()
		$Tut2.show()
		tutorial = 2
	if Input.is_action_just_pressed("Brake") and tutorial == 2:
		await get_tree().create_timer(1).timeout
		$Tut2.hide()
		$Tut3.show()
		tutorial = 3
	if Input.is_action_just_pressed("Handbrake") and tutorial == 3:
		await get_tree().create_timer(1).timeout
		$Tut3.hide()
		await get_tree().create_timer(1).timeout
		$Tut4.show()
		tutorial = 4
		Global.played = 1
		Global.savefile()
	if Input.is_action_just_pressed("Esc") and tutorial == 4:
		get_tree().change_scene_to_file("res://scenes/main.tscn")
	if menu == true:
		if event is InputEventKey and event.pressed:
			if event.keycode == KEY_1:
				$Player1.chosen_car(0)
			elif event.keycode == KEY_2:
				$Player1.chosen_car(1)
			elif event.keycode == KEY_3:
				$Player1.chosen_car(2)
			elif event.keycode == KEY_4:
				$Player1.chosen_car(3)
			elif event.keycode == KEY_5:
				$Player1.chosen_car(4)
			elif event.keycode == KEY_6:
				$Player1.chosen_car(5)
			elif event.keycode == KEY_7:
				$Player1.chosen_car(6)


func _on_menu_area_body_entered(body):
	$Menu.show()
	menu = true 

func _on_menu_area_body_exited(body):
	$Menu.hide()
	menu = false

func _on_exit_area_body_entered(body):
	if tutorial ==4:
		Global.savefile()
		get_tree().change_scene_to_file("res://scenes/main.tscn")
