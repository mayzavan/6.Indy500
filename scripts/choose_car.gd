extends Node2D

func _on_button_pressed():
	Global.chosen_car = 1
	load_game()

func _on_button_2_pressed():
	Global.chosen_car = 2
	load_game()

func _on_button_3_pressed():
	Global.chosen_car = 3
	load_game()

func _on_button_4_pressed():
	Global.chosen_car = 4
	load_game()

func _on_button_5_pressed():
	Global.chosen_car = 5
	load_game()

func _on_button_6_pressed():
	Global.chosen_car = 6
	load_game()

func _on_button_7_pressed():
	Global.chosen_car = 7
	load_game()

func load_game():
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

func _on_back_pressed():
	get_tree().change_scene_to_file("res://scenes/choose_map.tscn")
