extends Area3D

var player

func _ready():
	player = get_node("/root/LevelTwo/Player")
	connect("body_entered", Callable(self, "_on_body_entered"))
		
func _on_body_entered(body):
	if body == player:
		call_deferred("_win_scene")

func _win_scene():
	get_tree().change_scene_to_file("res://src/Win.tscn")
