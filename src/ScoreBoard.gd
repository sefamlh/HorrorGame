extends Node2D

@onready var hearts = [$Heart, $Heart2, $Heart3]

func update_hearts(player_lives):
	for i in range(3):
		hearts[i].visible = i < player_lives
