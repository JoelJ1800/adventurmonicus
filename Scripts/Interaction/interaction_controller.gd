class_name InteractionController
extends Area2D

@onready var prompt_text : Label = $"../HUD/InteractPrompt"
@onready var player : Player = $".."

var current_interactable : Interactable
var can_interact : bool = true

func _process(delta: float) -> void:
	pass

func _check():
	pass

func enable():
	pass

func disable():
	pass


func _on_timer_timeout() -> void:
	_check()
