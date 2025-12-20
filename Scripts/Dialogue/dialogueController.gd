class_name DialogueController
extends Node

var current_dialogue: Dialogue
var visible_chars: float
var current_line: int

@onready var dialogue_screen: Panel = $"../HUD/DialogueScreen"
@onready var npc_name_text: Label = $"../HUD/DialogueScreen/DialoguePanel/NPCName"
@onready var npc_icon: TextureRect = $"../HUD/DialogueScreen/DialoguePanel/NPCIcon"
@onready var dialogue_text: Label = $"../HUD/DialogueScreen/DialoguePanel/Dialogue"
@onready var player: Player = $".."


func _ready():
	# This will be called when the node enters the scene tree.
	# We will hide the dialogue screen by default.
	close_screen()


func _process(delta):
	# This function runs every frame and will be used for the text animation.
	visible_chars += 30 * delta
	dialogue_text.visible_characters = int(visible_chars)

	if not current_dialogue:
		return
	if Input.is_action_just_pressed("interact"):
		if len(current_dialogue.lines) == current_line + 1:
			if current_dialogue.item_to_give:
				for i in range(current_dialogue.item_to_give_quantity):
					player.inventory.add_item(current_dialogue.item_to_give)
			close_screen()
		else:
			current_line += 1
			_set_line(current_dialogue.lines[current_line])


func close_screen():
	# This function will hide the dialogue UI and restore player control.
	dialogue_screen.visible = false
	current_dialogue = null

	player.toggle_usability(true)


func set_dialogue(dialogue: Dialogue):
	# This function will be called to start a new conversation.
	current_dialogue = dialogue

	dialogue_screen.visible = true
	npc_name_text.text = dialogue.npc_name
	npc_icon.texture = dialogue.npc_icon

	current_line = 0
	_set_line(dialogue.lines[0])

	player.toggle_usability(false)


func _set_line(line: String):
	# This will update the UI to show a specific line of dialogue.
	visible_chars = 0
	dialogue_text.visible_characters = 0
	dialogue_text.text = line
