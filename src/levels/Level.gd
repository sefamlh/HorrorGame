extends Node

@onready var player = $Player
@onready var monster = $NavigationRegion3D/Monster
@onready var monster2 = $NavigationRegion3D/Monster2
@onready var monster3 = $NavigationRegion3D/Monster3
@onready var hud = $ScoreBoard2
@onready var end_area = $EndArea

var player_lives = 3  # Oyuncunun başlangıç canı

func _ready():
	monster.get_node("Area3D").connect("body_entered", Callable(self, "_on_body_entered"))
	monster2.get_node("Area3D").connect("body_entered", Callable(self, "_on_body_entered"))
	monster3.get_node("Area3D").connect("body_entered", Callable(self, "_on_body_entered"))
	hud.update_hearts(player_lives)

func _physics_process(_delta):
	get_tree().call_group("enemies", "update_target_location", player.global_transform.origin)

func _on_body_entered(body):
	if body == player:
		player_hit()
		

func player_hit():
	player_lives -= 1
	hud.update_hearts(player_lives)
	if player_lives <= 0:
		call_deferred("_change_to_game_over")

func _change_to_game_over():
	get_tree().change_scene_to_file("res://src/GameOver.tscn")
