extends Control

func _process(delta):
	$FPS_COUNTER.text = str(Engine.get_frames_per_second())
