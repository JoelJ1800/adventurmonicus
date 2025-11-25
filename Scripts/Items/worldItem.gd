class_name WorldItem
extends Area2D

var item: ItemData

@onready var sprite: Sprite2D = $Sprite2D

var bob_speed: float = 10
var bob_amount: float = 2




func _process(delta: float) -> void:
	# item bobbing
	var time : float = Time.get_unix_time_from_system()
	var offset : float = sin(time * bob_speed) * bob_amount
	sprite.position.y = offset

func set_item(item:ItemData):
	self.item = item
	$Sprite2D.texture = item.icon



func _on_body_entered(body):
	if not body.is_in_group("Player"):
		return
	
	var picked_up = body.inventory.add_item(item)
	if not picked_up:
		return
	
	queue_free()
