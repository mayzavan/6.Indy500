extends Node2D

func _ready():
	$yesimsure.hide()

func _on_backbutton_pressed():
	get_tree().change_scene_to_file("res://scenes/main.tscn")

func _on_reset_pressed():
	$yesimsure.show()

func _on_yesimsure_pressed():
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
