extends Label


func _process(delta):
	self.text = str(round(1/delta))
