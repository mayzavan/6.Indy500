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

func _ready():
	tilemap = $TileMap
	if Global.mode == 'time_attack' or Global.mode == 'time_chall':
		$Time_Attack.show()
	$Time_Attack/bestmins.text = '--'
	$Time_Attack/bestsec.text = '--'
	$Time_Attack/bestmsec.text = '---'

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
