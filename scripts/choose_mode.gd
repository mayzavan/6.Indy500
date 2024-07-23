extends Node2D


func _on_test_track_pressed():
	get_tree().change_scene_to_file("res://scenes/map_drift.tscn")

func _on_free_ride_pressed():
	Global.mode = 'free'
	get_tree().change_scene_to_file("res://scenes/choose_map.tscn")

func _on_time_attack_pressed():
	Global.mode = 'time_attack'
	get_tree().change_scene_to_file("res://scenes/choose_map.tscn")

func _on_drift_pressed():
	Global.mode = 'drift'
	get_tree().change_scene_to_file("res://scenes/choose_map.tscn")

func _on_time_challenge_pressed():
	Global.mode = 'time_chall'
	get_tree().change_scene_to_file("res://scenes/choose_map.tscn")

func _on_race_pressed():
	#Global.mode = 'race'
	#get_tree().change_scene_to_file("res://scenes/choose_map.tscn")
	pass

func _on_main_menu_pressed():
	get_tree().change_scene_to_file("res://scenes/main.tscn")
