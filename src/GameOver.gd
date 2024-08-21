extends Control

var player_lives = 3  # Bu değeri ana sahneden alacağız

func _ready():
	$RestartButton.connect("pressed", Callable(self, "_on_restart_pressed"))
	$ExitButton.connect("pressed", Callable(self, "_on_exit_pressed"))
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func _on_restart_pressed():
	if player_lives > 0:
		var level_scene_path = "res://src/levels/Level.tscn"
		var level_scene_resource = load(level_scene_path)
		if level_scene_resource:
			var level_scene = level_scene_resource.instantiate()
			level_scene.player_lives = player_lives  # Can bilgisini aktarıyoruz
			get_tree().change_scene_to_file("res://src/levels/Level.tscn")
		else:
			print("Error: Cannot load Level scene.")

func _on_exit_pressed():
	get_tree().quit()
