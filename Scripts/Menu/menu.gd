extends Control

func _on_play_pressed():
	GameManager.play_game()

func _on_quit_pressed():
	get_tree().quit()
