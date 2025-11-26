class_name InteractionController
extends Area2D

@onready var prompt_text : Label = $"../HUD/InteractPrompt"
@onready var player : Player = $".."

var current_interactable : Interactable
var can_interact : bool = true

func _process(delta: float) -> void:
	if not current_interactable:
		return
	
	if Input.is_action_just_pressed("interact"):
		current_interactable.try_interact(player)

func _check():
	current_interactable = null
	prompt_text.visible = false 
	
	if not can_interact:
		return
	
	for area in get_overlapping_areas():
		if area is not Interactable:
			continue
		if not area.can_interact:
			continue
		
		current_interactable = area
		prompt_text.text = "[E] - " + area.prompt
		prompt_text.visible = true


func enable():
	can_interact = true

func disable():
	can_interact = false
	current_interactable = null
	prompt_text.visible = false
