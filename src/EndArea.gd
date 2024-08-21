extends Area3D

@onready var player = get_node("/root/Level/Player")

func _ready():
	connect("body_entered", Callable(self, "_on_body_entered"))

func _on_body_entered(body):
	if body == player:
		call_deferred("_change_to_level_two")

func _change_to_level_two():
	get_tree().change_scene_to_file("res://src/levels/LevelTwo.tscn")
