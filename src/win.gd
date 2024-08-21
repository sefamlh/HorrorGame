extends Control

func _ready():
	$ExitButton.connect("pressed", Callable(self, "_on_exit_pressed"))
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func _on_exit_pressed():
	get_tree().quit()
