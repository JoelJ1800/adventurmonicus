class_name Player
extends Character

signal UpdatedGold(gold:int)

@onready var inventory:Inventory = $Inventory
@onready var dialogue_controller : DialogueController = $DialogueController
var interaction_controller : InteractionController
@onready var shop_ui : ShopUI = $HUD/ShopScreen

var gold : int = 0

func _ready() -> void:
	if GameManager.player and GameManager.player != self:
		queue_free()
		return
	
	var gold_ui = $HUD/Gold/GoldText
	UpdatedGold.connect(gold_ui._on_updated_gold)
	
	UpdatedGold.emit(gold)
	
	GameManager.player = self
	reparent.call_deferred(get_tree().root)


func _process(_delta: float) -> void:
	move_input = Input.get_vector("move_left","move_right","move_up","move_down")
	
	var mouse_pos: Vector2 = get_global_mouse_position()
	look_direction = global_position.direction_to(mouse_pos)


func _die():
	GameManager.game_over()

func toggle_usability (toggle:bool):
	can_move = toggle
	weapons.can_use = toggle
	if not interaction_controller:
		interaction_controller = $InteractionController
	if toggle:
		interaction_controller.enable()
	else:
		interaction_controller.disable()

func give_gold (amount : int):
	gold += amount
	UpdatedGold.emit(gold)

func take_gold (amount : int):
	gold -= amount
	UpdatedGold.emit(gold)
