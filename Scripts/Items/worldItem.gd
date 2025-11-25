class_name WorldItem
extends Area2D

var item: ItemData

@onready var sprite: Sprite2D = $Sprite

var bob_speed: float = 10
var bob_amount: float = 2

func _process(delta: float) -> void:
	# item bobbing
	pass

func set_item(item:ItemData):
	pass



func _on_body_entered(body):
	pass # Replace with function body.
