extends Node2D

var bridge_built: bool = false


func _ready() -> void:
	$"../PurchaseBridge".purchased.connect(build_bridge)
	if bridge_built == false:
		$Bridgemodel.visible = false
		$StaticBody2D/CollisionShape2D.set_deferred("disabled",false)
	else:
		$Bridgemodel.visible = true
		$StaticBody2D/CollisionShape2D.set_deferred("disabled",true)

	

func build_bridge():
	$Bridgemodel.visible = true
	$StaticBody2D/CollisionShape2D.set_deferred("disabled",true)
