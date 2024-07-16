extends Node2D

var map = 0

func _ready():
	if Global.mode == 'time_attack' or Global.mode == 'time_chall':
		$Time_Attack.show()

func _on_back_pressed():
	get_tree().change_scene_to_file("res://scenes/choose_mode.tscn")

func _on_go_pressed():
	Global.chosen_map = map
	get_tree().change_scene_to_file("res://scenes/choose_car.tscn")

func _on_next_pressed():
	if map == 5:
		map = 0
	else:
		map += 1
	change_map()

func _on_previous_pressed():
	if map == 0:
		map = 5
	else:
		map -= 1
	change_map()

func change_map():
	$Maps/Map0.hide()
	$Maps/Map1.hide()
	$Maps/Map2.hide()
	$Maps/Map3.hide()
	$Maps/Map4.hide()
	$Maps/Map5.hide()
	match map:
		0:
			$Maps/Map0.show()
		1:
			$Maps/Map1.show()
		2:
			$Maps/Map2.show()
		3:
			$Maps/Map3.show()
		4:
			$Maps/Map4.show()
		5:
			$Maps/Map5.show()
