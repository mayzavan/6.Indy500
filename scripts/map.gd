extends Node

var msec
var seconds
var minutes
var time = 0
var besttime = 1000
var bestmsec
var bestseconds
var bestminutes
var playing = false
var finished = false
var midpoint = false

var tilemap
var tile

var bestdrift :int = 0
var score :int = 0

var player

func _ready():
	player = $Player1
	tilemap = $TileMap
	if Global.mode == 'time_attack' or Global.mode == 'time_chall':
		$Time_Attack.show()
		match Global.chosen_map:
			0:
				load_times(Global.map0_times)
			1:
				load_times(Global.map1_times)
			2:
				load_times(Global.map2_times)
			3:
				load_times(Global.map3_times)
			4:
				load_times(Global.map4_times)
			5:
				load_times(Global.map5_times)
			6:
				load_times(Global.map6_times)
	elif Global.mode == 'drift':
		$Drift.show()
		match Global.chosen_map:
			0:
				load_drifts(Global.map0_drifts)
			1:
				load_drifts(Global.map1_drifts)
			2:
				load_drifts(Global.map2_drifts)
			3:
				load_drifts(Global.map3_drifts)

func _input(event):
	if Input.is_action_just_pressed("Reload"):
		#Global.savefile()
		get_tree().reload_current_scene()
	if Input.is_action_just_pressed("Esc"):
		#Global.savefile()
		get_tree().change_scene_to_file("res://scenes/choose_mode.tscn")

func _process(delta) -> void:
	if Global.mode == 'time_attack' or Global.mode == 'time_chall':
		if playing:
			time += delta
		msec = fmod(time, 1) * 100
		seconds = fmod(time, 60)
		minutes = fmod(time, 3600) / 60
		$Time_Attack/mins.text = "%02d:" % minutes
		$Time_Attack/sec.text = "%02d." % seconds
		$Time_Attack/msec.text = "%03d" % msec
		tile = check_tile()
		if tile == 'Mid':
			midpoint = true
		if tile == 'Start' and !midpoint:
			playing = true
		elif tile == 'Start' and midpoint:
			midpoint = false
			if time < besttime:
				besttime = time
				finish()
			time = 0
	if Global.mode == 'drift':
		$Drift/Score.text = str(score)
		var driftbroke = false
		if player.traction < 0.2 and player.turning and player.colliding == false:
			score += (player.velocity.length()*player.velocity.length())/2 + score*0.001
		elif player.colliding == false and (player.traction > 0.3 or player.turning == false):
			for i in 10:
				await get_tree().create_timer(0.1).timeout
				if player.traction > 0.3 or player.turning == false:
					driftbroke = true
					continue
				elif player.traction < 0.2 or player.turning:
					driftbroke = false
					break
		if score > bestdrift and driftbroke:
			bestdrift = score
			$Drift/Bestscore.text = str(bestdrift)
			save_drift()
			score = 0
		elif player.colliding:
			score = 0

func check_tile():
	var data = tilemap.get_cell_tile_data(0, check_coords())
	if data != null:
		var type = data.get_custom_data('0')
		return type

func check_coords():
	var tile_coords = tilemap.local_to_map(tilemap.to_local($Player1.position))
	return tile_coords

func finish():
	bestmsec = fmod(besttime, 1) * 100
	bestseconds = fmod(besttime, 60)
	bestminutes = fmod(besttime, 3600) / 60
	$Time_Attack/bestmins.text = "%02d:" % bestminutes
	$Time_Attack/bestsec.text = "%02d." % bestseconds
	$Time_Attack/bestmsec.text = "%03d" % bestmsec
	match Global.chosen_map:
		0:
			Global.map0_times[Global.chosen_car] = besttime
		1:
			Global.map1_times[Global.chosen_car] = besttime
		2:
			Global.map2_times[Global.chosen_car] = besttime
		3:
			Global.map3_times[Global.chosen_car] = besttime
		4:
			Global.map4_times[Global.chosen_car] = besttime
		5:
			Global.map5_times[Global.chosen_car] = besttime
	Global.savefile()

func save_drift():
	match Global.chosen_map:
		0:
			Global.map0_drifts[Global.chosen_car] = bestdrift
		1:
			Global.map1_drifts[Global.chosen_car] = bestdrift
		2:
			Global.map2_drifts[Global.chosen_car] = bestdrift
		3:
			Global.map3_drifts[Global.chosen_car] = bestdrift
		4:
			Global.map4_drifts[Global.chosen_car] = bestdrift
		5:
			Global.map5_drifts[Global.chosen_car] = bestdrift
	Global.savefile()

func load_times(number):
	if number[Global.chosen_car] != 0:
		besttime = number[Global.chosen_car]
		var msec = fmod(number[Global.chosen_car], 1) * 100
		var seconds = fmod(number[Global.chosen_car], 60)
		var minutes = fmod(number[Global.chosen_car], 3600) / 60
		$Time_Attack/bestmins.text = "%02d:" % minutes
		$Time_Attack/bestsec.text = "%02d." % seconds
		$Time_Attack/bestmsec.text = "%03d" % msec
	else:
		$Time_Attack/bestmins.text = '--'
		$Time_Attack/bestsec.text = '--'
		$Time_Attack/bestmsec.text = '---'

func load_drifts(number):
	if number[Global.chosen_car] != 0:
		$Drift/Bestscore.text = str(number[Global.chosen_car])
		bestdrift = number[Global.chosen_car]
	else:
		$Drift/Bestscore.text = '----'
