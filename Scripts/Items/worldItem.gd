class_name WorldItem
extends Area2D

var item: ItemData

@onready var sprite: Sprite2D = $Sprite

var bob_speed: float = 10
var bob_amount: float = 2

@export var test_item: ItemData

func _ready():
	set_item(test_item)


func _process(delta: float) -> void:
	# item bobbing
	pass

func set_item(item:ItemData):
	self.item = item
	sprite.texture = item.icon



func _on_body_entered(body):
	if not body.is_in_group("Player"):
		return
	
	var picked_up = body.inventory.add_item(item)
	if not picked_up:
		return
	
	queue_free()
