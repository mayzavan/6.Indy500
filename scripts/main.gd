extends Node2D

func _ready():
	#Global.loadfile()
	pass

func _on_play_pressed():
	get_tree().change_scene_to_file("res://scenes/choose_mode.tscn")

func _on_settings_pressed():
	pass # Replace with function body.

func _on_credits_pressed():
	pass # Replace with function body.

func _on_quit_pressed():
	#Global.savefile()
	get_tree().quit()
