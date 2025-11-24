class_name Shield
extends EquipItem

@onready var sprite : Sprite2D = $Sprite2D
@export var block_sound : AudioStream

func _process(delta: float):
	super._process(delta)
	sprite.global_rotation = 0
	
