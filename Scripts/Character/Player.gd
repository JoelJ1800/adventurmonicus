class_name Player
extends Character

@onready var inventory:Inventory = $Inventory

func _ready() -> void:
	if GameManager.player and GameManager.player != self:
		queue_free()
		return
		
	GameManager.player = self
	reparent.call_deferred(get_tree().root)

func _process(_delta: float) -> void:
	move_input = Input.get_vector("move_left","move_right","move_up","move_down")
	
	var mouse_pos: Vector2 = get_global_mouse_position()
	look_direction = global_position.direction_to(mouse_pos)


func _die():
	get_tree().reload_current_scene()
