extends Node2D

var map = 0

func _ready():
	if Global.mode == 'time_attack' or Global.mode == 'time_chall':
		$Time_Attack.show()
		load_times(Global.map0_times)
	if Global.mode == 'drift':
		$Drift.show()
		load_drifts(Global.map0_drifts)
	if Global.mode == 'time_chall':
		map = 4
		change_map()

func _on_back_pressed():
	get_tree().change_scene_to_file("res://scenes/choose_mode.tscn")

func _on_go_pressed():
	Global.chosen_map = map
	get_tree().change_scene_to_file("res://scenes/choose_car.tscn")

func _on_next_pressed():
	if Global.mode == 'free':
		if map == 6:
			map = 0
		else:
			map += 1
	elif Global.mode == 'drift' or Global.mode == 'time_attack':
		if map == 3:
			map = 0
		else:
			map += 1
	elif Global.mode == 'time_chall':
		if map == 6:
			map = 4
		else:
			map += 1
	change_map()

func _on_previous_pressed():
	if Global.mode == 'free':
		if map == 0:
			map = 6
		else:
			map -= 1
	elif Global.mode == 'drift' or Global.mode == 'time_attack':
		if map == 0:
			map = 3
		else:
			map -= 1
	elif Global.mode == 'time_chall':
		if map == 4:
			map = 6
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
	$Maps/Map6.hide()
	match map:
		0:
			$Maps/Map0.show()
			load_times(Global.map0_times)
			load_drifts(Global.map0_drifts)
		1:
			$Maps/Map1.show()
			load_times(Global.map1_times)
			load_drifts(Global.map1_drifts)
		2:
			$Maps/Map2.show()
			load_times(Global.map2_times)
			load_drifts(Global.map2_drifts)
		3:
			$Maps/Map3.show()
			load_times(Global.map3_times)
			load_drifts(Global.map3_drifts)
		4:
			$Maps/Map4.show()
			load_times(Global.map4_times)
		5:
			$Maps/Map5.show()
			load_times(Global.map5_times)
		6:
			$Maps/Map6.show()
			load_times(Global.map6_times)

func load_times(number):
	var time:Array = number
	for i in 7:
		var sprite_name = 'Sprite2D' +str(i+1)
		var minutes_path = "Time_Attack/" + sprite_name + "/mins"
		var sec_path = "Time_Attack/" + sprite_name + "/sec"
		var msec_path = "Time_Attack/" + sprite_name + "/msec"
		var minsnode = get_node(minutes_path)
		var secnode = get_node(sec_path)
		var msecnode = get_node(msec_path)
		if time[i] != 0:
			var msec = fmod(time[i], 1) * 100
			var seconds = fmod(time[i], 60)
			var minutes = fmod(time[i], 3600) / 60
			minsnode.text = "%02d:" % minutes
			secnode.text = "%02d." % seconds
			msecnode.text = "%03d" % msec
		else:
			minsnode.text = '--'
			secnode.text = '--'
			msecnode.text = '---'

func load_drifts(number):
	var drift :Array = number
	for i in 7:
		var sprite_name = 'Sprite2D' +str(i+1)
		var score_path = "Drift/" + sprite_name + "/score"
		var scorenode = get_node(score_path)
		if drift[i] != 0:
			scorenode.text = str(drift[i])
		else:
			scorenode.text = '----'
