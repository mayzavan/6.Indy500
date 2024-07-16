extends Node2D

@export var player : Node

func ready():
	$Menu.hide()
	player.chosen_car(1)

func _on_menu_area_body_entered(body):
	$Menu.show()

func _on_menu_area_body_exited(body):
	$Menu.hide()

func _on_button_pressed():
	$Player1.chosen_car(1)

func _on_button_2_pressed():
	$Player1.chosen_car(2)

func _on_button_3_pressed():
	$Player1.chosen_car(3)

func _on_button_4_pressed():
	$Player1.chosen_car(4)

func _on_button_5_pressed():
	$Player1.chosen_car(5)

func _on_button_6_pressed():
	$Player1.chosen_car(6)

func _on_button_7_pressed():
	$Player1.chosen_car(7)

func _input(event):
	if Input.is_action_just_pressed("Reload"):
		get_tree().reload_current_scene()
	if Input.is_action_just_pressed("Esc"):
		#Global.savefile()
		get_tree().change_scene_to_file("res://scenes/choose_mode.tscn")
