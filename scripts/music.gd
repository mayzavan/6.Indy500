extends AudioStreamPlayer

var stopped: bool = false

func _process(delta):
	if self.playing == false and stopped == false:
		self.play()
	if stopped == true:
		self.stop()
