extends Area2D


func _on_body_entered(body: Node2D) -> void:
	await get_tree().process_frame
	get_tree().change_scene_to_file("res://Scenes/Dungeon/Dungeon0.tscn")
