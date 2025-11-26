class_name InteractionController
extends Area2D

@onready var prompt_text : Label = $"../HUD/InteractPrompt"
@onready var player : Player = $".."

var current_interactable : Interactable
var can_interact : bool = true
