extends Node2D

@export var player : Node
var menu = false

func ready():
	$AudioStreamPlayer.play()
	$Menu.hide()
	player.chosen_car(1)

func _on_menu_area_body_entered(body):
	$Menu.show()
	menu = true

func _on_menu_area_body_exited(body):
	$Menu.hide()
	menu = false

func _input(event):
	if Input.is_action_just_pressed("Reload"):
		get_tree().reload_current_scene()
	if Input.is_action_just_pressed("Esc"):
		get_tree().change_scene_to_file("res://scenes/choose_mode.tscn")
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
