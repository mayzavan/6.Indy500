extends Node

var location = "user://save_data.dat"

var chosen_car = 0
var chosen_map = 0
var mode = 'free'
var highscores : Array

var map0_times: Array
var map1_times: Array
var map2_times: Array
var map3_times: Array
var map4_times: Array
var map5_times: Array
var map6_times: Array

var map0_drifts: Array
var map1_drifts: Array
var map2_drifts: Array
var map3_drifts: Array

func savefile():
	highscores = [
		map0_times,
		map1_times,
		map2_times,
		map3_times,
		map4_times,
		map5_times,
		map6_times,
		map0_drifts,
		map1_drifts,
		map2_drifts,
		map3_drifts]
		
	var file = FileAccess.open(location, FileAccess.WRITE)
	file.store_var(highscores)
	print("game saved")

func loadfile():
	if FileAccess.file_exists(location):
		print("game loaded")
		var file = FileAccess.open(location, FileAccess.READ)
		highscores = file.get_var()
	else:
		print("file not found")
		highscores = [[0,0,0,0,0,0,0],
		[0,0,0,0,0,0,0],
		[0,0,0,0,0,0,0],
		[0,0,0,0,0,0,0],
		[0,0,0,0,0,0,0],
		[0,0,0,0,0,0,0],
		[0,0,0,0,0,0,0],
		[0,0,0,0,0,0,0],
		[0,0,0,0,0,0,0],
		[0,0,0,0,0,0,0],
		[0,0,0,0,0,0,0]]
		
	map0_times = highscores[0]
	map1_times = highscores[1]
	map2_times = highscores[2]
	map3_times = highscores[3]
	map4_times = highscores[4]
	map5_times = highscores[5]
	map6_times = highscores[6]

	map0_drifts = highscores[7]
	map1_drifts = highscores[8]
	map2_drifts = highscores[9]
	map3_drifts = highscores[10]
