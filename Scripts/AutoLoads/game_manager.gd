extends Node

var player : Player
var camera : Camera2D

func change_scene (scene : PackedScene,player_position : Vector2): # takes in scene to swap to, and global position to place the player on load
	get_tree().change_scene_to_packed(scene)
	await get_tree().process_frame
	get_tree().root.move_child(player, get_tree().root.get_child_count() - 1)
	
	player.global_position = player_position
	camera.global_position = player_position
