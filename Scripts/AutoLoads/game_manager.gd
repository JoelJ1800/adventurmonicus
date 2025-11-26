extends Node

var player : Player
var camera : Camera2D

func change_scene (scene : PackedScene,player_position : Vector2):
	get_tree().change_scene_to_packed(scene)
	
	player.global_position = player_position
	camera.global_position = player_position
