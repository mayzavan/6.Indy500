extends Node2D

func _ready():
	Global.loadfile()

func _process(delta):
	$Cars.rotation += deg_to_rad(10*delta)

func _on_play_pressed():
	get_tree().change_scene_to_file("res://scenes/choose_mode.tscn")

func _on_settings_pressed():
	get_tree().change_scene_to_file("res://scenes/settings.tscn")

func _on_credits_pressed():
	pass # Replace with function body.

func _on_quit_pressed():
	Global.savefile()
	get_tree().quit()
